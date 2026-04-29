import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/plans/models/workout_plan.dart';
import 'package:gym_team/features/plans/providers/plans_provider.dart';
import 'package:gym_team/features/workout/providers/workout_history_provider.dart';

part 'plan_active_notifier.g.dart';

/// Fetches the current user's active plan (full detail with exercises + sets).
/// The active plan is always a personal copy — returns null when none is set.
@riverpod
Future<WorkoutPlan?> activePlan(ActivePlanRef ref) async {
  final userId = supabase.auth.currentUser!.id;
  final profileData = await supabase
      .from('profiles')
      .select('active_plan_id')
      .eq('id', userId)
      .single();
  final planId = profileData['active_plan_id'] as String?;
  if (planId == null) return null;
  return ref.read(planDetailProvider(planId).future);
}

/// Fetches all stored 1RM values for the current user + plan.
/// Returns a map of exerciseId → oneRmKg.
@riverpod
Future<Map<String, double>> userPlan1rm(
    UserPlan1rmRef ref, String planId) async {
  final userId = supabase.auth.currentUser!.id;
  final data = await supabase
      .from('user_plan_1rm')
      .select('exercise_id, one_rm_kg')
      .eq('user_id', userId)
      .eq('plan_id', planId);
  return {
    for (final row in (data as List))
      row['exercise_id'] as String: (row['one_rm_kg'] as num).toDouble()
  };
}

@riverpod
class PlanActiveNotifier extends _$PlanActiveNotifier {
  @override
  bool build() => false;

  /// Creates a personal copy of [sourcePlanId] for the current user.
  ///
  /// If a soft-deleted copy already exists (from a previous activation of the
  /// same source plan), it is restored instead of creating a duplicate.
  /// Returns the copy's plan ID.
  Future<String> _getOrCreateCopy(String sourcePlanId) async {
    final userId = supabase.auth.currentUser!.id;

    // Look for an existing archived copy first.
    final existing = await supabase
        .from('workout_plans')
        .select('id')
        .eq('source_plan_id', sourcePlanId)
        .eq('owner_id', userId)
        .eq('is_deleted', true)
        .maybeSingle();

    if (existing != null) {
      final copyId = existing['id'] as String;
      await supabase
          .from('workout_plans')
          .update({'is_deleted': false}).eq('id', copyId);
      return copyId;
    }

    // Fetch full source plan with exercises and sets.
    final sourceData = await supabase
        .from('workout_plans')
        .select(
            'title, description, is_public, weeks, sessions_per_week, avg_duration_mins, difficulty, equipment, plan_exercises(id, exercise_id, position, goal_type, weight_type, week_number, session_number, superset_group_id, note, plan_exercise_sets(set_number, target_reps, target_reps_max, target_weight, target_rpe, target_rpe_max, is_warmup, weight_increment, target_duration_secs))')
        .eq('id', sourcePlanId)
        .single();

    const uuid = Uuid();
    final copyId = uuid.v4();

    // Insert the plan copy.
    await supabase.from('workout_plans').insert({
      'id': copyId,
      'owner_id': userId,
      'source_plan_id': sourcePlanId,
      'title': sourceData['title'],
      'description': sourceData['description'],
      'is_public': false,
      'is_deleted': false,
      'weeks': sourceData['weeks'],
      'sessions_per_week': sourceData['sessions_per_week'],
      'avg_duration_mins': sourceData['avg_duration_mins'],
      'difficulty': sourceData['difficulty'],
      'equipment': sourceData['equipment'],
    });

    // Deep-copy exercises and their sets.
    final sourceExercises =
        (sourceData['plan_exercises'] as List<dynamic>);
    for (final ex in sourceExercises) {
      final newExId = uuid.v4();
      await supabase.from('plan_exercises').insert({
        'id': newExId,
        'plan_id': copyId,
        'exercise_id': ex['exercise_id'],
        'position': ex['position'],
        'goal_type': ex['goal_type'],
        'weight_type': ex['weight_type'],
        'week_number': ex['week_number'],
        'session_number': ex['session_number'],
        'superset_group_id': ex['superset_group_id'],
        'note': ex['note'],
      });

      final sourceSets = (ex['plan_exercise_sets'] as List<dynamic>);
      if (sourceSets.isNotEmpty) {
        await supabase.from('plan_exercise_sets').insert([
          for (final s in sourceSets)
            {
              'id': uuid.v4(),
              'plan_exercise_id': newExId,
              'set_number': s['set_number'],
              'target_reps': s['target_reps'],
              'target_reps_max': s['target_reps_max'],
              'target_weight': s['target_weight'],
              'target_rpe': s['target_rpe'],
              'target_rpe_max': s['target_rpe_max'],
              'is_warmup': s['is_warmup'],
              'weight_increment': s['weight_increment'],
              'target_duration_secs': s['target_duration_secs'],
            }
        ]);
      }
    }

    return copyId;
  }

