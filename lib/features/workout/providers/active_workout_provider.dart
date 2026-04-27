import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/shared/models/exercise.dart';
import 'package:gym_team/features/plans/models/workout_plan.dart';
import 'package:gym_team/features/workout/models/active_workout_state.dart';

part 'active_workout_provider.g.dart';

const _uuid = Uuid();

@Riverpod(keepAlive: true)
class ActiveWorkoutNotifier extends _$ActiveWorkoutNotifier {
  @override
  ActiveWorkoutState? build() => null;

  void startWorkout() {
    state = ActiveWorkoutState(
      sessionId: _uuid.v4(),
      startedAt: DateTime.now(),
    );
  }

  void addExercise(Exercise exercise) {
    final current = state;
    if (current == null) return;
    state = current.copyWith(
      exercises: [
        ...current.exercises,
        ActiveExerciseEntry(
          id: _uuid.v4(),
          exercise: exercise,
          weightType: 'kg',
          sets: [_newSet(1)],
        ),
      ],
    );
  }

  void addExercises(List<Exercise> exercises) {
    for (final ex in exercises) {
      addExercise(ex);
    }
  }

  void addSuperset(List<Exercise> exercises) {
    final current = state;
    if (current == null) return;
    final groupId = _uuid.v4();
    state = current.copyWith(
      exercises: [
        ...current.exercises,
        ...exercises.map((ex) => ActiveExerciseEntry(
              id: _uuid.v4(),
              exercise: ex,
              weightType: 'kg',
              supersetGroupId: groupId,
              sets: [_newSet(1)],
            )),
      ],
    );
  }

  /// Reorder at the slot level (isolated exercises and superset groups as units).
  void reorderSlot(int oldSlot, int newSlot) {
    final current = state;
    if (current == null) return;
    if (newSlot > oldSlot) newSlot--;
    final slots = _buildSlots(current.exercises);
    if (oldSlot < 0 || oldSlot >= slots.length) return;
    final item = slots.removeAt(oldSlot);
    slots.insert(newSlot, item);
    state = current.copyWith(exercises: _flattenSlots(slots));
  }

  /// Reorder exercises within a superset group.
  void reorderWithinSuperset(String groupId, int oldIndex, int newIndex) {
    final current = state;
    if (current == null) return;
    if (newIndex > oldIndex) newIndex--;
    final result = List<ActiveExerciseEntry>.from(current.exercises);
    final group = result.where((e) => e.supersetGroupId == groupId).toList();
    if (oldIndex < 0 || oldIndex >= group.length) return;
    final item = group.removeAt(oldIndex);
    group.insert(newIndex, item);
    int gi = 0;
    for (int i = 0; i < result.length; i++) {
      if (result[i].supersetGroupId == groupId) result[i] = group[gi++];
    }
    state = current.copyWith(exercises: result);
  }

  void removeSuperset(String groupId) {
    final current = state;
    if (current == null) return;
    state = current.copyWith(
      exercises: current.exercises.where((e) => e.supersetGroupId != groupId).toList(),
    );
  }

  void breakSuperset(String groupId) {
    final current = state;
    if (current == null) return;
    state = current.copyWith(
      exercises: current.exercises
          .map((e) => e.supersetGroupId == groupId ? e.copyWith(supersetGroupId: null) : e)
          .toList(),
    );
  }

  /// Creates a new superset from the given exercise IDs (which must currently
  /// be isolated). Requires at least 2 IDs. All selected exercises are moved
  /// together (consecutive) at the position of the first selected exercise.
  void formSuperset(List<String> exerciseIds) {
    final current = state;
    if (current == null || exerciseIds.length < 2) return;
    final groupId = _uuid.v4();

    // Tag selected exercises with the new groupId.
    final tagged = current.exercises
        .map((e) => exerciseIds.contains(e.id)
            ? e.copyWith(supersetGroupId: groupId)
            : e)
        .toList();

    // Find position of the first selected exercise; move all selected there.
    final firstPos =
        tagged.indexWhere((e) => exerciseIds.contains(e.id));
    final selected =
        tagged.where((e) => exerciseIds.contains(e.id)).toList();
    final rest =
        tagged.where((e) => !exerciseIds.contains(e.id)).toList();
    rest.insertAll(firstPos.clamp(0, rest.length), selected);

    state = current.copyWith(exercises: rest);
  }

