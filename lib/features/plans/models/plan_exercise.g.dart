// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanExercise _$PlanExerciseFromJson(Map<String, dynamic> json) =>
    _PlanExercise(
      id: json['id'] as String,
      planId: json['plan_id'] as String,
      exerciseId: json['exercise_id'] as String,
      position: (json['position'] as num).toInt(),
      goalType: json['goal_type'] as String? ?? 'reps',
      weightType: json['weight_type'] as String? ?? 'percent_1rm',
      weekNumber: (json['week_number'] as num?)?.toInt() ?? 1,
      sessionNumber: (json['session_number'] as num?)?.toInt() ?? 1,
      exercise: json['exercises'] == null
          ? null
          : Exercise.fromJson(json['exercises'] as Map<String, dynamic>),
      sets:
          (json['plan_exercise_sets'] as List<dynamic>?)
              ?.map((e) => PlanExerciseSet.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      supersetGroupId: json['superset_group_id'] as String?,
    );

Map<String, dynamic> _$PlanExerciseToJson(_PlanExercise instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plan_id': instance.planId,
      'exercise_id': instance.exerciseId,
      'position': instance.position,
      'goal_type': instance.goalType,
      'weight_type': instance.weightType,
      'week_number': instance.weekNumber,
      'session_number': instance.sessionNumber,
      'exercises': instance.exercise,
      'plan_exercise_sets': instance.sets,
      'superset_group_id': instance.supersetGroupId,
    };
