import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_team/features/plans/models/plan_editor_state.dart';
import 'package:gym_team/features/plans/providers/plan_editor_provider.dart';
import 'package:gym_team/features/plans/providers/plans_provider.dart';
import 'package:gym_team/features/workout/screens/exercise_picker_screen.dart';

// ── Time helpers ──────────────────────────────────────────────────────────────

const _kTimeTooltip =
    'Accepted formats:\n• 15  (seconds)\n• 1:30  (min:sec)\n• 1:30:00  (hr:min:sec)';

String _fmtDurationPlan(int? secs) {
  if (secs == null) return '';
  final d = Duration(seconds: secs);
  final h = d.inHours;
  final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
  final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
  return h > 0 ? '$h:$m:$s' : '${d.inMinutes.remainder(60)}:$s';
}

int? _parseDurationPlan(String text) {
  if (text.isEmpty) return null;
  if (text.contains(':')) {
    final parts = text.split(':');
    if (parts.length == 2) {
      final m = int.tryParse(parts[0]);
      final s = int.tryParse(parts[1]);
      if (m != null && s != null) return m * 60 + s;
    } else if (parts.length == 3) {
      final h = int.tryParse(parts[0]);
      final m = int.tryParse(parts[1]);
      final s = int.tryParse(parts[2]);
      if (h != null && m != null && s != null) return h * 3600 + m * 60 + s;
    }
    return null;
  }
  return int.tryParse(text);
}

// Column widths — mirrors active_workout_screen
const _kSetW = 32.0;

// Superset colors — must match active_workout_screen palette
const _kPlanSupersetColors = [
  Color(0xFF4CAF50),
  Color(0xFFFFB300),
  Color(0xFF42A5F5),
  Color(0xFFEC407A),
  Color(0xFFAB47BC),
  Color(0xFFFF7043),
  Color(0xFF26C6DA),
];
const _kInputW = 56.0;
const _kDeleteW = 32.0;

// ── Step 2: Session builder ───────────────────────────────────────────────────

class PlanSessionBuilderScreen extends ConsumerStatefulWidget {
  const PlanSessionBuilderScreen({super.key});

  @override
  ConsumerState<PlanSessionBuilderScreen> createState() =>
      _PlanSessionBuilderScreenState();
}