  /// Adds isolated exercises (by ID) to an existing superset group.
  /// Moves the newly added exercises next to the existing group members
  /// so they are consecutive in the list.
  void addExercisesToSuperset(String groupId, List<String> exerciseIds) {
    final current = state;
    if (current == null || exerciseIds.isEmpty) return;

    // Tag selected exercises with the existing groupId.
    final tagged = current.exercises
        .map((e) => exerciseIds.contains(e.id)
            ? e.copyWith(supersetGroupId: groupId)
            : e)
        .toList();

    // Separate: exercises already in this group (original members) vs new ones.
    final originalMembers =
        tagged.where((e) => e.supersetGroupId == groupId && !exerciseIds.contains(e.id)).toList();
    final newMembers =
        tagged.where((e) => exerciseIds.contains(e.id)).toList();

    // Build final list: non-new exercises in order, new members inserted
    // right after the last original group member.
    final rest = tagged.where((e) => !exerciseIds.contains(e.id)).toList();
    final insertAtRest = originalMembers.isNotEmpty
        ? rest.indexWhere((e) => e == originalMembers.last)
        : -1;
    final pos = insertAtRest == -1 ? rest.length : insertAtRest + 1;
    rest.insertAll(pos, newMembers);

    state = current.copyWith(exercises: rest);
  }

  /// Sets (or clears) the note for an exercise entry.
  void setNote(String exerciseId, String? note) {
    final current = state;
    if (current == null) return;
    state = current.copyWith(
      exercises: current.exercises
          .map((e) =>
              e.id == exerciseId ? e.copyWith(note: note?.isEmpty == true ? null : note) : e)
          .toList(),
    );
  }

  void removeFromSuperset(String exerciseId) {
    final current = state;
    if (current == null) return;
    state = current.copyWith(
      exercises: current.exercises
          .map((e) => e.id == exerciseId ? e.copyWith(supersetGroupId: null) : e)
          .toList(),
    );
  }

  static List<dynamic> _buildSlots(List<ActiveExerciseEntry> exercises) {
    final slots = <dynamic>[];
    int i = 0;
    while (i < exercises.length) {
      final ex = exercises[i];
      if (ex.supersetGroupId == null) {
        slots.add(ex);
        i++;
      } else {
        final gid = ex.supersetGroupId!;
        final group = <ActiveExerciseEntry>[];
        while (i < exercises.length && exercises[i].supersetGroupId == gid) {
          group.add(exercises[i]);
          i++;
        }
        slots.add(group);
      }
    }
    return slots;
  }

  static List<ActiveExerciseEntry> _flattenSlots(List<dynamic> slots) {
    final flat = <ActiveExerciseEntry>[];
    for (final s in slots) {
      if (s is ActiveExerciseEntry) {
        flat.add(s);
      } else {
        flat.addAll(s as List<ActiveExerciseEntry>);
      }
    }
    return flat;
  }

  void toggleSetWarmup(String exerciseId, String setId) {
    final current = state;
    if (current == null) return;
    state = current.copyWith(
      exercises: current.exercises.map((e) {
        if (e.id != exerciseId) return e;
        final updated = e.sets
            .map((s) => s.id == setId ? s.copyWith(isWarmup: !s.isWarmup) : s)
            .toList();
        final warmups = updated.where((s) => s.isWarmup).toList();
        final workSets = updated.where((s) => !s.isWarmup).toList();
        final renumbered = [
          ...warmups,
          ...workSets.asMap().entries
              .map((entry) => entry.value.copyWith(setNumber: entry.key + 1)),
        ];
        return e.copyWith(sets: renumbered);
      }).toList(),
    );
  }

  void swapExercise(String exerciseId, Exercise newExercise) {
    final current = state;
    if (current == null) return;
    state = current.copyWith(
      exercises: current.exercises.map((e) {
        if (e.id != exerciseId) return e;
        return e.copyWith(exercise: newExercise);
      }).toList(),
    );
  }

