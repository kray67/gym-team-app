import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/plans/models/plan_editor_state.dart';
import 'package:gym_team/features/plans/models/workout_plan.dart';
import 'package:gym_team/shared/models/exercise.dart';

part 'plan_editor_provider.g.dart';

const _uuid = Uuid();

@Riverpod(keepAlive: true)
class PlanEditorNotifier extends _$PlanEditorNotifier {
  @override
  PlanEditorState? build() => null;

  void startNew() => state = const PlanEditorState();

  void startEdit(WorkoutPlan plan) {
    final sortedExercises = plan.exercises.toList()
      ..sort((a, b) => a.position.compareTo(b.position));
    state = PlanEditorState(
      planId: plan.id,
      title: plan.title,
      description: plan.description ?? '',
      isPublic: plan.isPublic,
      weeks: plan.weeks ?? 4,
      sessionsPerWeek: plan.sessionsPerWeek ?? 3,
      avgDurationMins: plan.avgDurationMins ?? 60,
      difficulty: plan.difficulty ?? 'intermediate',
      equipment: plan.equipment ?? 'commercial_gym',
      exercises: sortedExercises
          .map((pe) {
            final sortedSets = pe.sets.toList()
              ..sort((a, b) => a.setNumber.compareTo(b.setNumber));
            return PlanEditorExercise(
              id: pe.id,
              exercise: pe.exercise!,
              goalType: pe.goalType,
              weightType: pe.weightType,
              weekNumber: pe.weekNumber,
              sessionNumber: pe.sessionNumber,
              supersetGroupId: pe.supersetGroupId,
              sets: sortedSets
                  .map((s) => PlanEditorSet(
                        id: s.id,
                        setNumber: s.setNumber,
                        targetReps: s.targetReps,
                        targetRepsMax: s.targetRepsMax,
                        targetWeight: s.targetWeight,
                        targetRpe: s.targetRpe,
                        targetRpeMax: s.targetRpeMax,
                        isWarmup: s.isWarmup,
                        weightIncrement: s.weightIncrement,
                        targetDurationSecs: s.targetDurationSecs,
                      ))
                  .toList(),
            );
          })
          .toList(),
    );
  }

  void setTitle(String v) => state = state?.copyWith(title: v);
  void setDescription(String v) => state = state?.copyWith(description: v);
  void setIsPublic(bool v) => state = state?.copyWith(isPublic: v);
  void setWeeks(int v) => state = state?.copyWith(weeks: v);
  void setSessionsPerWeek(int v) => state = state?.copyWith(sessionsPerWeek: v);
  void setAvgDurationMins(int v) => state = state?.copyWith(avgDurationMins: v);
  void setDifficulty(String v) => state = state?.copyWith(difficulty: v);
  void setEquipment(String v) => state = state?.copyWith(equipment: v);

  // ── Session-level operations ──────────────────────────────────────────────

  void addExerciseToSession(
      Exercise exercise, int weekNumber, int sessionNumber) {
    final s = state;
    if (s == null) return;
    final isTimeBased = const ['time', 'weight_time', 'distance_time']
        .contains(exercise.trackingType);
    final entry = PlanEditorExercise(
      id: _uuid.v4(),
      exercise: exercise,
      goalType: isTimeBased ? 'time' : 'reps',
      weightType: 'rpe',
      weekNumber: weekNumber,
      sessionNumber: sessionNumber,
      sets: List.generate(
        3,
        (i) => PlanEditorSet(id: _uuid.v4(), setNumber: i + 1),
      ),
    );
    state = s.copyWith(exercises: [...s.exercises, entry]);
  }

