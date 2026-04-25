import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise.freezed.dart';
part 'exercise.g.dart';

@freezed
abstract class Exercise with _$Exercise {
  const factory Exercise({
    required String id,
    required String name,
    required String category,
    @JsonKey(name: 'muscle_group') required String muscleGroup,
    @JsonKey(name: 'is_custom') required bool isCustom,
    @JsonKey(name: 'created_by') String? createdBy,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);
}