  void removeSet(String exerciseId, String setId) {
    final current = state;
    if (current == null) return;
    state = current.copyWith(
      exercises: current.exercises.map((e) {
        if (e.id != exerciseId) return e;
        final remaining = e.sets.where((s) => s.id != setId).toList();
        // Renumber work sets; warm-ups stay at top without a number
        final warmups = remaining.where((s) => s.isWarmup).toList();
        final workSets = remaining.where((s) => !s.isWarmup).toList();
        final renumbered = [
          ...warmups,
          ...workSets.asMap().entries
              .map((entry) => entry.value.copyWith(setNumber: entry.key + 1)),
        ];
        return e.copyWith(sets: renumbered);
      }).toList(),
    );
  }

  void addSet(String exerciseId) {
    final current = state;
    if (current == null) return;
    state = current.copyWith(
      exercises: current.exercises.map((e) {
        if (e.id != exerciseId) return e;
        // Copy weight/reps from the last set as a convenience.
        // Number is based on work sets only (warmups don't count).
        final last = e.sets.isNotEmpty ? e.sets.last : null;
        final workCount = e.sets.where((s) => !s.isWarmup).length;
        return e.copyWith(
            sets: [...e.sets, _newSet(workCount + 1, weightKg: last?.weightKg, reps: last?.reps, durationSecs: last?.durationSecs, distanceM: last?.distanceM)]);
      }).toList(),
    );
  }

