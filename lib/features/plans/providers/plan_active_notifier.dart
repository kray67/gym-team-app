import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/plans/models/workout_plan.dart';
import 'package:gym_team/features/plans/providers/plans_provider.dart';
import 'package:gym_team/features/workout/providers/workout_history_provider.dart';

part 'plan_active_notifier.g.dart';

/// Fetches the current user's active plan (full detail with exercises + sets).
/// Returns null when no active plan is set.
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
  bool build() => false; // loading state indicator

  /// Sets the active plan and persists 1RM values.
  /// Throws a [String] error message on failure.
  Future<void> setActivePlan(
      String planId, Map<String, double> oneRMs) async {
    final userId = supabase.auth.currentUser!.id;

    try {
      await supabase
          .from('profiles')
          .update({'active_plan_id': planId}).eq('id', userId);

      for (final entry in oneRMs.entries) {
        await supabase.from('user_plan_1rm').upsert({
          'user_id': userId,
          'plan_id': planId,
          'exercise_id': entry.key,
          'one_rm_kg': entry.value,
          'updated_at': DateTime.now().toIso8601String(),
        }, onConflict: 'user_id,plan_id,exercise_id');
      }

      ref.invalidate(activePlanProvider);
      ref.invalidate(userPlan1rmProvider(planId));
    } catch (e) {
      throw 'Failed to set active plan: $e';
    }
  }

  /// Clears the active plan and records a restart timestamp so that
  /// completed-session counts are reset for this plan.
  /// Throws a [String] error message on failure.
  Future<void> clearActivePlan(String planId) async {
    final userId = supabase.auth.currentUser!.id;
    try {
      await supabase
          .from('profiles')
          .update({'active_plan_id': null}).eq('id', userId);
      await supabase.from('user_plan_progress').upsert({
        'user_id': userId,
        'plan_id': planId,
        'restarted_at': DateTime.now().toIso8601String(),
      }, onConflict: 'user_id,plan_id');
      ref.invalidate(activePlanProvider);
      ref.invalidate(planCompletedSessionsProvider(planId));
    } catch (e) {
      throw 'Failed to clear active plan: $e';
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

  /// Resets plan progress by recording a restart timestamp and updating 1RM
  /// values. Sessions before the restart timestamp are ignored when computing
  /// completed sessions.
  /// Throws a [String] error message on failure.
  Future<void> restartPlan(String planId, Map<String, double> oneRMs) async {
    final userId = supabase.auth.currentUser!.id;
    try {
      await supabase.from('user_plan_progress').upsert({
        'user_id': userId,
        'plan_id': planId,
        'restarted_at': DateTime.now().toIso8601String(),
      }, onConflict: 'user_id,plan_id');

      for (final entry in oneRMs.entries) {
        await supabase.from('user_plan_1rm').upsert({
          'user_id': userId,
          'plan_id': planId,
          'exercise_id': entry.key,
          'one_rm_kg': entry.value,
          'updated_at': DateTime.now().toIso8601String(),
        }, onConflict: 'user_id,plan_id,exercise_id');
      }

      ref.invalidate(userPlan1rmProvider(planId));
      ref.invalidate(planCompletedSessionsProvider(planId));
    } catch (e) {
      throw 'Failed to restart plan: $e';
    }
  }
}
