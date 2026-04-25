import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym_team/shared/models/exercise.dart';
import 'package:gym_team/features/workout/models/session_set.dart';

part 'session_exercise.freezed.dart';
part 'session_exercise.g.dart';

@freezed
abstract class SessionExercise with _$SessionExercise {
  const factory SessionExercise({
    required String id,
    @JsonKey(name: 'session_id') required String sessionId,
    @JsonKey(name: 'exercise_id') required String exerciseId,
    required int position,
    @JsonKey(name: 'exercises') Exercise? exercise,
    @JsonKey(name: 'session_sets') @Default([]) List<SessionSet> sets,
    @JsonKey(name: 'superset_group_id') String? supersetGroupId,
  }) = _SessionExercise;

  factory SessionExercise.fromJson(Map<String, dynamic> json) =>
      _$SessionExerciseFromJson(json);
}
