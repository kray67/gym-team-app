import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/workout/models/exercise_record.dart';

part 'exercise_records_provider.g.dart';

/// All personal records for the current user.
///
/// Returns a nested map: exerciseId → recordType → current best value.
/// Used in [ActiveWorkoutScreen] to compute live PR badges during a workout.
@riverpod
Future<Map<String, Map<String, double>>> userExerciseRecords(
    UserExerciseRecordsRef ref) async {
  final userId = supabase.auth.currentUser?.id;
  if (userId == null) return {};
  final rows = await supabase
      .from('exercise_records')
      .select('exercise_id, record_type, value')
      .eq('user_id', userId);
  final result = <String, Map<String, double>>{};
  for (final row in rows as List) {
    final exId = row['exercise_id'] as String;
    final rt = row['record_type'] as String;
    final v = (row['value'] as num).toDouble();
    result.putIfAbsent(exId, () => {})[rt] = v;
  }
  return result;
}

/// Records that were first set (or improved) during a specific workout session.
///
/// Used in [WorkoutSummaryScreen] to show a "New Records" section and in
/// [WorkoutDetailScreen] to badge the specific set rows.
@riverpod
Future<List<ExerciseRecord>> sessionNewRecords(
    SessionNewRecordsRef ref, String sessionId) async {
  final userId = supabase.auth.currentUser?.id;
  if (userId == null) return [];
  try {
    final rows = await supabase
        .from('exercise_records')
        .select('*, exercises(name)')
        .eq('session_id', sessionId)
        .eq('user_id', userId);
    return (rows as List)
        .map((r) => ExerciseRecord.fromRow(r as Map<String, dynamic>))
        .toList();
  } catch (_) {
    return [];
  }
}

/// Set IDs (session_sets.id) that achieved a PR during [sessionId].
///
/// Used in [WorkoutDetailScreen] to badge individual set rows.
@riverpod
Future<Set<String>> sessionPrSetIds(
    SessionPrSetIdsRef ref, String sessionId) async {
  final records = await ref.watch(sessionNewRecordsProvider(sessionId).future);
  return records.map((r) => r.setId).whereType<String>().toSet();
}
