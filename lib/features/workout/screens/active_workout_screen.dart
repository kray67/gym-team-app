import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_team/features/workout/models/active_workout_state.dart';
import 'package:gym_team/features/workout/providers/active_workout_provider.dart';
import 'package:gym_team/features/workout/providers/exercise_records_provider.dart';
import 'package:gym_team/features/workout/providers/workout_history_provider.dart';
import 'package:gym_team/features/workout/screens/exercise_picker_screen.dart';

// Column widths — free workout
const _kSetW = 44.0; // dots icon + set number
const _kPrevW = 90.0;
const _kInputW = 62.0;
const _kCheckW = 36.0;
// Column widths — plan-based workout (TARGET column replaces spacer)
const _kPrevWPlan = 52.0;
const _kKgWPlan = 56.0;
const _kRepsWPlan = 52.0;

// Superset colors — one per group, cycling
const _kSupersetColors = [
  Color(0xFF4CAF50), // green
  Color(0xFFFFB300), // amber
  Color(0xFF42A5F5), // blue
  Color(0xFFEC407A), // pink
  Color(0xFFAB47BC), // purple
  Color(0xFFFF7043), // deep orange
  Color(0xFF26C6DA), // cyan
];

class ActiveWorkoutScreen extends ConsumerStatefulWidget {
  const ActiveWorkoutScreen({super.key});

  @override
  ConsumerState<ActiveWorkoutScreen> createState() =>
      _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends ConsumerState<ActiveWorkoutScreen> {
  late Timer _timer;
  Duration _elapsed = Duration.zero;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final startedAt =
        ref.read(activeWorkoutNotifierProvider)?.startedAt ?? DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() => _elapsed = DateTime.now().difference(startedAt));
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _fmt(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }

  Future<bool> _confirmDiscard() async =>
      await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Discard workout?'),
          content: const Text('All progress will be lost.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel')),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              style:
                  TextButton.styleFrom(foregroundColor: Colors.red.shade400),
              child: const Text('Discard'),
            ),
          ],
        ),
      ) ??
      false;

  Future<bool> _confirmFinishWithIncompleteSets(int count) async =>
      await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Incomplete sets'),
          content: Text(
            '$count set${count == 1 ? '' : 's'} not yet completed. Finish anyway?',
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel')),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              style:
                  TextButton.styleFrom(foregroundColor: Colors.orange),
              child: const Text('Finish'),
            ),
          ],
        ),
      ) ??
      false;

  Future<void> _tryFinish() async {
    final workout = ref.read(activeWorkoutNotifierProvider);
    if (workout == null) return;
    final incompleteCount = workout.exercises
        .expand((e) => e.sets)
        .where((s) => !s.completed)
        .length;
    if (incompleteCount > 0) {
      if (!await _confirmFinishWithIncompleteSets(incompleteCount)) return;
    }
    await _finish();
  }

  Future<void> _finish() async {
    setState(() => _isSaving = true);
    try {
      // Capture sessionId before state is cleared by finishWorkout()
      final sessionId = ref.read(activeWorkoutNotifierProvider)!.sessionId;
      await ref.read(activeWorkoutNotifierProvider.notifier).finishWorkout();
      if (mounted) {
        ref.invalidate(workoutHistoryProvider);
        context.pushReplacement('/workout/done/$sessionId');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to save: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final workout = ref.watch(activeWorkoutNotifierProvider);
    if (workout == null) {
      return Scaffold(
          appBar: AppBar(),
          body: const Center(child: Text('No active workout')));
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        if (await _confirmDiscard() && mounted) {
          ref.read(activeWorkoutNotifierProvider.notifier).discardWorkout();
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              if (await _confirmDiscard() && mounted) {
                ref
                    .read(activeWorkoutNotifierProvider.notifier)
                    .discardWorkout();
                context.pop();
              }
            },
          ),
          title: Text(_fmt(_elapsed)),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: FilledButton(
                onPressed: _isSaving ? null : _tryFinish,
                child: _isSaving
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Finish'),
              ),
            ),
          ],
        ),
        body: workout.exercises.isEmpty
            ? _EmptyState()
            : Builder(builder: (context) {
                final labels = _computeLabels(workout.exercises);
                final colors = _computeSupersetColors(workout.exercises);
                final slots = _buildActiveSlots(workout.exercises);
                return ReorderableListView.builder(
                  padding: const EdgeInsets.only(bottom: 120),
                  itemCount: slots.length,
                  onReorder: (oi, ni) => ref
                      .read(activeWorkoutNotifierProvider.notifier)
                      .reorderSlot(oi, ni),
                  itemBuilder: (context, i) {
                    final slot = slots[i];
                    if (slot is ActiveExerciseEntry) {
                      return _ExerciseCard(
                        key: ValueKey(slot.id),
                        index: i,
                        label: labels[slot.id] ?? '${i + 1}',
                        labelColor: colors[slot.id],
                        entry: slot,
                      );
                    }
                    final group = slot as List<ActiveExerciseEntry>;
                    final groupId = group.first.supersetGroupId!;
                    final color = colors[group.first.id] ?? _kSupersetColors[0];
                    return _SupersetWrapper(
                      key: ValueKey(groupId),
                      index: i,
                      groupId: groupId,
                      exercises: group,
                      labels: labels,
                      color: color,
                    );
                  },
                );
              }),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            final result =
                await context.push<ExercisePickerResult>('/workout/pick-exercise');
            if (result != null && mounted) {
              final notifier = ref.read(activeWorkoutNotifierProvider.notifier);
              if (result.asSuperset) {
                notifier.addSuperset(result.exercises);
              } else {
                notifier.addExercises(result.exercises);
              }
            }
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Exercise'),
        ),
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

