import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym_team/shared/models/exercise.dart';

part 'active_workout_state.freezed.dart';

@freezed
abstract class ActiveSetEntry with _$ActiveSetEntry {
  const factory ActiveSetEntry({
    required String id,
    required int setNumber,
    int? reps,
    double? weightKg,
    double? rpe,
    @Default(false) bool completed,
    @Default(false) bool isWarmup,
    /// Pre-computed target text shown in TARGET column for plan-based workouts.
    /// Line 1 and line 2 separated by '\n'. Null for free workouts.
    String? targetText,
  }) = _ActiveSetEntry;
}

@freezed
abstract class ActiveExerciseEntry with _$ActiveExerciseEntry {
  const factory ActiveExerciseEntry({
    required String id,
    required Exercise exercise,
    /// 'kg' | 'percent_1rm' | 'rpe'
    @Default('kg') String weightType,
    @Default([]) List<ActiveSetEntry> sets,
    String? supersetGroupId,
    /// Optional coach/user note shown below the muscle group label.
    String? note,
  }) = _ActiveExerciseEntry;
}

@freezed
abstract class ActiveWorkoutState with _$ActiveWorkoutState {
  const factory ActiveWorkoutState({
    required String sessionId,
    String? planId,
    int? weekNumber,
    int? sessionNumber,
    required DateTime startedAt,
    @Default([]) List<ActiveExerciseEntry> exercises,
  }) = _ActiveWorkoutState;
}
