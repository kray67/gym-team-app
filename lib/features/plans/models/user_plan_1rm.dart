import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_plan_1rm.freezed.dart';
part 'user_plan_1rm.g.dart';

@freezed
abstract class UserPlan1rm with _$UserPlan1rm {
  const factory UserPlan1rm({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'plan_id') required String planId,
    @JsonKey(name: 'exercise_id') required String exerciseId,
    @JsonKey(name: 'one_rm_kg') required double oneRmKg,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _UserPlan1rm;

  factory UserPlan1rm.fromJson(Map<String, dynamic> json) =>
      _$UserPlan1rmFromJson(json);
}