/// Returns a map of exerciseId → display label ("1", "2", "3A", "3B"…).
/// Supersets share a slot number; each exercise in the superset gets a letter suffix.
Map<String, String> _computeLabels(List<ActiveExerciseEntry> exercises) {
  final labels = <String, String>{};
  int slot = 0;
  int i = 0;
  while (i < exercises.length) {
    final ex = exercises[i];
    if (ex.supersetGroupId == null) {
      slot++;
      labels[ex.id] = '$slot';
      i++;
    } else {
      final gid = ex.supersetGroupId!;
      final group = <ActiveExerciseEntry>[];
      while (i < exercises.length && exercises[i].supersetGroupId == gid) {
        group.add(exercises[i]);
        i++;
      }
      slot++;
      if (group.length == 1) {
        // Lone survivor of a superset — treat as standalone
        labels[group[0].id] = '$slot';
      } else {
        for (var j = 0; j < group.length; j++) {
          labels[group[j].id] = '$slot${String.fromCharCode(65 + j)}';
        }
      }
    }
  }
  return labels;
}

/// Returns a map of exerciseId → superset color, only for exercises
/// that are in an active superset (group size ≥ 2). Each unique group
/// gets its own color cycling through [_kSupersetColors].
Map<String, Color> _computeSupersetColors(List<ActiveExerciseEntry> exercises) {
  final groupSizes = <String, int>{};
  for (final ex in exercises) {
    if (ex.supersetGroupId != null) {
      groupSizes[ex.supersetGroupId!] = (groupSizes[ex.supersetGroupId!] ?? 0) + 1;
    }
  }
  final groupColors = <String, Color>{};
  final result = <String, Color>{};
  int colorIdx = 0;
  for (final ex in exercises) {
    final gid = ex.supersetGroupId;
    if (gid != null && (groupSizes[gid] ?? 0) >= 2) {
      groupColors.putIfAbsent(gid, () {
        final c = _kSupersetColors[colorIdx % _kSupersetColors.length];
        colorIdx++;
        return c;
      });
      result[ex.id] = groupColors[gid]!;
    }
  }
  return result;
}

List<dynamic> _buildActiveSlots(List<ActiveExerciseEntry> exercises) {
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

/// Shows a sheet to pick isolated exercises and form a new superset.
/// [initiatingId] is pre-selected (the exercise the user tapped from).
Future<void> _showCreateSupersetSheet(
  BuildContext context,
  WidgetRef ref, {
  required String initiatingId,
}) async {
  final workout = ref.read(activeWorkoutNotifierProvider);
  if (workout == null) return;
  final isolated = workout.exercises
      .where((e) => e.supersetGroupId == null)
      .toList();
  if (isolated.length < 2) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add more exercises to create a superset')),
    );
    return;
  }
  final confirmed = await showModalBottomSheet<Set<String>>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _SupersetPickerSheet(
      exercises: isolated,
      initialSelected: {initiatingId},
      title: 'Create Superset',
      confirmLabel: 'Create',
      minSelected: 2,
    ),
  );
  if (confirmed != null && confirmed.length >= 2) {
    ref.read(activeWorkoutNotifierProvider.notifier).formSuperset(confirmed.toList());
  }
}

