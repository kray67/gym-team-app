import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/workout/models/workout_session.dart';

part 'workout_history_provider.g.dart';

@riverpod
Future<List<WorkoutSession>> workoutHistory(WorkoutHistoryRef ref) async {
  final userId = supabase.auth.currentUser!.id;
  final data = await supabase
      .from('workout_sessions')
      .select('*, workout_plans(title), session_exercises(id, session_id, exercise_id, position, session_sets(*))')
      .eq('user_id', userId)
      .order('started_at', ascending: false);
  return (data as List).map((e) => WorkoutSession.fromJson(e)).toList();
}

@riverpod
Future<WorkoutSession> workoutDetail(
    WorkoutDetailRef ref, String sessionId) async {
  final data = await supabase
      .from('workout_sessions')
      .select('*, session_exercises(*, exercises(*), session_sets(*))')
      .eq('id', sessionId)
      .single();
  return WorkoutSession.fromJson(data);
}

/// Returns a formatted string like "90 kg × 8" or "× 12" for the last time
/// the current user performed [exerciseId]. Returns null if never done.
@riverpod
Future<String?> previousPerformance(
    PreviousPerformanceRef ref, String exerciseId) async {
  final userId = supabase.auth.currentUser!.id;
  try {
    // Step 1: most recent workout_session that contains this exercise
    final sessions = await supabase
        .from('workout_sessions')
        .select('id, session_exercises!inner(exercise_id)')
        .eq('user_id', userId)
        .eq('session_exercises.exercise_id', exerciseId)
        .order('started_at', ascending: false)
        .limit(1);

    if ((sessions as List).isEmpty) return null;
    final sessionId = sessions[0]['id'] as String;

    // Step 2: fetch the sets from that session_exercise
    final seData = await supabase
        .from('session_exercises')
        .select('id, session_sets(weight_kg, reps, rpe, set_number, completed)')
        .eq('session_id', sessionId)
        .eq('exercise_id', exerciseId)
        .maybeSingle();

    if (seData == null) return null;
    final rawSets = seData['session_sets'] as List?;
    if (rawSets == null || rawSets.isEmpty) return null;

    final sets = rawSets
        .where((s) => s['completed'] == true)
        .toList()
      ..sort((a, b) =>
          (a['set_number'] as int).compareTo(b['set_number'] as int));

    if (sets.isEmpty) return null;
    final s = sets.first;
    final weight = s['weight_kg'];
    final reps = s['reps'];
    final rpe = s['rpe'];

    final parts = <String>[];
    if (weight != null) {
      final w = (weight as num).toDouble();
      parts.add('${w % 1 == 0 ? w.toInt() : w.toStringAsFixed(1)} kg');
    }
    if (reps != null) parts.add('× $reps');
    if (rpe != null) parts.add('@ RPE ${(rpe as num).toStringAsFixed(1)}');
    return parts.isEmpty ? null : parts.join(' ');
  } catch (_) {
    return null;
  }
}

/// Returns the set of (weekNumber, sessionNumber) pairs that have been
/// completed for the given plan by the current user.
/// Only counts sessions started after the most recent plan restart (if any).
@riverpod
Future<Set<(int, int)>> planCompletedSessions(
    PlanCompletedSessionsRef ref, String planId) async {
  final userId = supabase.auth.currentUser!.id;
  try {
    // Check for a plan restart timestamp — ignore sessions before it
    DateTime? restartedAt;
    try {
      final resetRow = await supabase
          .from('user_plan_progress')
          .select('restarted_at')
          .eq('user_id', userId)
          .eq('plan_id', planId)
          .maybeSingle();
      if (resetRow != null && resetRow['restarted_at'] != null) {
        restartedAt = DateTime.parse(resetRow['restarted_at'] as String);
      }
    } catch (_) {
      // Table may not exist yet — treat as no restart
    }

    var query = supabase
        .from('workout_sessions')
        .select('week_number, session_number')
        .eq('plan_id', planId)
        .eq('user_id', userId);

    if (restartedAt != null) {
      query = query.gte('started_at', restartedAt.toIso8601String());
    }

    final data = await query;
    return (data as List)
        .where((row) =>
            row['week_number'] != null && row['session_number'] != null)
        .map<(int, int)>((row) =>
            (row['week_number'] as int, row['session_number'] as int))
        .toSet();
  } catch (_) {
    return {};
  }
}