  void updateSet(
    String exerciseId,
    String setId, {
    int? reps,
    double? weightKg,
    double? rpe,
    int? durationSecs,
    double? distanceM,
  }) {
    final current = state;
    if (current == null) return;
    state = current.copyWith(
      exercises: current.exercises.map((e) {
        if (e.id != exerciseId) return e;
        return e.copyWith(
          sets: e.sets.map((s) {
            if (s.id != setId) return s;
            return s.copyWith(
              reps: reps ?? s.reps,
              weightKg: weightKg ?? s.weightKg,
              rpe: rpe ?? s.rpe,
              durationSecs: durationSecs ?? s.durationSecs,
              distanceM: distanceM ?? s.distanceM,
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  void toggleSetCompleted(String exerciseId, String setId) {
    final current = state;
    if (current == null) return;
    state = current.copyWith(
      exercises: current.exercises.map((e) {
        if (e.id != exerciseId) return e;
        return e.copyWith(
          sets: e.sets.map((s) {
            if (s.id != setId) return s;
            return s.copyWith(completed: !s.completed);
          }).toList(),
        );
      }).toList(),
    );
  }

  void removeExercise(String exerciseId) {
    final current = state;
    if (current == null) return;
    state = current.copyWith(
      exercises: current.exercises.where((e) => e.id != exerciseId).toList(),
    );
  }

  Future<void> finishWorkout() async {
    final current = state;
    if (current == null) return;

    final endedAt = DateTime.now();
    final durationSecs = endedAt.difference(current.startedAt).inSeconds;
    final userId = supabase.auth.currentUser!.id;

    await supabase.from('workout_sessions').insert({
      'id': current.sessionId,
      'user_id': userId,
      if (current.planId != null) 'plan_id': current.planId,
      if (current.weekNumber != null) 'week_number': current.weekNumber,
      if (current.sessionNumber != null) 'session_number': current.sessionNumber,
      'started_at': current.startedAt.toIso8601String(),
      'ended_at': endedAt.toIso8601String(),
      'duration_secs': durationSecs,
    });

    // Collect completed non-warmup sets with their DB-assigned IDs for PR detection.
    final List<String> prExerciseIds = [];
    final List<String> prSetDbIds = [];
    final List<ActiveSetEntry> prSets = [];

    for (var i = 0; i < current.exercises.length; i++) {
      final entry = current.exercises[i];
      final seRow = await supabase
          .from('session_exercises')
          .insert({
            'session_id': current.sessionId,
            'exercise_id': entry.exercise.id,
            'position': i,
            if (entry.supersetGroupId != null)
              'superset_group_id': entry.supersetGroupId,
            if (entry.note != null && entry.note!.isNotEmpty)
              'note': entry.note,
          })
          .select('id')
          .single();

      final seId = seRow['id'] as String;

      for (final set in entry.sets) {
        final setRow = await supabase
            .from('session_sets')
            .insert({
              'session_exercise_id': seId,
              'set_number': set.setNumber,
              'reps': set.reps,
              'weight_kg': set.weightKg,
              if (set.rpe != null) 'rpe': set.rpe,
              if (set.durationSecs != null) 'duration_secs': set.durationSecs,
              if (set.distanceM != null) 'distance_m': set.distanceM,
              'completed': set.completed,
              'is_warmup': set.isWarmup,
            })
            .select('id')
            .single();

        if (set.completed && !set.isWarmup) {
          prExerciseIds.add(entry.exercise.id);
          prSetDbIds.add(setRow['id'] as String);
          prSets.add(set);
        }
      }
    }

    // Write activity feed entry with full exercise/set summary (warm-ups excluded)
    await supabase.from('activity_feed').insert({
      'actor_id': userId,
      'type': 'workout_completed',
      'payload': {
        'session_id': current.sessionId,
        'duration_secs': durationSecs,
        'exercise_count': current.exercises.length,
        'exercises': current.exercises.map((e) => {
          'name': e.exercise.name,
          'weight_type': e.weightType,
          'sets': e.sets
              .where((s) => s.completed && !s.isWarmup)
              .map((s) => {
                    'set_number': s.setNumber,
                    'reps': s.reps,
                    'weight_kg': s.weightKg,
                    if (s.rpe != null) 'rpe': s.rpe,
                  })
              .toList(),
        }).toList(),
      },
    });

    // Detect and persist personal records (errors are non-fatal).
    try {
      await _detectAndSavePrs(
        userId: userId,
        sessionId: current.sessionId,
        exerciseIds: prExerciseIds,
        setDbIds: prSetDbIds,
        sets: prSets,
        exerciseNames: {
          for (final e in current.exercises) e.exercise.id: e.exercise.name,
        },
      );
    } catch (_) {}

    state = null;
  }

  /// Groups [sets] by exercise, computes the 4 record types, fetches existing
  /// records, and upserts any improvements. Writes a `record_set` feed entry
  /// when at least one new PR is achieved.
  Future<void> _detectAndSavePrs({
    required String userId,
    required String sessionId,
    required List<String> exerciseIds,
    required List<String> setDbIds,
    required List<ActiveSetEntry> sets,
    required Map<String, String> exerciseNames,
  }) async {
    if (exerciseIds.isEmpty) return;

    // Group sets by exerciseId.
    final grouped = <String, List<({String setDbId, ActiveSetEntry set})>>{};
    for (var i = 0; i < exerciseIds.length; i++) {
      grouped
          .putIfAbsent(exerciseIds[i], () => [])
          .add((setDbId: setDbIds[i], set: sets[i]));
    }

    // Fetch existing records for all exercises in this workout.
    final uniqueExerciseIds = grouped.keys.toList();
    final existingRows = await supabase
        .from('exercise_records')
        .select('exercise_id, record_type, value')
        .eq('user_id', userId)
        .inFilter('exercise_id', uniqueExerciseIds);

    final existing = <String, Map<String, double>>{};
    for (final row in existingRows as List) {
      final exId = row['exercise_id'] as String;
      final rt = row['record_type'] as String;
      final v = (row['value'] as num).toDouble();
      existing.putIfAbsent(exId, () => {})[rt] = v;
    }

    // Compute best values from this workout per exercise.
    final upserts = <Map<String, dynamic>>[];
    final now = DateTime.now().toIso8601String();

    for (final entry in grouped.entries) {
      final exerciseId = entry.key;
      final items = entry.value;
      final exExisting = existing[exerciseId] ?? {};

      double? bestWeight;
      double? bestVolume;
      double? bestEpley;
      String? bestWeightSetId, bestVolumeSetId, bestEpleySetId;

      for (final item in items) {
        final w = item.set.weightKg;
        final r = item.set.reps;
        if (w != null && (bestWeight == null || w > bestWeight)) {
          bestWeight = w;
          bestWeightSetId = item.setDbId;
        }
        if (w != null && r != null) {
          final vol = w * r;
          if (bestVolume == null || vol > bestVolume) {
            bestVolume = vol;
            bestVolumeSetId = item.setDbId;
          }
          final epley = w * (1 + r / 30.0);
          if (bestEpley == null || epley > bestEpley) {
            bestEpley = epley;
            bestEpleySetId = item.setDbId;
          }
        }
      }

      void maybeUpsert(String type, double? val, String? setId) {
        if (val == null) return;
        final prev = exExisting[type];
        if (prev == null || val > prev) {
          upserts.add({
            'user_id': userId,
            'exercise_id': exerciseId,
            'record_type': type,
            'value': val,
            'session_id': sessionId,
            'set_id': setId,
            'achieved_at': now,
          });
        }
      }

      maybeUpsert('max_weight', bestWeight, bestWeightSetId);
      maybeUpsert('max_volume', bestVolume, bestVolumeSetId);
      maybeUpsert('estimated_1rm', bestEpley, bestEpleySetId);
    }

    if (upserts.isEmpty) return;

    await supabase
        .from('exercise_records')
        .upsert(upserts, onConflict: 'user_id,exercise_id,record_type');

    // Build record_set feed entry payload.
    final recordsByExercise = <String, List<String>>{};
    for (final u in upserts) {
      recordsByExercise
          .putIfAbsent(u['exercise_id'] as String, () => [])
          .add(u['record_type'] as String);
    }
    await supabase.from('activity_feed').insert({
      'actor_id': userId,
      'type': 'record_set',
      'payload': {
        'session_id': sessionId,
        'records': recordsByExercise.entries.map((e) => {
              'exercise_id': e.key,
              'exercise_name': exerciseNames[e.key] ?? 'Exercise',
              'record_types': e.value,
            }).toList(),
      },
    });
  }

  Future<void> startWorkoutFromPlan(
    WorkoutPlan plan,
    int weekNumber,
    int dayNumber, {
    Map<String, double> oneRMs = const {},
  }) async {
    final sessionExercises = plan.exercises
        .where((pe) =>
            pe.weekNumber == weekNumber && pe.sessionNumber == dayNumber)
        .toList()
      ..sort((a, b) => a.position.compareTo(b.position));

    // Pre-fetch previous session weights for progressive load types.
    // Map of exerciseId → list of weights (per set, ordered by set_number).
    final prevWeekWeights = <String, List<double?>>{};
    final prevSessionWeights = <String, List<double?>>{};

    final needsPrevWeek = sessionExercises.any((pe) =>
        pe.sets.any((s) => pe.weightType == 'prev_week_plus'));
    final needsPrevSession = sessionExercises.any((pe) =>
        pe.sets.any((s) => pe.weightType == 'prev_session_plus'));

    if (needsPrevWeek && weekNumber > 1) {
      // Find completed sessions for plan + user at week (weekNumber-1), same day
      try {
        final rows = await supabase
            .from('workout_sessions')
            .select('id')
            .eq('plan_id', plan.id)
            .eq('user_id', supabase.auth.currentUser!.id)
            .eq('week_number', weekNumber - 1)
            .eq('session_number', dayNumber)
            .order('started_at', ascending: false)
            .limit(1);
        if ((rows as List).isNotEmpty) {
          final sessionId = rows.first['id'] as String;
          await _loadPrevWeights(
              sessionId, sessionExercises, prevWeekWeights);
        }
      } catch (_) {}
    }

    if (needsPrevSession) {
      // Find most recent completed session for this plan + user
      try {
        final rows = await supabase
            .from('workout_sessions')
            .select('id')
            .eq('plan_id', plan.id)
            .eq('user_id', supabase.auth.currentUser!.id)
            .not('week_number', 'is', null)
            .order('started_at', ascending: false)
            .limit(1);
        if ((rows as List).isNotEmpty) {
          final sessionId = rows.first['id'] as String;
          await _loadPrevWeights(
              sessionId, sessionExercises, prevSessionWeights);
        }
      } catch (_) {}
    }

    state = ActiveWorkoutState(
      sessionId: _uuid.v4(),
      planId: plan.id,
      weekNumber: weekNumber,
      sessionNumber: dayNumber,
      startedAt: DateTime.now(),
      exercises: sessionExercises.map((pe) {
        // Map rpe_range / progressive types to 'rpe' or 'kg' for execution
        final String activeWeightType;
        if (pe.weightType == 'rpe_range' || pe.weightType == 'rpe') {
          activeWeightType = 'rpe';
        } else if (pe.weightType == 'prev_week_plus' ||
            pe.weightType == 'prev_session_plus') {
          activeWeightType = 'kg';
        } else {
          activeWeightType = pe.weightType; // percent_1rm or kg
        }

        final sortedSets = pe.sets.toList()
          ..sort((a, b) => a.setNumber.compareTo(b.setNumber));
        final sets = sortedSets.isEmpty
            ? [_newSet(1)]
            : sortedSets.asMap().entries.map((entry) {
                final idx = entry.key;
                final s = entry.value;
                double? weight;
                double? rpe;

                if (pe.weightType == 'percent_1rm' &&
                    s.targetWeight != null) {
                  final oneRM = oneRMs[pe.exerciseId];
                  if (oneRM != null) {
                    weight = ((s.targetWeight! / 100 * oneRM) / 2.5)
                            .round() *
                        2.5;
                  }
                } else if (pe.weightType == 'prev_week_plus') {
                  final prevList = prevWeekWeights[pe.exerciseId];
                  final prevW =
                      prevList != null && idx < prevList.length
                          ? prevList[idx]
                          : null;
                  if (prevW != null && s.weightIncrement != null) {
                    weight = ((prevW + s.weightIncrement!) / 2.5).round() *
                        2.5;
                  }
                } else if (pe.weightType == 'prev_session_plus') {
                  final prevList = prevSessionWeights[pe.exerciseId];
                  final prevW =
                      prevList != null && idx < prevList.length
                          ? prevList[idx]
                          : null;
                  if (prevW != null && s.weightIncrement != null) {
                    weight = ((prevW + s.weightIncrement!) / 2.5).round() *
                        2.5;
                  }
                }

                if (pe.weightType == 'rpe' || pe.weightType == 'rpe_range') {
                  rpe = s.targetRpe;
                }

                // For reps_range use the min (targetReps) as the target
                final reps =
                    pe.goalType == 'amrap' ? null : s.targetReps;

                // Build TARGET text for display in the set table
                final targetText = _buildTargetText(pe, s, weight);

                return _newSet(s.setNumber,
                    weightKg: weight,
                    reps: reps,
                    rpe: rpe,
                    targetText: targetText,
                    isWarmup: s.isWarmup);
              }).toList();

        return ActiveExerciseEntry(
          id: _uuid.v4(),
          exercise: pe.exercise!,
          weightType: activeWeightType,
          sets: sets,
        );
      }).toList(),
    );
  }

  /// Loads weight_kg values from a past session into [out], keyed by exerciseId.
  Future<void> _loadPrevWeights(
    String sessionId,
    List<dynamic> planExercises,
    Map<String, List<double?>> out,
  ) async {
    final exerciseIds =
        planExercises.map((pe) => pe.exerciseId as String).toSet().toList();
    if (exerciseIds.isEmpty) return;

    final rows = await supabase
        .from('session_exercises')
        .select('exercise_id, session_sets(set_number, weight_kg, is_warmup, completed)')
        .eq('session_id', sessionId)
        .inFilter('exercise_id', exerciseIds);

    for (final row in (rows as List)) {
      final exId = row['exercise_id'] as String;
      final sets = (row['session_sets'] as List)
          .where((s) =>
              s['completed'] == true && s['is_warmup'] == false)
          .toList()
        ..sort((a, b) =>
            (a['set_number'] as int).compareTo(b['set_number'] as int));
      out[exId] =
          sets.map((s) => (s['weight_kg'] as num?)?.toDouble()).toList();
    }
  }

  /// Builds the 2-line target text for the TARGET column.
  static String? _buildTargetText(dynamic pe, dynamic s, double? resolvedWeight) {
    final goalType = pe.goalType as String;
    final weightType = pe.weightType as String;

    // Time-based goal: show formatted duration, no intensity.
    if (goalType == 'time') {
      final secs = s.targetDurationSecs as int?;
      if (secs == null) return null;
      final m = secs ~/ 60;
      final sec = secs % 60;
      return '${m.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
    }
    final targetReps = s.targetReps as int?;
    final targetRepsMax = s.targetRepsMax as int?;
    final targetWeight = s.targetWeight as double?; // % 1RM
    final targetRpe = s.targetRpe as double?;
    final targetRpeMax = s.targetRpeMax as double?;
    final weightIncrement = s.weightIncrement as double?;

    String? line1;
    String? line2;

    final repsStr = targetReps != null ? '$targetReps' : null;
    final rangeStr = (targetReps != null && targetRepsMax != null)
        ? '$targetReps-$targetRepsMax'
        : repsStr;

    switch (weightType) {
      case 'percent_1rm':
        final pct = targetWeight != null
            ? targetWeight % 1 == 0
                ? '${targetWeight.toInt()}%'
                : '${targetWeight.toStringAsFixed(1)}%'
            : null;
        if (resolvedWeight != null) {
          final wStr = resolvedWeight % 1 == 0
              ? '${resolvedWeight.toInt()}kg'
              : '${resolvedWeight.toStringAsFixed(1)}kg';
          if (goalType == 'amrap') {
            line1 = 'AMRAP';
            line2 = pct;
          } else {
            line1 =
                '$wStr × ${goalType == 'reps_range' ? rangeStr : repsStr ?? '?'}';
            line2 = pct;
          }
        } else {
          if (goalType == 'amrap') {
            line1 = 'AMRAP';
            line2 = pct;
          } else {
            line1 = goalType == 'reps_range' ? rangeStr : repsStr;
            line2 = pct;
          }
        }
      case 'rpe':
        final rpeStr = targetRpe != null
            ? '${targetRpe % 1 == 0 ? targetRpe.toInt() : targetRpe}RPE'
            : null;
        if (goalType == 'amrap') {
          line1 = rpeStr != null ? 'AMRAP @ $rpeStr' : 'AMRAP';
        } else {
          final r = goalType == 'reps_range' ? rangeStr : repsStr;
          line1 = (r != null && rpeStr != null)
              ? '$r @ $rpeStr'
              : r ?? rpeStr;
        }
      case 'rpe_range':
        final rpeRangeStr = (targetRpe != null && targetRpeMax != null)
            ? '${targetRpe % 1 == 0 ? targetRpe.toInt() : targetRpe}-${targetRpeMax % 1 == 0 ? targetRpeMax.toInt() : targetRpeMax}RPE'
            : targetRpe != null
                ? '${targetRpe % 1 == 0 ? targetRpe.toInt() : targetRpe}RPE'
                : null;
        if (goalType == 'amrap') {
          line1 = rpeRangeStr != null ? 'AMRAP @ $rpeRangeStr' : 'AMRAP';
        } else {
          final r = goalType == 'reps_range' ? rangeStr : repsStr;
          line1 = (r != null && rpeRangeStr != null)
              ? '$r @ $rpeRangeStr'
              : r ?? rpeRangeStr;
        }
      case 'prev_week_plus':
      case 'prev_session_plus':
        final tag = weightType == 'prev_week_plus' ? 'Last wk' : 'Last sess';
        final incrStr = weightIncrement != null
            ? '+${weightIncrement % 1 == 0 ? weightIncrement.toInt() : weightIncrement}kg'
            : null;
        if (goalType == 'amrap') {
          line1 = 'AMRAP';
        } else {
          line1 = goalType == 'reps_range' ? rangeStr : repsStr;
        }
        line2 = incrStr != null ? '$tag $incrStr' : tag;
    }

    if (line1 == null && line2 == null) return null;
    if (line2 == null) return line1;
    return '$line1\n$line2';
  }

  void discardWorkout() => state = null;

  ActiveSetEntry _newSet(int setNumber,
          {double? weightKg,
          int? reps,
          double? rpe,
          int? durationSecs,
          double? distanceM,
          String? targetText,
          bool isWarmup = false}) =>
      ActiveSetEntry(
          id: _uuid.v4(),
          setNumber: setNumber,
          weightKg: weightKg,
          reps: reps,
          rpe: rpe,
          durationSecs: durationSecs,
          distanceM: distanceM,
          targetText: targetText,
          isWarmup: isWarmup);
}
