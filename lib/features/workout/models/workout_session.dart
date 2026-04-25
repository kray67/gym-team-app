import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym_team/features/workout/models/session_exercise.dart';

part 'workout_session.freezed.dart';
part 'workout_session.g.dart';

@freezed
abstract class WorkoutPlanRef with _$WorkoutPlanRef {
  const factory WorkoutPlanRef({
    required String title,
  }) = _WorkoutPlanRef;

  factory WorkoutPlanRef.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanRefFromJson(json);
}

@freezed
abstract class WorkoutSession with _$WorkoutSession {
  const factory WorkoutSession({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'plan_id') String? planId,
    @JsonKey(name: 'week_number') int? weekNumber,
    @JsonKey(name: 'session_number') int? sessionNumber,
    @JsonKey(name: 'started_at') required DateTime startedAt,
    @JsonKey(name: 'ended_at') DateTime? endedAt,
    @JsonKey(name: 'duration_secs') int? durationSecs,
    @JsonKey(name: 'workout_plans') WorkoutPlanRef? plan,
    @JsonKey(name: 'session_exercises') @Default([]) List<SessionExercise> exercises,
  }) = _WorkoutSession;

  factory WorkoutSession.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSessionFromJson(json);
}