  /// Activates a plan by creating (or restoring) a personal copy of
  /// [sourcePlanId]. If another plan is already active its copy is archived.
  /// Throws a [String] error message on failure.
  Future<void> setActivePlan(
      String sourcePlanId, Map<String, double> oneRMs) async {
    final userId = supabase.auth.currentUser!.id;
    try {
      // Archive the current active copy if one exists.
      final profileData = await supabase
          .from('profiles')
          .select('active_plan_id')
          .eq('id', userId)
          .single();
      final currentCopyId = profileData['active_plan_id'] as String?;
      if (currentCopyId != null) {
        await supabase
            .from('workout_plans')
            .update({'is_deleted': true}).eq('id', currentCopyId);
        await supabase.from('user_plan_progress').upsert({
          'user_id': userId,
          'plan_id': currentCopyId,
          'restarted_at': DateTime.now().toIso8601String(),
        }, onConflict: 'user_id,plan_id');
      }

      final copyId = await _getOrCreateCopy(sourcePlanId);

      await supabase
          .from('profiles')
          .update({'active_plan_id': copyId}).eq('id', userId);

      for (final entry in oneRMs.entries) {
        await supabase.from('user_plan_1rm').upsert({
          'user_id': userId,
          'plan_id': copyId,
          'exercise_id': entry.key,
          'one_rm_kg': entry.value,
          'updated_at': DateTime.now().toIso8601String(),
        }, onConflict: 'user_id,plan_id,exercise_id');
      }

      ref.invalidate(activePlanProvider);
      ref.invalidate(userPlan1rmProvider(copyId));
    } catch (e) {
      throw 'Failed to set active plan: $e';
    }
  }

  /// Archives the active copy ([copyPlanId]) and clears the active plan.
  /// Workout session history is preserved because the copy row is soft-deleted
  /// rather than removed.
  /// Throws a [String] error message on failure.
  Future<void> clearActivePlan(String copyPlanId) async {
    final userId = supabase.auth.currentUser!.id;
    try {
      await supabase
          .from('workout_plans')
          .update({'is_deleted': true}).eq('id', copyPlanId);
      await supabase
          .from('profiles')
          .update({'active_plan_id': null}).eq('id', userId);
      await supabase.from('user_plan_progress').upsert({
        'user_id': userId,
        'plan_id': copyPlanId,
        'restarted_at': DateTime.now().toIso8601String(),
      }, onConflict: 'user_id,plan_id');
      ref.invalidate(activePlanProvider);
      ref.invalidate(planCompletedSessionsProvider(copyPlanId));
    } catch (e) {
      throw 'Failed to archive active plan: $e';
    }
  }

  /// Updates a single 1RM entry for the given plan + exercise.
  /// Throws a [String] error message on failure.
  Future<void> update1rm(
      String planId, String exerciseId, double oneRmKg) async {
    final userId = supabase.auth.currentUser!.id;
    try {
      await supabase.from('user_plan_1rm').upsert({
        'user_id': userId,
        'plan_id': planId,
        'exercise_id': exerciseId,
        'one_rm_kg': oneRmKg,
        'updated_at': DateTime.now().toIso8601String(),
      }, onConflict: 'user_id,plan_id,exercise_id');
      ref.invalidate(userPlan1rmProvider(planId));
    } catch (e) {
      throw 'Failed to update 1RM: $e';
    }
  }

  /// Resets progress on the active copy by recording a new restart timestamp.
  /// Sessions logged before this timestamp are excluded from completed-session
  /// counts, giving the user a fresh start without recreating the copy.
  /// Throws a [String] error message on failure.
  Future<void> restartPlan(
      String copyPlanId, Map<String, double> oneRMs) async {
    final userId = supabase.auth.currentUser!.id;
    try {
      await supabase.from('user_plan_progress').upsert({
        'user_id': userId,
        'plan_id': copyPlanId,
        'restarted_at': DateTime.now().toIso8601String(),
      }, onConflict: 'user_id,plan_id');

      for (final entry in oneRMs.entries) {
        await supabase.from('user_plan_1rm').upsert({
          'user_id': userId,
          'plan_id': copyPlanId,
          'exercise_id': entry.key,
          'one_rm_kg': entry.value,
          'updated_at': DateTime.now().toIso8601String(),
        }, onConflict: 'user_id,plan_id,exercise_id');
      }

      ref.invalidate(userPlan1rmProvider(copyPlanId));
      ref.invalidate(planCompletedSessionsProvider(copyPlanId));
    } catch (e) {
      throw 'Failed to restart plan: $e';
    }
  }
}