  void updateExerciseType(String exerciseId,
      {String? goalType, String? weightType}) {
    final s = state;
    if (s == null) return;
    state = s.copyWith(
      exercises: s.exercises.map((e) {
        if (e.id != exerciseId) return e;
        final newGoalType = goalType ?? e.goalType;
        final newWeightType = weightType ?? e.weightType;
        // Clear incompatible values when switching types
        final updatedSets = e.sets.map((set) {
          var updated = set;
          if (goalType != null && goalType != 'reps_range') {
            updated = updated.copyWith(targetRepsMax: null);
          }
          if (goalType != null && goalType == 'amrap') {
            updated = updated.copyWith(targetReps: null, targetRepsMax: null);
          }
          if (weightType != null) {
            final isProgressive = weightType == 'prev_week_plus' ||
                weightType == 'prev_session_plus';
            if (isProgressive) {
              // Progressive types: clear standard intensity fields
              updated = PlanEditorSet(
                id: updated.id,
                setNumber: updated.setNumber,
                targetReps: updated.targetReps,
                targetRepsMax: updated.targetRepsMax,
                targetWeight: null,
                targetRpe: null,
                targetRpeMax: null,
                isWarmup: updated.isWarmup,
                weightIncrement: updated.weightIncrement,
              );
            } else {
              // Standard types: clear progressive fields + incompatible standard fields
              updated = PlanEditorSet(
                id: updated.id,
                setNumber: updated.setNumber,
                targetReps: updated.targetReps,
                targetRepsMax: updated.targetRepsMax,
                targetWeight:
                    weightType == 'percent_1rm' ? updated.targetWeight : null,
                targetRpe: (weightType == 'rpe' || weightType == 'rpe_range')
                    ? updated.targetRpe
                    : null,
                targetRpeMax:
                    weightType == 'rpe_range' ? updated.targetRpeMax : null,
                isWarmup: updated.isWarmup,
                weightIncrement: null,
              );
            }
          }
          return updated;
        }).toList();
        return e.copyWith(
          goalType: newGoalType,
          weightType: newWeightType,
          sets: updatedSets,
        );
      }).toList(),
    );
  }

  void addSetToExercise(String exerciseId) {
    final s = state;
    if (s == null) return;
    state = s.copyWith(
      exercises: s.exercises.map((e) {
        if (e.id != exerciseId) return e;
        final last = e.sets.isNotEmpty ? e.sets.last : null;
        final newSet = PlanEditorSet(
          id: _uuid.v4(),
          setNumber: e.sets.length + 1,
          targetReps: last?.targetReps,
          targetRepsMax: last?.targetRepsMax,
          targetWeight: last?.targetWeight,
          targetRpe: last?.targetRpe,
          targetRpeMax: last?.targetRpeMax,
          weightIncrement: last?.weightIncrement,
          targetDurationSecs: last?.targetDurationSecs,
          isWarmup: false,
        );
        return e.copyWith(sets: [...e.sets, newSet]);
      }).toList(),
    );
  }

  void removeSetFromExercise(String exerciseId, String setId) {
    final s = state;
    if (s == null) return;
    state = s.copyWith(
      exercises: s.exercises.map((e) {
        if (e.id != exerciseId) return e;
        if (e.sets.length <= 1) return e; // keep at least 1 set
        final filtered = e.sets.where((set) => set.id != setId).toList();
        // Re-number remaining sets
        final renumbered = [
          for (var i = 0; i < filtered.length; i++)
            filtered[i].copyWith(setNumber: i + 1),
        ];
        return e.copyWith(sets: renumbered);
      }).toList(),
    );
  }

