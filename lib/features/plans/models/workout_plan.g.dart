// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkoutPlanOwner _$WorkoutPlanOwnerFromJson(Map<String, dynamic> json) =>
    _WorkoutPlanOwner(
      username: json['username'] as String,
      displayName: json['display_name'] as String?,
      avatarId: (json['avatar_id'] as num?)?.toInt(),
      avatarColor: json['avatar_color'] as String?,
    );

Map<String, dynamic> _$WorkoutPlanOwnerToJson(_WorkoutPlanOwner instance) =>
    <String, dynamic>{
      'username': instance.username,
      'display_name': instance.displayName,
      'avatar_id': instance.avatarId,
      'avatar_color': instance.avatarColor,
    };

_WorkoutPlan _$WorkoutPlanFromJson(Map<String, dynamic> json) => _WorkoutPlan(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  isPublic: json['is_public'] as bool? ?? false,
  ownerId: json['owner_id'] as String?,
  weeks: (json['weeks'] as num?)?.toInt(),
  sessionsPerWeek: (json['sessions_per_week'] as num?)?.toInt(),
  avgDurationMins: (json['avg_duration_mins'] as num?)?.toInt(),
  difficulty: json['difficulty'] as String?,
  equipment: json['equipment'] as String?,
  exercises:
      (json['plan_exercises'] as List<dynamic>?)
          ?.map((e) => PlanExercise.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  owner: json['profiles'] == null
      ? null
      : WorkoutPlanOwner.fromJson(json['profiles'] as Map<String, dynamic>),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$WorkoutPlanToJson(_WorkoutPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'is_public': instance.isPublic,
      'owner_id': instance.ownerId,
      'weeks': instance.weeks,
      'sessions_per_week': instance.sessionsPerWeek,
      'avg_duration_mins': instance.avgDurationMins,
      'difficulty': instance.difficulty,
      'equipment': instance.equipment,
      'plan_exercises': instance.exercises,
      'profiles': instance.owner,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
