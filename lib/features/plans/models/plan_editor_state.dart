import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym_team/shared/models/exercise.dart';

part 'plan_editor_state.freezed.dart';

@freezed
abstract class PlanEditorSet with _$PlanEditorSet {
  const factory PlanEditorSet({
    required String id,
    required int setNumber,
    int? targetReps,
    int? targetRepsMax,
    double? targetWeight, // % 1RM value
    double? targetRpe,
    double? targetRpeMax,
    @Default(false) bool isWarmup,
    double? weightIncrement,
    int? targetDurationSecs,
  }) = _PlanEditorSet;
}

@freezed
abstract class PlanEditorExercise with _$PlanEditorExercise {
  const factory PlanEditorExercise({
    required String id,
    required Exercise exercise,
    @Default('reps') String goalType,       // 'reps' | 'reps_range' | 'amrap' | 'time'
    @Default('percent_1rm') String weightType, // 'percent_1rm' | 'rpe' | 'rpe_range'
    @Default([]) List<PlanEditorSet> sets,
    @Default(1) int weekNumber,
    @Default(1) int sessionNumber,
    String? supersetGroupId,
    String? note,
  }) = _PlanEditorExercise;
}

@freezed
abstract class PlanEditorState with _$PlanEditorState {
  const factory PlanEditorState({
    String? planId,
    @Default('') String title,
    @Default('') String description,
    @Default(false) bool isPublic,
    @Default(4) int weeks,
    @Default(3) int sessionsPerWeek,
    @Default(60) int avgDurationMins,
    @Default('intermediate') String difficulty,
    @Default('commercial_gym') String equipment,
    @Default([]) List<PlanEditorExercise> exercises,
    @Default(false) bool isCopy,
  }) = _PlanEditorState;
}
