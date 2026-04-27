// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Exercise _$ExerciseFromJson(Map<String, dynamic> json) => _Exercise(
  id: json['id'] as String,
  name: json['name'] as String,
  category: json['category'] as String,
  muscleGroup: json['muscle_group'] as String,
  muscles:
      (json['muscles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  isCustom: json['is_custom'] as bool,
  createdBy: json['created_by'] as String?,
  trackingType: json['tracking_type'] as String? ?? 'weight_reps',
);

Map<String, dynamic> _$ExerciseToJson(_Exercise instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'category': instance.category,
  'muscle_group': instance.muscleGroup,
  'muscles': instance.muscles,
  'is_custom': instance.isCustom,
  'created_by': instance.createdBy,
  'tracking_type': instance.trackingType,
};
