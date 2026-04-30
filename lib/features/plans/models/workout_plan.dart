import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym_team/features/plans/models/plan_exercise.dart';

part 'workout_plan.freezed.dart';
part 'workout_plan.g.dart';

@freezed
abstract class WorkoutPlanOwner with _$WorkoutPlanOwner {
  const factory WorkoutPlanOwner({
    required String username,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_id') int? avatarId,
    @JsonKey(name: 'avatar_color') String? avatarColor,
    @JsonKey(name: 'is_official') @Default(false) bool isOfficial,
  }) = _WorkoutPlanOwner;

  factory WorkoutPlanOwner.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanOwnerFromJson(json);
}

@freezed
abstract class WorkoutPlan with _$WorkoutPlan {
  const factory WorkoutPlan({
    required String id,
    required String title,
    String? description,
    @JsonKey(name: 'is_public') @Default(false) bool isPublic,
    @JsonKey(name: 'owner_id') String? ownerId,
    int? weeks,
    @JsonKey(name: 'sessions_per_week') int? sessionsPerWeek,
    @JsonKey(name: 'avg_duration_mins') int? avgDurationMins,
    String? difficulty,
    String? equipment,
    @JsonKey(name: 'focus') @Default([]) List<String> focus,
    @JsonKey(name: 'plan_exercises') @Default([]) List<PlanExercise> exercises,
    @JsonKey(name: 'profiles') WorkoutPlanOwner? owner,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'source_plan_id') String? sourcePlanId,
    @JsonKey(name: 'is_deleted') @Default(false) bool isDeleted,
  }) = _WorkoutPlan;

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanFromJson(json);
}
