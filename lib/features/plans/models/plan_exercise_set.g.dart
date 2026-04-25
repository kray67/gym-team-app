// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_exercise_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanExerciseSet _$PlanExerciseSetFromJson(Map<String, dynamic> json) =>
    _PlanExerciseSet(
      id: json['id'] as String,
      planExerciseId: json['plan_exercise_id'] as String,
      setNumber: (json['set_number'] as num).toInt(),
      targetReps: (json['target_reps'] as num?)?.toInt(),
      targetRepsMax: (json['target_reps_max'] as num?)?.toInt(),
      targetWeight: (json['target_weight'] as num?)?.toDouble(),
      targetRpe: (json['target_rpe'] as num?)?.toDouble(),
      targetRpeMax: (json['target_rpe_max'] as num?)?.toDouble(),
      isWarmup: json['is_warmup'] as bool? ?? false,
      weightIncrement: (json['weight_increment'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PlanExerciseSetToJson(_PlanExerciseSet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plan_exercise_id': instance.planExerciseId,
      'set_number': instance.setNumber,
      'target_reps': instance.targetReps,
      'target_reps_max': instance.targetRepsMax,
      'target_weight': instance.targetWeight,
      'target_rpe': instance.targetRpe,
      'target_rpe_max': instance.targetRpeMax,
      'is_warmup': instance.isWarmup,
      'weight_increment': instance.weightIncrement,
    };