/// Shows a sheet to pick isolated exercises and add them to an existing superset.
Future<void> _showAddToSupersetSheet(
  BuildContext context,
  WidgetRef ref, {
  required String groupId,
}) async {
  final workout = ref.read(activeWorkoutNotifierProvider);
  if (workout == null) return;
  final isolated = workout.exercises
      .where((e) => e.supersetGroupId == null)
      .toList();
  if (isolated.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No isolated exercises to add')),
    );
    return;
  }
  final confirmed = await showModalBottomSheet<Set<String>>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _SupersetPickerSheet(
      exercises: isolated,
      initialSelected: {},
      title: 'Add to Superset',
      confirmLabel: 'Add',
      minSelected: 1,
    ),
  );
  if (confirmed != null && confirmed.isNotEmpty) {
    ref
        .read(activeWorkoutNotifierProvider.notifier)
        .addExercisesToSuperset(groupId, confirmed.toList());
  }
}

/// Modal bottom sheet for picking exercises to include in a superset.
class _SupersetPickerSheet extends StatefulWidget {
  final List<ActiveExerciseEntry> exercises;
  final Set<String> initialSelected;
  final String title;
  final String confirmLabel;
  final int minSelected;

  const _SupersetPickerSheet({
    required this.exercises,
    required this.initialSelected,
    required this.title,
    required this.confirmLabel,
    required this.minSelected,
  });

  @override
  State<_SupersetPickerSheet> createState() => _SupersetPickerSheetState();
}

class _SupersetPickerSheetState extends State<_SupersetPickerSheet> {
  late final Set<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = Set.from(widget.initialSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.title,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(
            'Select at least ${widget.minSelected} exercises',
            style: const TextStyle(color: Colors.white38, fontSize: 12),
          ),
          const SizedBox(height: 12),
          ...widget.exercises.map((e) {
            final isSelected = _selected.contains(e.id);
            final selIdx = _selected.toList().indexOf(e.id);
            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text(e.exercise.name),
              subtitle: Text(
                '${e.exercise.muscleGroup} · ${e.exercise.category}',
                style: const TextStyle(color: Colors.white38, fontSize: 12),
              ),
              trailing: isSelected
                  ? CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.green,
                      child: Text(
                        '${selIdx + 1}',
                        style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : const Icon(Icons.add_circle_outline, size: 20),
              onTap: () => setState(() {
                if (isSelected) {
                  _selected.remove(e.id);
                } else {
                  _selected.add(e.id);
                }
              }),
            );
          }),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _selected.length >= widget.minSelected
                ? () => Navigator.of(context).pop(_selected)
                : null,
            child: Text(widget.confirmLabel),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.fitness_center,
              size: 64, color: Colors.white.withValues(alpha: 0.2)),
          const SizedBox(height: 16),
          Text('No exercises yet',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.5))),
          const SizedBox(height: 8),
          Text('Tap "Add Exercise" to get started',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.3))),
        ],
      ),
    );
  }
}

// ── Superset wrapper ──────────────────────────────────────────────────────────

class _SupersetWrapper extends ConsumerWidget {
  final int index;
  final String groupId;
  final List<ActiveExerciseEntry> exercises;
  final Map<String, String> labels;
  final Color color;

