// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SessionExercise _$SessionExerciseFromJson(Map<String, dynamic> json) =>
    _SessionExercise(
      id: json['id'] as String,
      sessionId: json['session_id'] as String,
      exerciseId: json['exercise_id'] as String,
      position: (json['position'] as num).toInt(),
      exercise: json['exercises'] == null
          ? null
          : Exercise.fromJson(json['exercises'] as Map<String, dynamic>),
      sets:
          (json['session_sets'] as List<dynamic>?)
              ?.map((e) => SessionSet.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      supersetGroupId: json['superset_group_id'] as String?,
    );

Map<String, dynamic> _$SessionExerciseToJson(_SessionExercise instance) =>
    <String, dynamic>{
      'id': instance.id,
      'session_id': instance.sessionId,
      'exercise_id': instance.exerciseId,
      'position': instance.position,
      'exercises': instance.exercise,
      'session_sets': instance.sets,
      'superset_group_id': instance.supersetGroupId,
    };
