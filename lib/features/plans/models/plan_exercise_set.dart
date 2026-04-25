import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_exercise_set.freezed.dart';
part 'plan_exercise_set.g.dart';

@freezed
abstract class PlanExerciseSet with _$PlanExerciseSet {
  const factory PlanExerciseSet({
    required String id,
    @JsonKey(name: 'plan_exercise_id') required String planExerciseId,
    @JsonKey(name: 'set_number') required int setNumber,
    @JsonKey(name: 'target_reps') int? targetReps,
    @JsonKey(name: 'target_reps_max') int? targetRepsMax,
    @JsonKey(name: 'target_weight') double? targetWeight, // stores % 1RM value
    @JsonKey(name: 'target_rpe') double? targetRpe,
    @JsonKey(name: 'target_rpe_max') double? targetRpeMax,
    @JsonKey(name: 'is_warmup') @Default(false) bool isWarmup,
    @JsonKey(name: 'weight_increment') double? weightIncrement,
  }) = _PlanExerciseSet;

  factory PlanExerciseSet.fromJson(Map<String, dynamic> json) =>
      _$PlanExerciseSetFromJson(json);
}