  const _SupersetWrapper({
    super.key,
    required this.index,
    required this.groupId,
    required this.exercises,
    required this.labels,
    required this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(activeWorkoutNotifierProvider.notifier);
    final firstLabel = labels[exercises.first.id] ?? '';
    final slotNum = firstLabel.replaceAll(RegExp(r'[A-Za-z]+$'), '');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color.withValues(alpha: 0.45), width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 6, 4, 4),
              child: Row(
                children: [
                  Text(
                    'Superset $slotNum',
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                  const Spacer(),
                  ReorderableDragStartListener(
                    index: index,
                    child: const Icon(Icons.drag_handle,
                        color: Colors.white38, size: 20),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_horiz,
                        color: Colors.white38, size: 20),
                    onSelected: (v) async {
                      if (v == 'add') {
                        await _showAddToSupersetSheet(
                            context, ref, groupId: groupId);
                      } else if (v == 'break') {
                        notifier.breakSuperset(groupId);
                      } else if (v == 'remove') {
                        notifier.removeSuperset(groupId);
                      }
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                          value: 'add', child: Text('Add exercise…')),
                      PopupMenuItem(
                          value: 'break', child: Text('Break Superset')),
                      PopupMenuItem(
                        value: 'remove',
                        child: Text('Remove all',
                            style: TextStyle(color: Colors.redAccent)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 1, indent: 12, endIndent: 12),
            // ── Inner reorderable list ───────────────────────────────────
            ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              onReorder: (oi, ni) =>
                  notifier.reorderWithinSuperset(groupId, oi, ni),
              children: [
                for (var i = 0; i < exercises.length; i++)
                  _ExerciseCard(
                    key: ValueKey(exercises[i].id),
                    index: i,
                    label: labels[exercises[i].id] ?? '?',
                    labelColor: color,
                    entry: exercises[i],
                    isInSuperset: true,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Exercise card ─────────────────────────────────────────────────────────────

class _ExerciseCard extends ConsumerWidget {
  final int index;
  final String label;
  final Color? labelColor;
  final ActiveExerciseEntry entry;
  final bool isInSuperset;
  const _ExerciseCard({
    super.key,
    required this.index,
    required this.label,
    required this.entry,
    this.labelColor,
    this.isInSuperset = false,
  });

  bool get _showRpe => entry.weightType == 'rpe';

  /// Returns the set IDs that are currently PRs for this exercise.
  ///
  /// Only the single best set per record type counts as a PR, and only if it
  /// also beats the stored DB record. This ensures that once a better set is
  /// logged within the same workout, earlier sets lose their PR chip.
  static Set<String> _computePrSetIds(
      List<ActiveSetEntry> sets, Map<String, double>? existing) {
    final completed = sets.where((s) => s.completed && !s.isWarmup).toList();
    if (completed.isEmpty) return {};

    final prIds = <String>{};
    final ex = existing ?? {};

    // max_weight
    ActiveSetEntry? bestW;
    for (final s in completed) {
      if (s.weightKg != null &&
          (bestW == null || s.weightKg! > bestW.weightKg!)) bestW = s;
    }
    if (bestW != null) {
      final stored = ex['max_weight'];
      if (stored == null || bestW.weightKg! > stored) prIds.add(bestW.id);
    }

    // max_volume (weight × reps)
    ActiveSetEntry? bestVol;
    double bestVolVal = 0;
    for (final s in completed) {
      if (s.weightKg != null && s.reps != null) {
        final v = s.weightKg! * s.reps!;
        if (bestVol == null || v > bestVolVal) {
          bestVol = s;
          bestVolVal = v;
        }
      }
    }
    if (bestVol != null) {
      final stored = ex['max_volume'];
      if (stored == null || bestVolVal > stored) prIds.add(bestVol.id);
    }

    // estimated_1rm (Epley)
    ActiveSetEntry? bestEpley;
    double bestEpleyVal = 0;
    for (final s in completed) {
      if (s.weightKg != null && s.reps != null) {
        final e = s.weightKg! * (1 + s.reps! / 30.0);
        if (bestEpley == null || e > bestEpleyVal) {
          bestEpley = s;
          bestEpleyVal = e;
        }
      }
    }
    if (bestEpley != null) {
      final stored = ex['estimated_1rm'];
      if (stored == null || bestEpleyVal > stored) prIds.add(bestEpley.id);
    }

    return prIds;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(activeWorkoutNotifierProvider.notifier);
    final state = ref.watch(activeWorkoutNotifierProvider);
    final showTarget = state?.planId != null;
    final prev = ref.watch(previousPerformanceProvider(entry.exercise.id));
    final prevText = prev.valueOrNull;
    // Existing records for live PR detection (null while loading — no badges shown).
    final existingRecords =
        ref.watch(userExerciseRecordsProvider).valueOrNull;
    final existingForExercise = existingRecords?[entry.exercise.id];
    // Compute which set IDs are PRs for this exercise (empty while records load).
    final prSetIds = existingRecords == null
        ? <String>{}
        : _computePrSetIds(entry.sets, existingForExercise);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Exercise header ───────────────────────────────────────────
              Row(
                children: [
                  Text(
                    label,
                    style: TextStyle(
                        color: labelColor ?? Colors.white38,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      entry.exercise.name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  // Drag handle
                  ReorderableDragStartListener(
                    index: index,
                    child: const Icon(Icons.drag_handle,
                        color: Colors.white38, size: 20),
                  ),
                  // Options menu
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_horiz,
                        color: Colors.white38, size: 20),
                    onSelected: (v) async {
                      if (v == 'swap') {
                        final result = await context
                            .push<ExercisePickerResult>(
                                '/workout/pick-exercise?mode=swap');
                        if (result != null) {
                          notifier.swapExercise(entry.id, result.exercises.first);
                        }
                      } else if (v == 'note') {
                        final ctrl = TextEditingController(text: entry.note);
                        final saved = await showDialog<String>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Exercise note'),
                            content: TextField(
                              controller: ctrl,
                              autofocus: true,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                hintText: 'Add a note…',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Cancel'),
                              ),
                              FilledButton(
                                onPressed: () =>
                                    Navigator.pop(ctx, ctrl.text),
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                        );
                        ctrl.dispose();
                        if (saved != null) {
                          notifier.setNote(entry.id,
                              saved.trim().isEmpty ? null : saved.trim());
                        }
                      } else if (v == 'superset') {
                        if (!context.mounted) return;
                        await _showCreateSupersetSheet(context, ref,
                            initiatingId: entry.id);
                      } else if (v == 'remove_from_ss') {
                        notifier.removeFromSuperset(entry.id);
                      } else if (v == 'remove') {
                        notifier.removeExercise(entry.id);
                      }
                    },
                    itemBuilder: (_) => [
                      const PopupMenuItem(value: 'swap', child: Text('Swap exercise')),
                      PopupMenuItem(
                        value: 'note',
                        child: Text(entry.note != null ? 'Edit note' : 'Add note'),
                      ),
                      if (!isInSuperset)
                        const PopupMenuItem(
                            value: 'superset',
                            child: Text('Add to superset…')),
                      if (isInSuperset)
                        const PopupMenuItem(
                            value: 'remove_from_ss',
                            child: Text('Remove from Superset')),
                      const PopupMenuItem(
                        value: 'remove',
                        child: Text('Remove',
                            style: TextStyle(color: Colors.redAccent)),
                      ),
                    ],
                  ),
                ],
              ),
              Text(entry.exercise.muscleGroup,
                  style: const TextStyle(
                      color: Colors.white38, fontSize: 12)),
              if (entry.note != null && entry.note!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  entry.note!,
                  style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                      fontStyle: FontStyle.italic),
                ),
              ],
              const SizedBox(height: 10),

              // ── Column headers ────────────────────────────────────────────
              _TableHeader(showRpe: _showRpe, showTarget: showTarget, trackingType: entry.exercise.trackingType),
              const Divider(height: 8),

              // ── Set rows ──────────────────────────────────────────────────
              ...entry.sets.map((set) => _SetRow(
                    key: ValueKey(set.id),
                    exerciseId: entry.id,
                    set: set,
                    prevText: prevText,
                    showRpe: _showRpe,
                    showTarget: showTarget,
                    isPr: prSetIds.contains(set.id),
                    trackingType: entry.exercise.trackingType,
                  )),

              // ── Footer ────────────────────────────────────────────────────
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () => notifier.addSet(entry.id),
                    icon: const Icon(Icons.add_circle_outline, size: 16),
                    label: const Text('Add Set'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white38,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Table header row ──────────────────────────────────────────────────────────

class _TableHeader extends StatelessWidget {
  final bool showRpe;
  final bool showTarget;
  final String trackingType;
  const _TableHeader({
    required this.showRpe,
    required this.showTarget,
    required this.trackingType,
  });

  static const _style = TextStyle(fontSize: 11, color: Colors.grey);

  List<Widget> _inputCols(double colW) {
    switch (trackingType) {
      case 'reps_only':
        return [
          SizedBox(width: colW, child: const Text('REPS', style: _style, textAlign: TextAlign.center)),
        ];
      case 'weight_time':
        return [
          SizedBox(width: colW, child: const Text('KG', style: _style, textAlign: TextAlign.center)),
          const SizedBox(width: 6),
          SizedBox(width: colW, child: const Text('TIME', style: _style, textAlign: TextAlign.center)),
        ];
      case 'time':
        return [
          SizedBox(width: colW, child: const Text('TIME', style: _style, textAlign: TextAlign.center)),
        ];
      case 'distance_time':
        return [
          SizedBox(width: colW, child: const Text('KM', style: _style, textAlign: TextAlign.center)),
          const SizedBox(width: 6),
          SizedBox(width: colW, child: const Text('TIME', style: _style, textAlign: TextAlign.center)),
        ];
      default: // weight_reps
        return [
          SizedBox(width: colW, child: const Text('KG', style: _style, textAlign: TextAlign.center)),
          const SizedBox(width: 6),
          SizedBox(width: colW, child: const Text('REPS', style: _style, textAlign: TextAlign.center)),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (showTarget) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Row(
          children: [
            SizedBox(width: _kSetW, child: const Text('SET', style: _style, textAlign: TextAlign.center)),
            const SizedBox(width: 4),
            SizedBox(width: _kPrevWPlan, child: const Text('PREV', style: _style)),
            const SizedBox(width: 4),
            const Expanded(child: Text('TARGET', style: _style, textAlign: TextAlign.center)),
            const SizedBox(width: 4),
            ..._inputCols(_kKgWPlan),
            const SizedBox(width: 6),
            SizedBox(width: _kCheckW),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        children: [
          SizedBox(width: _kSetW, child: const Text('SET', style: _style, textAlign: TextAlign.center)),
          const SizedBox(width: 8),
          SizedBox(width: _kPrevW, child: const Text('PREVIOUS', style: _style)),
          const Spacer(),
          ..._inputCols(_kInputW),
          if (showRpe && trackingType == 'weight_reps') ...[
            const SizedBox(width: 6),
            SizedBox(width: _kInputW, child: const Text('RPE', style: _style, textAlign: TextAlign.center)),
          ],
          const SizedBox(width: 6),
          SizedBox(width: _kCheckW),
        ],
      ),
    );
  }
}

// ── Set row ───────────────────────────────────────────────────────────────────

class _SetRow extends ConsumerStatefulWidget {
  final String exerciseId;
  final ActiveSetEntry set;
  final String? prevText;
  final bool showRpe;
  final bool showTarget;
  final bool isPr;
  final String trackingType;

  const _SetRow({
    super.key,
    required this.exerciseId,
    required this.set,
    required this.prevText,
    required this.showRpe,
    required this.showTarget,
    required this.isPr,
    required this.trackingType,
  });

  @override
  ConsumerState<_SetRow> createState() => _SetRowState();
}

class _SetRowState extends ConsumerState<_SetRow> {
  late final TextEditingController _weightCtrl;
  late final TextEditingController _repsCtrl;
  late final TextEditingController _rpeCtrl;
  late final TextEditingController _durationCtrl;
  late final TextEditingController _distanceCtrl;

  static String _fmtDuration(int? secs) {
    if (secs == null) return '';
    final m = secs ~/ 60;
    final s = secs % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  static int? _parseDuration(String text) {
    if (text.isEmpty) return null;
    if (text.contains(':')) {
      final parts = text.split(':');
      if (parts.length == 2) {
        final m = int.tryParse(parts[0]);
        final s = int.tryParse(parts[1]);
        if (m != null && s != null) return m * 60 + s;
      }
      return null;
    }
    return int.tryParse(text);
  }

  Future<void> _showSetMenu() async {
    final set = widget.set;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final offset = box.localToGlobal(Offset.zero);
    final choice = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx, offset.dy,
        offset.dx + box.size.width, offset.dy + box.size.height,
      ),
      items: [
        PopupMenuItem(
          value: 'work',
          child: Row(children: [
            Icon(Icons.fitness_center, size: 16,
                color: !set.isWarmup
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white38),
            const SizedBox(width: 8),
            Text('Work Set',
                style: TextStyle(
                    color: !set.isWarmup
                        ? Theme.of(context).colorScheme.primary
                        : null)),
          ]),
        ),
        PopupMenuItem(
          value: 'warmup',
          child: Row(children: [
            Icon(Icons.thermostat, size: 16,
                color: set.isWarmup
                    ? Colors.orange.shade300
                    : Colors.white38),
            const SizedBox(width: 8),
            Text('Warm-up Set',
                style: TextStyle(
                    color: set.isWarmup ? Colors.orange.shade300 : null)),
          ]),
        ),
        PopupMenuItem(
          value: 'remove',
          child: Row(children: [
            Icon(Icons.delete_outline, size: 16, color: Colors.red.shade300),
            const SizedBox(width: 8),
            Text('Remove Set',
                style: TextStyle(color: Colors.red.shade300)),
          ]),
        ),
      ],
    );
    if (!mounted) return;
    final notifier = ref.read(activeWorkoutNotifierProvider.notifier);
    if (choice == 'work' && set.isWarmup) {
      notifier.toggleSetWarmup(widget.exerciseId, set.id);
    } else if (choice == 'warmup' && !set.isWarmup) {
      notifier.toggleSetWarmup(widget.exerciseId, set.id);
    } else if (choice == 'remove') {
      notifier.removeSet(widget.exerciseId, set.id);
    }
  }

  @override
  void initState() {
    super.initState();
    final s = widget.set;
    _weightCtrl = TextEditingController(
        text: s.weightKg != null
            ? s.weightKg!.toStringAsFixed(s.weightKg! % 1 == 0 ? 0 : 1)
            : '');
    _repsCtrl = TextEditingController(text: s.reps?.toString() ?? '');
    _rpeCtrl = TextEditingController(
        text: s.rpe != null
            ? s.rpe!.toStringAsFixed(s.rpe! % 1 == 0 ? 0 : 1)
            : '');
    _durationCtrl = TextEditingController(text: _fmtDuration(s.durationSecs));
    _distanceCtrl = TextEditingController(
        text: s.distanceM != null
            ? (s.distanceM! / 1000).toStringAsFixed(2)
            : '');
  }

  @override
  void dispose() {
    _weightCtrl.dispose();
    _repsCtrl.dispose();
    _rpeCtrl.dispose();
    _durationCtrl.dispose();
    _distanceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(activeWorkoutNotifierProvider.notifier);
    final set = widget.set;
    final completed = set.completed;

    final canComplete = _canComplete(set);

    return Stack(
      clipBehavior: Clip.none,
      children: [
      AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: completed
            ? Colors.green.withValues(alpha: 0.12)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
        child: Row(
          children: [
            if (widget.showTarget) ...[
              _SetMenuCell(set: set, onTap: _showSetMenu),
              const SizedBox(width: 4),
              SizedBox(
                width: _kPrevWPlan,
                child: Text(
                  widget.prevText ?? '—',
                  style: const TextStyle(color: Colors.white38, fontSize: 11),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: widget.set.targetText != null
                    ? Text(
                        widget.set.targetText!,
                        style: const TextStyle(color: Colors.white60, fontSize: 11, height: 1.3),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(width: 4),
              ..._buildInputWidgets(notifier, set, completed, _kKgWPlan),
            ] else ...[
              _SetMenuCell(set: set, onTap: _showSetMenu),
              const SizedBox(width: 8),
              SizedBox(
                width: _kPrevW,
                child: Text(
                  widget.prevText ?? '—',
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              ..._buildInputWidgets(notifier, set, completed, _kInputW),
              if (widget.showRpe && widget.trackingType == 'weight_reps') ...[
                const SizedBox(width: 6),
                SizedBox(
                  width: _kInputW,
                  child: _NumField(
                    controller: _rpeCtrl,
                    hint: '8',
                    decimal: true,
                    completed: completed,
                    onChanged: (v) => notifier.updateSet(widget.exerciseId, set.id, rpe: double.tryParse(v)),
                  ),
                ),
              ],
            ],
            const SizedBox(width: 6),
            SizedBox(
              width: _kCheckW,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  completed ? Icons.check_circle : Icons.check_circle_outline,
                  color: completed
                      ? Colors.green
                      : canComplete ? Colors.white38 : Colors.white12,
                ),
                onPressed: canComplete
                    ? () => notifier.toggleSetCompleted(widget.exerciseId, set.id)
                    : null,
              ),
            ),
          ],
        ),
      ),
    ),
    if (widget.isPr)
      Positioned(
        right: 4,
        top: -5,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.amber.shade700,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'PR',
            style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.black, letterSpacing: 0.5),
          ),
        ),
      ),
    ],
    );
  }

  bool _canComplete(ActiveSetEntry set) {
    switch (widget.trackingType) {
      case 'time':
      case 'weight_time':
      case 'distance_time':
        return set.durationSecs != null;
      default:
        return set.reps != null;
    }
  }

  List<Widget> _buildInputWidgets(
    dynamic notifier,
    ActiveSetEntry set,
    bool completed,
    double colW,
  ) {
    switch (widget.trackingType) {
      case 'reps_only':
        return [
          SizedBox(
            width: colW,
            child: _NumField(
              controller: _repsCtrl,
              hint: '0',
              decimal: false,
              completed: completed,
              onChanged: (v) => notifier.updateSet(widget.exerciseId, set.id, reps: int.tryParse(v)),
            ),
          ),
        ];
      case 'weight_time':
        return [
          SizedBox(
            width: colW,
            child: _NumField(
              controller: _weightCtrl,
              hint: '0',
              decimal: true,
              completed: completed,
              onChanged: (v) => notifier.updateSet(widget.exerciseId, set.id, weightKg: double.tryParse(v)),
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: colW,
            child: _TimeField(
              controller: _durationCtrl,
              completed: completed,
              onChanged: (v) => notifier.updateSet(widget.exerciseId, set.id, durationSecs: _parseDuration(v)),
            ),
          ),
        ];
      case 'time':
        return [
          SizedBox(
            width: colW,
            child: _TimeField(
              controller: _durationCtrl,
              completed: completed,
              onChanged: (v) => notifier.updateSet(widget.exerciseId, set.id, durationSecs: _parseDuration(v)),
            ),
          ),
        ];
      case 'distance_time':
        return [
          SizedBox(
            width: colW,
            child: _NumField(
              controller: _distanceCtrl,
              hint: '0.00',
              decimal: true,
              completed: completed,
              onChanged: (v) => notifier.updateSet(widget.exerciseId, set.id,
                  distanceM: double.tryParse(v) != null ? double.parse(v) * 1000 : null),
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: colW,
            child: _TimeField(
              controller: _durationCtrl,
              completed: completed,
              onChanged: (v) => notifier.updateSet(widget.exerciseId, set.id, durationSecs: _parseDuration(v)),
            ),
          ),
        ];
      default: // weight_reps
        return [
          SizedBox(
            width: colW,
            child: _NumField(
              controller: _weightCtrl,
              hint: '0',
              decimal: true,
              completed: completed,
              onChanged: (v) => notifier.updateSet(widget.exerciseId, set.id, weightKg: double.tryParse(v)),
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: colW,
            child: _NumField(
              controller: _repsCtrl,
              hint: '0',
              decimal: false,
              completed: completed,
              onChanged: (v) => notifier.updateSet(widget.exerciseId, set.id, reps: int.tryParse(v)),
            ),
          ),
        ];
    }
  }
}

// ── Set menu cell (3-dot button + set number) ─────────────────────────────────

class _SetMenuCell extends StatelessWidget {
  final ActiveSetEntry set;
  final VoidCallback onTap;
  const _SetMenuCell({required this.set, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = set.isWarmup
        ? Colors.orange.shade300
        : set.completed
            ? Colors.green
            : Colors.white70;
    return SizedBox(
      width: _kSetW,
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
              child: Icon(Icons.more_vert, size: 13, color: Colors.white24),
            ),
          ),
          Expanded(
            child: Text(
              set.isWarmup ? 'W' : '${set.setNumber}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Number input field ────────────────────────────────────────────────────────

class _NumField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool decimal;
  final bool completed;
  final ValueChanged<String> onChanged;

  const _NumField({
    required this.controller,
    required this.hint,
    required this.decimal,
    required this.completed,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      keyboardType:
          TextInputType.numberWithOptions(decimal: decimal, signed: false),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            decimal ? RegExp(r'^\d*\.?\d*') : RegExp(r'^\d*')),
      ],
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: completed ? Colors.green : Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white24),
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide:
              BorderSide(color: Colors.white.withValues(alpha: 0.15)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide:
              BorderSide(color: Colors.white.withValues(alpha: 0.15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
              color: completed
                  ? Colors.green
                  : Theme.of(context).colorScheme.primary),
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
      ),
      onChanged: onChanged,
    );
  }
}

// ── Time input field (MM:SS) ──────────────────────────────────────────────────

class _TimeField extends StatelessWidget {
  final TextEditingController controller;
  final bool completed;
  final ValueChanged<String> onChanged;

  const _TimeField({
    required this.controller,
    required this.completed,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[\d:]')),
      ],
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: completed ? Colors.green : Colors.white,
      ),
      decoration: InputDecoration(
        hintText: '0:00',
        hintStyle: const TextStyle(color: Colors.white24),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
              color: completed ? Colors.green : Theme.of(context).colorScheme.primary),
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
      ),
      onChanged: onChanged,
    );
  }
}
