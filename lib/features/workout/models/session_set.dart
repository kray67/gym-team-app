import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_set.freezed.dart';
part 'session_set.g.dart';

@freezed
abstract class SessionSet with _$SessionSet {
  const factory SessionSet({
    required String id,
    @JsonKey(name: 'session_exercise_id') required String sessionExerciseId,
    @JsonKey(name: 'set_number') required int setNumber,
    int? reps,
    @JsonKey(name: 'weight_kg') double? weightKg,
    @JsonKey(name: 'duration_secs') int? durationSecs,
    @JsonKey(name: 'distance_m') double? distanceM,
    @Default(false) bool completed,
    @JsonKey(name: 'is_warmup') @Default(false) bool isWarmup,
  }) = _SessionSet;

  factory SessionSet.fromJson(Map<String, dynamic> json) =>
      _$SessionSetFromJson(json);
}