class _PlanSessionBuilderScreenState
    extends ConsumerState<PlanSessionBuilderScreen>
    with TickerProviderStateMixin {
  TabController? _weekTabs;
  bool _saving = false;
  int _prevWeeks = 0;

  @override
  void dispose() {
    _weekTabs?.dispose();
    super.dispose();
  }

  void _syncTabs(int weeks) {
    if (weeks == _prevWeeks) return;
    _weekTabs?.dispose();
    _weekTabs = TabController(length: weeks, vsync: this);
    _prevWeeks = weeks;
  }

  Future<void> _save() async {
    final notifier = ref.read(planEditorNotifierProvider.notifier);
    final s = ref.read(planEditorNotifierProvider);
    if (s == null) return;
    setState(() => _saving = true);
    try {
      final planId = await notifier.savePlan();
      if (mounted) {
        ref.invalidate(myPlansProvider);
        ref.invalidate(planDetailProvider(planId));
        context.go('/plans/$planId');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(planEditorNotifierProvider);
    if (s == null) {
      return Scaffold(appBar: AppBar(), body: const SizedBox.shrink());
    }

    _syncTabs(s.weeks);
    final tabs = _weekTabs!;

    return Scaffold(
      appBar: AppBar(
        title: Text(s.title.isEmpty ? 'Sessions' : s.title),
        bottom: TabBar(
          controller: tabs,
          isScrollable: s.weeks > 4,
          tabs: List.generate(
              s.weeks, (i) => Tab(text: 'Week ${i + 1}')),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilledButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Save'),
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: tabs,
        children: List.generate(
          s.weeks,
          (weekIdx) => _WeekTab(
            weekNumber: weekIdx + 1,
            sessionsPerWeek: s.sessionsPerWeek,
          ),
        ),
      ),
    );
  }
}

// ── Week tab: list of day cards ───────────────────────────────────────────────

class _WeekTab extends ConsumerWidget {
  final int weekNumber;
  final int sessionsPerWeek;

  const _WeekTab({
    required this.weekNumber,
    required this.sessionsPerWeek,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(planEditorNotifierProvider);
    if (s == null) return const SizedBox.shrink();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: sessionsPerWeek,
      itemBuilder: (context, dayIdx) {
        final dayNumber = dayIdx + 1;
        final exercises = s.exercises
            .where((e) =>
                e.weekNumber == weekNumber && e.sessionNumber == dayNumber)
            .toList();
        return _DayCard(
          weekNumber: weekNumber,
          dayNumber: dayNumber,
          exercises: exercises,
          totalWeeks: s.weeks,
          totalDays: s.sessionsPerWeek,
        );
      },
    );
  }
}

// ── Day card ──────────────────────────────────────────────────────────────────

class _DayCard extends StatelessWidget {
  final int weekNumber;
  final int dayNumber;
  final List<PlanEditorExercise> exercises;
  final int totalWeeks;
  final int totalDays;

  const _DayCard({
    required this.weekNumber,
    required this.dayNumber,
    required this.exercises,
    required this.totalWeeks,
    required this.totalDays,
  });

  @override
  Widget build(BuildContext context) {
    final subtitle = exercises.isEmpty
        ? 'No exercises'
        : exercises.map((e) => e.exercise.name).join(', ');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push(
            '/plans/session-editor?week=$weekNumber&day=$dayNumber'),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 4, 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Day $dayNumber',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: exercises.isEmpty
                            ? Colors.white38
                            : Colors.white60,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (exercises.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          '${exercises.length} ${exercises.length == 1 ? 'exercise' : 'exercises'}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              _DayOptionsButton(
                weekNumber: weekNumber,
                dayNumber: dayNumber,
                totalWeeks: totalWeeks,
                totalDays: totalDays,
                hasExercises: exercises.isNotEmpty,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Day options popup menu ────────────────────────────────────────────────────

class _DayOptionsButton extends ConsumerWidget {
  final int weekNumber;
  final int dayNumber;
  final int totalWeeks;
  final int totalDays;
  final bool hasExercises;

  const _DayOptionsButton({
    required this.weekNumber,
    required this.dayNumber,
    required this.totalWeeks,
    required this.totalDays,
    required this.hasExercises,
  });

  Future<void> _showCopyDayDialog(BuildContext context, WidgetRef ref) async {
    final allSessions = [
      for (var w = 1; w <= totalWeeks; w++)
        for (var d = 1; d <= totalDays; d++)
          if (!(w == weekNumber && d == dayNumber)) (w, d)
    ];

    final selected = <(int, int)>{};

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text('Copy Week $weekNumber · Day $dayNumber to...'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                // Quick option: same day across all other weeks
                if (totalWeeks > 1)
                  CheckboxListTile(
                    title: Text('All other Week × · Day $dayNumber'),
                    subtitle: const Text('Same day in every other week'),
                    dense: true,
                    value: [
                      for (var w = 1; w <= totalWeeks; w++)
                        if (w != weekNumber) (w, dayNumber)
                    ].every(selected.contains),
                    onChanged: (v) => setState(() {
                      for (var w = 1; w <= totalWeeks; w++) {
                        if (w != weekNumber) {
                          v == true
                              ? selected.add((w, dayNumber))
                              : selected.remove((w, dayNumber));
                        }
                      }
                    }),
                  ),
                if (totalWeeks > 1) const Divider(),
                ...allSessions.map((s) {
                  final label = 'Week ${s.$1} · Day ${s.$2}';
                  return CheckboxListTile(
                    title: Text(label),
                    value: selected.contains(s),
                    dense: true,
                    onChanged: (v) => setState(() {
                      if (v == true) {
                        selected.add(s);
                      } else {
                        selected.remove(s);
                      }
                    }),
                  );
                }),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel')),
            FilledButton(
              onPressed: selected.isEmpty
                  ? null
                  : () => Navigator.pop(ctx, true),
              child: const Text('Copy'),
            ),
          ],
        ),
      ),
    );

    if (confirmed == true && selected.isNotEmpty) {
      ref
          .read(planEditorNotifierProvider.notifier)
          .copySession(weekNumber, dayNumber, selected.toList());
    }
  }

  Future<void> _showCopyWeekDialog(BuildContext context, WidgetRef ref) async {
    final otherWeeks = [
      for (var w = 1; w <= totalWeeks; w++)
        if (w != weekNumber) w
    ];
    final selected = <int>{};

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text('Copy all of Week $weekNumber to...'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: otherWeeks.map((w) {
                return CheckboxListTile(
                  title: Text('Week $w'),
                  value: selected.contains(w),
                  dense: true,
                  onChanged: (v) => setState(() {
                    if (v == true) {
                      selected.add(w);
                    } else {
                      selected.remove(w);
                    }
                  }),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel')),
            FilledButton(
              onPressed: selected.isEmpty
                  ? null
                  : () => Navigator.pop(ctx, true),
              child: const Text('Copy'),
            ),
          ],
        ),
      ),
    );

    if (confirmed == true && selected.isNotEmpty) {
      ref
          .read(planEditorNotifierProvider.notifier)
          .copyWeek(weekNumber, selected.toList());
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.white54),
      onSelected: (value) async {
        switch (value) {
          case 'edit':
            context.push(
                '/plans/session-editor?week=$weekNumber&day=$dayNumber');
          case 'copy_day':
            await _showCopyDayDialog(context, ref);
          case 'copy_week':
            await _showCopyWeekDialog(context, ref);
          case 'clear':
            final confirm = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text('Clear Week $weekNumber · Day $dayNumber?'),
                content: const Text('All exercises will be removed.'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancel')),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.red.shade400),
                    child: const Text('Clear'),
                  ),
                ],
              ),
            );
            if (confirm == true) {
              ref
                  .read(planEditorNotifierProvider.notifier)
                  .clearSession(weekNumber, dayNumber);
            }
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'edit', child: Text('Edit')),
        const PopupMenuItem(value: 'copy_day', child: Text('Copy day to...')),
        if (totalWeeks > 1)
          const PopupMenuItem(
              value: 'copy_week', child: Text('Duplicate week to...')),
        if (hasExercises)
          const PopupMenuItem(value: 'clear', child: Text('Clear')),
      ],
    );
  }
}