  /// Replaces ALL fields of a set at once. Pass values from all controllers
  /// so clearing a field (null) is properly written, not kept from old state.
  void updatePlanSet(
    String exerciseId,
    String setId, {
    required int? targetReps,
    required int? targetRepsMax,
    required double? targetWeight,
    required double? targetRpe,
    required double? targetRpeMax,
    double? weightIncrement,
    int? targetDurationSecs,
  }) {
    final s = state;
    if (s == null) return;
    state = s.copyWith(
      exercises: s.exercises.map((e) {
        if (e.id != exerciseId) return e;
        return e.copyWith(
          sets: e.sets.map((set) {
            if (set.id != setId) return set;
            return PlanEditorSet(
              id: set.id,
              setNumber: set.setNumber,
              targetReps: targetReps,
              targetRepsMax: targetRepsMax,
              targetWeight: targetWeight,
              targetRpe: targetRpe,
              targetRpeMax: targetRpeMax,
              isWarmup: set.isWarmup,
              weightIncrement: weightIncrement,
              targetDurationSecs: targetDurationSecs,
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  void addExercisesToSession(
      List<Exercise> exercises, int weekNumber, int sessionNumber) {
    for (final ex in exercises) {
      addExerciseToSession(ex, weekNumber, sessionNumber);
    }
  }

  void addSupersetToSession(
      List<Exercise> exercises, int weekNumber, int sessionNumber) {
    final s = state;
    if (s == null) return;
    final groupId = _uuid.v4();
    final entries = exercises
        .map((ex) => PlanEditorExercise(
              id: _uuid.v4(),
              exercise: ex,
              goalType: const ['time', 'weight_time', 'distance_time']
                      .contains(ex.trackingType)
                  ? 'time'
                  : 'reps',
              weightType: 'rpe',
              weekNumber: weekNumber,
              sessionNumber: sessionNumber,
              supersetGroupId: groupId,
              sets: List.generate(
                3,
                (i) => PlanEditorSet(id: _uuid.v4(), setNumber: i + 1),
              ),
            ))
        .toList();
    state = s.copyWith(exercises: [...s.exercises, ...entries]);
  }

  void togglePlanSetWarmup(String exerciseId, String setId) {
    final s = state;
    if (s == null) return;
    state = s.copyWith(
      exercises: s.exercises.map((e) {
        if (e.id != exerciseId) return e;
        final updated = e.sets
            .map((set) =>
                set.id == setId ? set.copyWith(isWarmup: !set.isWarmup) : set)
            .toList();
        final warmups = updated.where((set) => set.isWarmup).toList();
        final workSets = updated.where((set) => !set.isWarmup).toList();
        final renumbered = [
          ...warmups,
          ...workSets.asMap().entries
              .map((entry) => entry.value.copyWith(setNumber: entry.key + 1)),
        ];
        return e.copyWith(sets: renumbered);
      }).toList(),
    );
  }

  void removeExerciseFromSession(String id) {
    final s = state;
    if (s == null) return;
    state = s.copyWith(
        exercises: s.exercises.where((e) => e.id != id).toList());
  }

  /// Reorder at the slot level within a session (isolated exercises and superset groups as units).
  void reorderSessionSlots(
      int weekNumber, int sessionNumber, int oldSlot, int newSlot) {
    final s = state;
    if (s == null) return;
    if (newSlot > oldSlot) newSlot--;
    final sessionExs = s.exercises
        .where((e) => e.weekNumber == weekNumber && e.sessionNumber == sessionNumber)
        .toList();
    final others = s.exercises
        .where((e) => !(e.weekNumber == weekNumber && e.sessionNumber == sessionNumber))
        .toList();
    final slots = _buildPlanSlots(sessionExs);
    if (oldSlot < 0 || oldSlot >= slots.length) return;
    final item = slots.removeAt(oldSlot);
    slots.insert(newSlot, item);
    state = s.copyWith(exercises: [...others, ..._flattenPlanSlots(slots)]);
  }

  /// Reorder exercises within a superset group.
  void reorderWithinSuperset(String groupId, int oldIndex, int newIndex) {
    final s = state;
    if (s == null) return;
    if (newIndex > oldIndex) newIndex--;
    final result = List<PlanEditorExercise>.from(s.exercises);
    final group = result.where((e) => e.supersetGroupId == groupId).toList();
    if (oldIndex < 0 || oldIndex >= group.length) return;
    final item = group.removeAt(oldIndex);
    group.insert(newIndex, item);
    int gi = 0;
    for (int i = 0; i < result.length; i++) {
      if (result[i].supersetGroupId == groupId) result[i] = group[gi++];
    }
    state = s.copyWith(exercises: result);
  }

  void removeSuperset(String groupId) {
    final s = state;
    if (s == null) return;
    state = s.copyWith(
      exercises: s.exercises.where((e) => e.supersetGroupId != groupId).toList(),
    );
  }

  void breakSuperset(String groupId) {
    final s = state;
    if (s == null) return;
    state = s.copyWith(
      exercises: s.exercises
          .map((e) => e.supersetGroupId == groupId ? e.copyWith(supersetGroupId: null) : e)
          .toList(),
    );
  }

  void removeFromSuperset(String exerciseId) {
    final s = state;
    if (s == null) return;
    state = s.copyWith(
      exercises: s.exercises
          .map((e) => e.id == exerciseId ? e.copyWith(supersetGroupId: null) : e)
          .toList(),
    );
  }

  static List<dynamic> _buildPlanSlots(List<PlanEditorExercise> exercises) {
    final slots = <dynamic>[];
    int i = 0;
    while (i < exercises.length) {
      final ex = exercises[i];
      if (ex.supersetGroupId == null) {
        slots.add(ex);
        i++;
      } else {
        final gid = ex.supersetGroupId!;
        final group = <PlanEditorExercise>[];
        while (i < exercises.length && exercises[i].supersetGroupId == gid) {
          group.add(exercises[i]);
          i++;
        }
        slots.add(group);
      }
    }
    return slots;
  }

  static List<PlanEditorExercise> _flattenPlanSlots(List<dynamic> slots) {
    final flat = <PlanEditorExercise>[];
    for (final s in slots) {
      if (s is PlanEditorExercise) {
        flat.add(s);
      } else {
        flat.addAll(s as List<PlanEditorExercise>);
      }
    }
    return flat;
  }

  void copySession(int fromWeek, int fromDay, List<(int, int)> targets) {
    final s = state;
    if (s == null) return;
    final source = s.exercises
        .where((e) =>
            e.weekNumber == fromWeek && e.sessionNumber == fromDay)
        .toList();

    var updated = s.exercises.where((e) {
      return !targets
          .any((t) => t.$1 == e.weekNumber && t.$2 == e.sessionNumber);
    }).toList();

    for (final (week, day) in targets) {
      for (final ex in source) {
        updated.add(ex.copyWith(
          id: _uuid.v4(),
          weekNumber: week,
          sessionNumber: day,
          sets: ex.sets
              .map((set) => set.copyWith(id: _uuid.v4()))
              .toList(),
        ));
      }
    }

    state = s.copyWith(exercises: updated);
  }

  /// Copies all days of [fromWeek] to each week in [targetWeeks].
  void copyWeek(int fromWeek, List<int> targetWeeks) {
    final s = state;
    if (s == null) return;
    final allDays = List.generate(s.sessionsPerWeek, (i) => i + 1);
    // Each copySession call re-reads current state, so chaining them works.
    for (final targetWeek in targetWeeks) {
      for (final day in allDays) {
        copySession(fromWeek, day, [(targetWeek, day)]);
      }
    }
  }

  void clearSession(int weekNumber, int sessionNumber) {
    final s = state;
    if (s == null) return;
    state = s.copyWith(
      exercises: s.exercises
          .where((e) =>
              !(e.weekNumber == weekNumber && e.sessionNumber == sessionNumber))
          .toList(),
    );
  }

  Future<String> savePlan() async {
    final s = state;
    if (s == null) throw Exception('No editor state');
    if (s.title.trim().isEmpty) throw Exception('Title is required');

    final userId = supabase.auth.currentUser!.id;
    final String planId;

    final planData = {
      'title': s.title.trim(),
      'description':
          s.description.trim().isEmpty ? null : s.description.trim(),
      'is_public': s.isPublic,
      'weeks': s.weeks,
      'sessions_per_week': s.sessionsPerWeek,
      'avg_duration_mins': s.avgDurationMins,
      'difficulty': s.difficulty,
      'equipment': s.equipment,
    };

    if (s.planId == null) {
      final result = await supabase
          .from('workout_plans')
          .insert({...planData, 'owner_id': userId})
          .select('id')
          .single();
      planId = result['id'] as String;
    } else {
      planId = s.planId!;
      await supabase.from('workout_plans').update(planData).eq('id', planId);
      // Cascade deletes plan_exercise_sets automatically
      await supabase.from('plan_exercises').delete().eq('plan_id', planId);
    }

    // Group exercises by session and assign position within each session
    final bySession = <(int, int), List<PlanEditorExercise>>{};
    for (final pe in s.exercises) {
      bySession.putIfAbsent((pe.weekNumber, pe.sessionNumber), () => []).add(pe);
    }

    for (final entry in bySession.entries) {
      final exercises = entry.value;
      for (var i = 0; i < exercises.length; i++) {
        final pe = exercises[i];
        final peRow = await supabase
            .from('plan_exercises')
            .insert({
              'plan_id': planId,
              'exercise_id': pe.exercise.id,
              'position': i,
              'goal_type': pe.goalType,
              'weight_type': pe.weightType,
              'week_number': pe.weekNumber,
              'session_number': pe.sessionNumber,
              if (pe.supersetGroupId != null)
                'superset_group_id': pe.supersetGroupId,
            })
            .select('id')
            .single();
        final peId = peRow['id'] as String;

        for (final set in pe.sets) {
          await supabase.from('plan_exercise_sets').insert({
            'plan_exercise_id': peId,
            'set_number': set.setNumber,
            'target_reps': set.targetReps,
            'target_reps_max': set.targetRepsMax,
            'target_weight': set.targetWeight,
            'target_rpe': set.targetRpe,
            'target_rpe_max': set.targetRpeMax,
            'is_warmup': set.isWarmup,
            if (set.weightIncrement != null)
              'weight_increment': set.weightIncrement,
            if (set.targetDurationSecs != null)
              'target_duration_secs': set.targetDurationSecs,
          });
        }
      }
    }

    // Write activity feed entry when publishing a new public plan
    if (s.planId == null && s.isPublic) {
      await supabase.from('activity_feed').insert({
        'actor_id': userId,
        'type': 'plan_published',
        'payload': {
          'plan_id': planId,
          'title': s.title.trim(),
        },
      });
    }

    state = null;
    return planId;
  }

  void discard() => state = null;
}
