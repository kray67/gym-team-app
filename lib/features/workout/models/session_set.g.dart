// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SessionSet _$SessionSetFromJson(Map<String, dynamic> json) => _SessionSet(
  id: json['id'] as String,
  sessionExerciseId: json['session_exercise_id'] as String,
  setNumber: (json['set_number'] as num).toInt(),
  reps: (json['reps'] as num?)?.toInt(),
  weightKg: (json['weight_kg'] as num?)?.toDouble(),
  durationSecs: (json['duration_secs'] as num?)?.toInt(),
  distanceM: (json['distance_m'] as num?)?.toDouble(),
  completed: json['completed'] as bool? ?? false,
  isWarmup: json['is_warmup'] as bool? ?? false,
);

Map<String, dynamic> _$SessionSetToJson(_SessionSet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'session_exercise_id': instance.sessionExerciseId,
      'set_number': instance.setNumber,
      'reps': instance.reps,
      'weight_kg': instance.weightKg,
      'duration_secs': instance.durationSecs,
      'distance_m': instance.distanceM,
      'completed': instance.completed,
      'is_warmup': instance.isWarmup,
    };
