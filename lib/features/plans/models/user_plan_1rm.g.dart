// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_plan_1rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserPlan1rm _$UserPlan1rmFromJson(Map<String, dynamic> json) => _UserPlan1rm(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  planId: json['plan_id'] as String,
  exerciseId: json['exercise_id'] as String,
  oneRmKg: (json['one_rm_kg'] as num).toDouble(),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$UserPlan1rmToJson(_UserPlan1rm instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'plan_id': instance.planId,
      'exercise_id': instance.exerciseId,
      'one_rm_kg': instance.oneRmKg,
      'updated_at': instance.updatedAt.toIso8601String(),
    };
