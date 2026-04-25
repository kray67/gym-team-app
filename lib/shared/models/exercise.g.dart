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
  isCustom: json['is_custom'] as bool,
  createdBy: json['created_by'] as String?,
);

Map<String, dynamic> _$ExerciseToJson(_Exercise instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'category': instance.category,
  'muscle_group': instance.muscleGroup,
  'is_custom': instance.isCustom,
  'created_by': instance.createdBy,
};
