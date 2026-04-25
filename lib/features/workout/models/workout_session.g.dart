// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkoutPlanRef _$WorkoutPlanRefFromJson(Map<String, dynamic> json) =>
    _WorkoutPlanRef(title: json['title'] as String);

Map<String, dynamic> _$WorkoutPlanRefToJson(_WorkoutPlanRef instance) =>
    <String, dynamic>{'title': instance.title};

_WorkoutSession _$WorkoutSessionFromJson(Map<String, dynamic> json) =>
    _WorkoutSession(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      planId: json['plan_id'] as String?,
      weekNumber: (json['week_number'] as num?)?.toInt(),
      sessionNumber: (json['session_number'] as num?)?.toInt(),
      startedAt: DateTime.parse(json['started_at'] as String),
      endedAt: json['ended_at'] == null
          ? null
          : DateTime.parse(json['ended_at'] as String),
      durationSecs: (json['duration_secs'] as num?)?.toInt(),
      plan: json['workout_plans'] == null
          ? null
          : WorkoutPlanRef.fromJson(
              json['workout_plans'] as Map<String, dynamic>,
            ),
      exercises:
          (json['session_exercises'] as List<dynamic>?)
              ?.map((e) => SessionExercise.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$WorkoutSessionToJson(_WorkoutSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'plan_id': instance.planId,
      'week_number': instance.weekNumber,
      'session_number': instance.sessionNumber,
      'started_at': instance.startedAt.toIso8601String(),
      'ended_at': instance.endedAt?.toIso8601String(),
      'duration_secs': instance.durationSecs,
      'workout_plans': instance.plan,
      'session_exercises': instance.exercises,
    };