/// Returns a map of exerciseId → display label ("1", "2", "3A", "3B"…).
Map<String, String> _computePlanLabels(List<PlanEditorExercise> exercises) {
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
      final group = <PlanEditorExercise>[];
      while (i < exercises.length && exercises[i].supersetGroupId == gid) {
        group.add(exercises[i]);
        i++;
      }
      slot++;
      if (group.length == 1) {
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

Map<String, Color> _computePlanSupersetColors(List<PlanEditorExercise> exercises) {
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
        final c = _kPlanSupersetColors[colorIdx % _kPlanSupersetColors.length];
        colorIdx++;
        return c;
      });
      result[ex.id] = groupColors[gid]!;
    }
  }
  return result;
}

List<dynamic> _buildPlanSlots(List<PlanEditorExercise> exercises) {
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

// ── Session editor screen (exercises for one week/day) ────────────────────────

class SessionEditorScreen extends ConsumerWidget {
  final int weekNumber;
  final int dayNumber;

  const SessionEditorScreen({
    super.key,
    required this.weekNumber,
    required this.dayNumber,
  });

  Future<void> _pickExercise(BuildContext context, WidgetRef ref) async {
    final result =
        await context.push<ExercisePickerResult>('/workout/pick-exercise');
    if (result == null || !context.mounted) return;
    final notifier = ref.read(planEditorNotifierProvider.notifier);
    if (result.asSuperset) {
      notifier.addSupersetToSession(result.exercises, weekNumber, dayNumber);
    } else {
      notifier.addExercisesToSession(result.exercises, weekNumber, dayNumber);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(planEditorNotifierProvider);
    if (s == null) {
      return Scaffold(appBar: AppBar(), body: const SizedBox.shrink());
    }

    final exercises = s.exercises
        .where((e) =>
            e.weekNumber == weekNumber && e.sessionNumber == dayNumber)
        .toList();

    final hasConfiguredSet = exercises.isNotEmpty &&
        exercises.any((e) => e.sets.any((s) =>
            s.targetReps != null ||
            s.targetRepsMax != null ||
            s.targetWeight != null ||
            s.targetRpe != null ||
            s.weightIncrement != null ||
            s.targetDurationSecs != null));

    return Scaffold(
      appBar: AppBar(
        title: Text('Week $weekNumber · Day $dayNumber'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilledButton(
              onPressed:
                  hasConfiguredSet ? () => context.pop() : null,
              child: const Text('Confirm'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _pickExercise(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Add Exercise'),
      ),
      body: exercises.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.fitness_center_outlined,
                      size: 48, color: Colors.white24),
                  const SizedBox(height: 12),
                  Text(
                    'No exercises yet.\nTap + to add some.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.4)),
                  ),
                ],
              ),
            )
          : Builder(builder: (context) {
              final labels = _computePlanLabels(exercises);
              final colors = _computePlanSupersetColors(exercises);
              final slots = _buildPlanSlots(exercises);
              return ReorderableListView.builder(
                buildDefaultDragHandles: false,
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 100),
                itemCount: slots.length,
                onReorder: (oi, ni) => ref
                    .read(planEditorNotifierProvider.notifier)
                    .reorderSessionSlots(weekNumber, dayNumber, oi, ni),
                itemBuilder: (context, i) {
                  final slot = slots[i];
                  if (slot is PlanEditorExercise) {
                    return _ExercisePlanCard(
                      key: ValueKey(slot.id),
                      index: i,
                      label: labels[slot.id] ?? '${i + 1}',
                      labelColor: colors[slot.id],
                      entry: slot,
                    );
                  }
                  final group = slot as List<PlanEditorExercise>;
                  final groupId = group.first.supersetGroupId!;
                  final color = colors[group.first.id] ?? _kPlanSupersetColors[0];
                  return _PlanSupersetWrapper(
                    key: ValueKey(groupId),
                    index: i,
                    groupId: groupId,
                    exercises: group,
                    labels: labels,
                    color: color,
                    weekNumber: weekNumber,
                    dayNumber: dayNumber,
                  );
                },
              );
            }),
    );
  }
}

// ── Plan superset wrapper ─────────────────────────────────────────────────────

class _PlanSupersetWrapper extends ConsumerWidget {
  final int index;
  final String groupId;
  final List<PlanEditorExercise> exercises;
  final Map<String, String> labels;
  final Color color;
  final int weekNumber;
  final int dayNumber;

  const _PlanSupersetWrapper({
    super.key,
    required this.index,
    required this.groupId,
    required this.exercises,
    required this.labels,
    required this.color,
    required this.weekNumber,
    required this.dayNumber,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(planEditorNotifierProvider.notifier);
    final firstLabel = labels[exercises.first.id] ?? '';
    final slotNum = firstLabel.replaceAll(RegExp(r'[A-Za-z]+$'), '');

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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
                    onSelected: (v) {
                      if (v == 'break') notifier.breakSuperset(groupId);
                      if (v == 'remove') notifier.removeSuperset(groupId);
                    },
                    itemBuilder: (_) => const [
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
              buildDefaultDragHandles: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              onReorder: (oi, ni) =>
                  notifier.reorderWithinSuperset(groupId, oi, ni),
              children: [
                for (var i = 0; i < exercises.length; i++)
                  _ExercisePlanCard(
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

// ── Exercise plan card (card + table layout) ──────────────────────────────────

class _ExercisePlanCard extends ConsumerWidget {
  final int index;
  final String label;
  final Color? labelColor;
  final PlanEditorExercise entry;
  final bool isInSuperset;

  const _ExercisePlanCard({
    super.key,
    required this.index,
    required this.label,
    required this.entry,
    this.labelColor,
    this.isInSuperset = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(planEditorNotifierProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Exercise header ─────────────────────────────────────────
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
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_horiz,
                        color: Colors.white38, size: 20),
                    onSelected: (v) {
                      if (v == 'remove_from_ss') {
                        notifier.removeFromSuperset(entry.id);
                      } else if (v == 'remove') {
                        notifier.removeExerciseFromSession(entry.id);
                      }
                    },
                    itemBuilder: (_) => [
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
                  ReorderableDragStartListener(
                    index: index,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Icon(Icons.drag_handle,
                          color: Colors.white38, size: 20),
                    ),
                  ),
                ],
              ),
              Text(
                entry.exercise.muscleGroup,
                style:
                    const TextStyle(color: Colors.white38, fontSize: 12),
              ),
              const SizedBox(height: 10),

              // ── Goal type selector ──────────────────────────────────────
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Goal',
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                child: DropdownButton<String>(
                  value: entry.goalType,
                  isExpanded: true,
                  underline: const SizedBox(),
                  isDense: true,
                  items: const [
                    DropdownMenuItem(value: 'reps', child: Text('Reps')),
                    DropdownMenuItem(
                        value: 'reps_range', child: Text('Reps Range')),
                    DropdownMenuItem(value: 'amrap', child: Text('AMRAP')),
                    DropdownMenuItem(value: 'time', child: Text('Time')),
                  ],
                  onChanged: (v) {
                    if (v != null) {
                      notifier.updateExerciseType(entry.id, goalType: v);
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),

              // ── Intensity type selector (hidden for time-based goal) ────
              if (entry.goalType != 'time') ...[
                InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Intensity',
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  child: DropdownButton<String>(
                    value: entry.weightType,
                    isExpanded: true,
                    underline: const SizedBox(),
                    isDense: true,
                    items: const [
                      DropdownMenuItem(
                          value: 'percent_1rm', child: Text('% 1RM')),
                      DropdownMenuItem(value: 'rpe', child: Text('RPE')),
                      DropdownMenuItem(
                          value: 'rpe_range', child: Text('RPE Range')),
                      DropdownMenuItem(
                          value: 'prev_week_plus',
                          child: Text('Last Week +')),
                      DropdownMenuItem(
                          value: 'prev_session_plus',
                          child: Text('Last Session +')),
                    ],
                    onChanged: (v) {
                      if (v != null) {
                        notifier.updateExerciseType(entry.id, weightType: v);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 8),
              ],
              const SizedBox(height: 10),

              // ── Column headers ──────────────────────────────────────────
              _PlanTableHeader(
                  goalType: entry.goalType, weightType: entry.weightType),
              const Divider(height: 8),

              // ── Set rows ────────────────────────────────────────────────
              ...entry.sets.map((set) => _PlanSetRow(
                    key: ValueKey(set.id),
                    exerciseId: entry.id,
                    set: set,
                    goalType: entry.goalType,
                    weightType: entry.weightType,
                    canDelete: entry.sets.length > 1,
                  )),

              // ── Footer ──────────────────────────────────────────────────
              TextButton.icon(
                onPressed: () => notifier.addSetToExercise(entry.id),
                icon: const Icon(Icons.add_circle_outline, size: 16),
                label: const Text('Add Set'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white38,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Table header row ──────────────────────────────────────────────────────────

class _PlanTableHeader extends StatelessWidget {
  final String goalType;
  final String weightType;

  const _PlanTableHeader(
      {required this.goalType, required this.weightType});

  static const _style = TextStyle(fontSize: 11, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        children: [
          SizedBox(
            width: _kSetW,
            child: const Text('SET', style: _style, textAlign: TextAlign.center),
          ),
          const SizedBox(width: 6),
          // Goal columns
          if (goalType == 'time') ...[
            SizedBox(
              width: _kInputW * 1.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('TIME', style: _style),
                  const SizedBox(width: 2),
                  Tooltip(
                    message: _kTimeTooltip,
                    triggerMode: TooltipTriggerMode.tap,
                    child: const Icon(Icons.info_outline, size: 10, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
          ] else if (goalType == 'reps') ...[
            SizedBox(
              width: _kInputW,
              child: const Text('REPS', style: _style, textAlign: TextAlign.center),
            ),
            const SizedBox(width: 6),
          ] else if (goalType == 'reps_range') ...[
            SizedBox(
              width: _kInputW,
              child: const Text('MIN', style: _style, textAlign: TextAlign.center),
            ),
            const SizedBox(width: 6),
            SizedBox(
              width: _kInputW,
              child: const Text('MAX', style: _style, textAlign: TextAlign.center),
            ),
            const SizedBox(width: 6),
          ] else ...[
            // amrap — no reps columns
          ],
          // Intensity columns (hidden for time goal)
          if (goalType != 'time' && weightType == 'percent_1rm') ...[
            SizedBox(
              width: _kInputW,
              child: const Text('% 1RM', style: _style, textAlign: TextAlign.center),
            ),
            const SizedBox(width: 6),
          ] else if (weightType == 'rpe') ...[
            SizedBox(
              width: _kInputW,
              child: const Text('RPE', style: _style, textAlign: TextAlign.center),
            ),
            const SizedBox(width: 6),
          ] else if (goalType != 'time' && weightType == 'rpe_range') ...[
            SizedBox(
              width: _kInputW,
              child: const Text('RPE MIN', style: _style, textAlign: TextAlign.center),
            ),
            const SizedBox(width: 6),
            SizedBox(
              width: _kInputW,
              child: const Text('RPE MAX', style: _style, textAlign: TextAlign.center),
            ),
            const SizedBox(width: 6),
          ] else if (goalType != 'time') ...[
            // prev_week_plus / prev_session_plus
            SizedBox(
              width: _kInputW,
              child: const Text('+KG', style: _style, textAlign: TextAlign.center),
            ),
            const SizedBox(width: 6),
          ],
          SizedBox(width: _kDeleteW),
        ],
      ),
    );
  }
}

// ── Set row ───────────────────────────────────────────────────────────────────

class _PlanSetRow extends ConsumerStatefulWidget {
  final String exerciseId;
  final PlanEditorSet set;
  final String goalType;
  final String weightType;
  final bool canDelete;

  const _PlanSetRow({
    super.key,
    required this.exerciseId,
    required this.set,
    required this.goalType,
    required this.weightType,
    required this.canDelete,
  });

  @override
  ConsumerState<_PlanSetRow> createState() => _PlanSetRowState();
}

class _PlanSetRowState extends ConsumerState<_PlanSetRow> {
  late final TextEditingController _repsCtrl;
  late final TextEditingController _repsMaxCtrl;
  late final TextEditingController _weightCtrl;
  late final TextEditingController _rpeCtrl;
  late final TextEditingController _rpeMaxCtrl;
  late final TextEditingController _incrCtrl;
  late final TextEditingController _durationCtrl;

  static String _fmtDuration(int? secs) => _fmtDurationPlan(secs);
  static int? _parseDuration(String text) => _parseDurationPlan(text);

  @override
  void initState() {
    super.initState();
    final s = widget.set;
    _repsCtrl = TextEditingController(text: s.targetReps?.toString() ?? '');
    _repsMaxCtrl = TextEditingController(text: s.targetRepsMax?.toString() ?? '');
    _weightCtrl = TextEditingController(
        text: s.targetWeight != null
            ? s.targetWeight!.toStringAsFixed(s.targetWeight! % 1 == 0 ? 0 : 1)
            : '');
    _rpeCtrl = TextEditingController(
        text: s.targetRpe != null
            ? s.targetRpe!.toStringAsFixed(s.targetRpe! % 1 == 0 ? 0 : 1)
            : '');
    _rpeMaxCtrl = TextEditingController(
        text: s.targetRpeMax != null
            ? s.targetRpeMax!.toStringAsFixed(s.targetRpeMax! % 1 == 0 ? 0 : 1)
            : '');
    _incrCtrl = TextEditingController(
        text: s.weightIncrement != null
            ? s.weightIncrement!.toStringAsFixed(s.weightIncrement! % 1 == 0 ? 0 : 1)
            : '');
    _durationCtrl = TextEditingController(text: _fmtDuration(s.targetDurationSecs));
  }

  @override
  void dispose() {
    _repsCtrl.dispose();
    _repsMaxCtrl.dispose();
    _weightCtrl.dispose();
    _rpeCtrl.dispose();
    _rpeMaxCtrl.dispose();
    _incrCtrl.dispose();
    _durationCtrl.dispose();
    super.dispose();
  }

  /// Clamps an RPE controller value to ≤ 10 and saves.
  void _onRpeChanged(TextEditingController ctrl, String value) {
    final v = double.tryParse(value);
    if (v != null && v > 10) {
      ctrl.text = '10';
      ctrl.selection =
          TextSelection.collapsed(offset: ctrl.text.length);
    }
    _save();
  }

  /// Always writes all controller values so clearing a field (empty → null) works.
  void _save() {
    ref.read(planEditorNotifierProvider.notifier).updatePlanSet(
          widget.exerciseId,
          widget.set.id,
          targetReps: int.tryParse(_repsCtrl.text),
          targetRepsMax: int.tryParse(_repsMaxCtrl.text),
          targetWeight: double.tryParse(_weightCtrl.text),
          targetRpe: double.tryParse(_rpeCtrl.text),
          targetRpeMax: double.tryParse(_rpeMaxCtrl.text),
          weightIncrement: double.tryParse(_incrCtrl.text),
          targetDurationSecs: _parseDuration(_durationCtrl.text),
        );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(planEditorNotifierProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Row(
        children: [
          // Set number — tap to toggle warm-up
          GestureDetector(
            onTap: () async {
              final box = context.findRenderObject() as RenderBox?;
              if (box == null) return;
              final offset = box.localToGlobal(Offset.zero);
              final set = widget.set;
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
                              color: set.isWarmup
                                  ? Colors.orange.shade300
                                  : null)),
                    ]),
                  ),
                ],
              );
              if (choice == 'work' && set.isWarmup) {
                ref
                    .read(planEditorNotifierProvider.notifier)
                    .togglePlanSetWarmup(widget.exerciseId, set.id);
              } else if (choice == 'warmup' && !set.isWarmup) {
                ref
                    .read(planEditorNotifierProvider.notifier)
                    .togglePlanSetWarmup(widget.exerciseId, set.id);
              }
            },
            child: SizedBox(
              width: _kSetW,
              child: Text(
                widget.set.isWarmup ? 'W' : '${widget.set.setNumber}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.set.isWarmup
                      ? Colors.orange.shade300
                      : Colors.white70,
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),

          // Goal inputs
          if (widget.goalType == 'time') ...[
            SizedBox(
              width: _kInputW * 1.5,
              child: _PlanTimeField(
                controller: _durationCtrl,
                onChanged: (_) => _save(),
              ),
            ),
            const SizedBox(width: 6),
          ] else if (widget.goalType == 'reps') ...[
            SizedBox(
              width: _kInputW,
              child: _PlanNumField(
                controller: _repsCtrl,
                hint: '—',
                decimal: false,
                onChanged: (_) => _save(),
              ),
            ),
            const SizedBox(width: 6),
          ] else if (widget.goalType == 'reps_range') ...[
            SizedBox(
              width: _kInputW,
              child: _PlanNumField(
                controller: _repsCtrl,
                hint: '—',
                decimal: false,
                onChanged: (_) => _save(),
              ),
            ),
            const SizedBox(width: 6),
            SizedBox(
              width: _kInputW,
              child: _PlanNumField(
                controller: _repsMaxCtrl,
                hint: '—',
                decimal: false,
                onChanged: (_) => _save(),
              ),
            ),
            const SizedBox(width: 6),
          ],
          // amrap: no reps inputs

          // Intensity inputs (hidden for time goal)
          if (widget.goalType != 'time' && widget.weightType == 'percent_1rm') ...[
            SizedBox(
              width: _kInputW,
              child: _PlanNumField(
                controller: _weightCtrl,
                hint: '—',
                decimal: true,
                onChanged: (_) => _save(),
              ),
            ),
            const SizedBox(width: 6),
          ] else if (widget.goalType != 'time' && widget.weightType == 'rpe') ...[
            SizedBox(
              width: _kInputW,
              child: _PlanNumField(
                controller: _rpeCtrl,
                hint: '—',
                decimal: true,
                onChanged: (v) => _onRpeChanged(_rpeCtrl, v),
              ),
            ),
            const SizedBox(width: 6),
          ] else if (widget.goalType != 'time' && widget.weightType == 'rpe_range') ...[
            SizedBox(
              width: _kInputW,
              child: _PlanNumField(
                controller: _rpeCtrl,
                hint: '—',
                decimal: true,
                onChanged: (v) => _onRpeChanged(_rpeCtrl, v),
              ),
            ),
            const SizedBox(width: 6),
            SizedBox(
              width: _kInputW,
              child: _PlanNumField(
                controller: _rpeMaxCtrl,
                hint: '—',
                decimal: true,
                onChanged: (v) => _onRpeChanged(_rpeMaxCtrl, v),
              ),
            ),
            const SizedBox(width: 6),
          ] else if (widget.goalType != 'time') ...[
            // prev_week_plus / prev_session_plus — show increment input
            SizedBox(
              width: _kInputW,
              child: _PlanNumField(
                controller: _incrCtrl,
                hint: '0',
                decimal: true,
                onChanged: (_) => _save(),
              ),
            ),
            const SizedBox(width: 6),
          ],

          // Delete set
          SizedBox(
            width: _kDeleteW,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.remove_circle_outline,
                size: 18,
                color: widget.canDelete ? Colors.white38 : Colors.white12,
              ),
              onPressed: widget.canDelete
                  ? () => notifier.removeSetFromExercise(
                      widget.exerciseId, widget.set.id)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Number input field ────────────────────────────────────────────────────────

class _PlanNumField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool decimal;
  final ValueChanged<String> onChanged;

  const _PlanNumField({
    required this.controller,
    required this.hint,
    required this.decimal,
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
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
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
              color: Theme.of(context).colorScheme.primary),
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
      ),
      onChanged: onChanged,
    );
  }
}

// ── Time input field ──────────────────────────────────────────────────────────

class _PlanTimeField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _PlanTimeField({
    required this.controller,
    required this.onChanged,
  });

  @override
  State<_PlanTimeField> createState() => _PlanTimeFieldState();
}

class _PlanTimeFieldState extends State<_PlanTimeField> {
  late final FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _focus = FocusNode();
    _focus.addListener(() {
      if (!_focus.hasFocus) _reformat();
    });
  }

  void _reformat() {
    final secs = _parseDurationPlan(widget.controller.text);
    if (secs == null) return;
    final formatted = _fmtDurationPlan(secs);
    if (widget.controller.text != formatted) {
      widget.controller.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: _focus,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[\d:]')),
      ],
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
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
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
      ),
      onChanged: widget.onChanged,
    );
  }
}
