import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym_team/features/plans/models/plan_exercise_set.dart';
import 'package:gym_team/shared/models/exercise.dart';

part 'plan_exercise.freezed.dart';
part 'plan_exercise.g.dart';

@freezed
abstract class PlanExercise with _$PlanExercise {
  const factory PlanExercise({
    required String id,
    @JsonKey(name: 'plan_id') required String planId,
    @JsonKey(name: 'exercise_id') required String exerciseId,
    required int position,
    @JsonKey(name: 'goal_type') @Default('reps') String goalType,   // 'reps' | 'reps_range' | 'amrap'
    @JsonKey(name: 'weight_type') @Default('percent_1rm') String weightType, // 'percent_1rm' | 'rpe' | 'rpe_range'
    @JsonKey(name: 'week_number') @Default(1) int weekNumber,
    @JsonKey(name: 'session_number') @Default(1) int sessionNumber,
    @JsonKey(name: 'exercises') Exercise? exercise,
    @JsonKey(name: 'plan_exercise_sets') @Default([]) List<PlanExerciseSet> sets,
    @JsonKey(name: 'superset_group_id') String? supersetGroupId,
  }) = _PlanExercise;

  factory PlanExercise.fromJson(Map<String, dynamic> json) =>
      _$PlanExerciseFromJson(json);
}
