import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_team/features/plans/models/workout_plan.dart';
import 'package:gym_team/features/plans/providers/plan_active_notifier.dart';
import 'package:gym_team/features/plans/providers/plan_editor_provider.dart';
import 'package:gym_team/features/plans/screens/plan_detail_screen.dart'
    show startPlanSession, showFullPlan1RMDialog;
import 'package:gym_team/features/workout/providers/active_workout_provider.dart';
import 'package:gym_team/features/workout/providers/workout_history_provider.dart';
import 'package:gym_team/features/workout/screens/workout_history_screen.dart';

class WorkoutScreen extends ConsumerStatefulWidget {
  const WorkoutScreen({super.key});

  @override
  ConsumerState<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends ConsumerState<WorkoutScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout'),
        bottom: TabBar(
          controller: _tabs,
          tabs: const [
            Tab(text: 'Workout'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          const _WorkoutTab(),
          const WorkoutHistoryList(),
        ],
      ),
    );
  }
}

// ── Workout tab ───────────────────────────────────────────────────────────────

class _WorkoutTab extends ConsumerWidget {
  const _WorkoutTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activePlanAsync = ref.watch(activePlanProvider);

    return activePlanAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (plan) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (plan != null) ...[
              _ActivePlanSection(plan: plan),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),
            ],
            OutlinedButton.icon(
              onPressed: () {
                ref
                    .read(activeWorkoutNotifierProvider.notifier)
                    .startWorkout();
                context.push('/workout/active');
              },
              icon: const Icon(Icons.add),
              label: const Text('Start New Empty Workout'),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Active plan section ───────────────────────────────────────────────────────

class _ActivePlanSection extends ConsumerWidget {
  final WorkoutPlan plan;
  const _ActivePlanSection({required this.plan});

  (int, int) _nextSession(Set<(int, int)> completed) {
    final weeks = plan.weeks ?? 1;
    final spw = plan.sessionsPerWeek ?? 1;
    for (var w = 1; w <= weeks; w++) {
      for (var d = 1; d <= spw; d++) {
        if (!completed.contains((w, d))) return (w, d);
      }
    }
    return (1, 1);
  }

  Future<void> _updateOneRM(BuildContext context, WidgetRef ref) async {
    final stored = await ref.read(userPlan1rmProvider(plan.id).future);
    if (!context.mounted) return;
    final result = await showFullPlan1RMDialog(context, plan, prefilled: stored);
    if (result == null || !context.mounted) return;
    final notifier = ref.read(planActiveNotifierProvider.notifier);
    for (final entry in result.entries) {
      await notifier.update1rm(plan.id, entry.key, entry.value);
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('1RM values updated')),
      );
    }
  }

  Future<void> _restartPlan(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Restart Plan?'),
        content: const Text(
          'This will reset your session progress. Your workout history is preserved.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Restart'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    try {
      await ref
          .read(planActiveNotifierProvider.notifier)
          .restartPlan(plan.id, {});
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Plan progress reset')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red.shade800,
          ),
        );
      }
    }
  }

  Future<void> _archivePlan(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Archive Plan?'),
        content: const Text(
          'Your workout history will be preserved. You can re-activate this plan later.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red.shade700,
            ),
            child: const Text('Archive'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    try {
      await ref
          .read(planActiveNotifierProvider.notifier)
          .clearActivePlan(plan.id);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red.shade800,
          ),
        );
      }
    }
  }

  void _editNextSession(BuildContext context, WidgetRef ref,
      int nextWeek, int nextDay) {
    ref
        .read(planEditorNotifierProvider.notifier)
        .startEdit(plan);
    context.push('/plans/session-editor?week=$nextWeek&day=$nextDay');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completed =
        ref.watch(planCompletedSessionsProvider(plan.id)).valueOrNull ?? {};
    final (nextWeek, nextDay) = _nextSession(completed);

    final sessionExercises = plan.exercises
        .where((e) => e.weekNumber == nextWeek && e.sessionNumber == nextDay)
        .toList()
      ..sort((a, b) => a.position.compareTo(b.position));

    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Plan name row + options menu
        Row(
          children: [
            Expanded(
              child: Text(
                plan.title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            TextButton(
              onPressed: () => context.push('/plans/${plan.id}'),
              child: const Text('View Plan'),
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                switch (value) {
                  case 'update_1rm':
                    _updateOneRM(context, ref);
                  case 'restart':
                    _restartPlan(context, ref);
                  case 'archive':
                    _archivePlan(context, ref);
                  case 'edit_session':
                    _editNextSession(context, ref, nextWeek, nextDay);
                }
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 'update_1rm',
                  child: Text('Update 1RM'),
                ),
                const PopupMenuItem(
                  value: 'restart',
                  child: Text('Restart Plan'),
                ),
                const PopupMenuItem(
                  value: 'edit_session',
                  child: Text('Edit Next Session'),
                ),
                PopupMenuItem(
                  value: 'archive',
                  child: Text(
                    'Archive Plan',
                    style: TextStyle(color: Colors.red.shade300),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Next session card
        Card(
          color: colorScheme.surfaceContainerHighest,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Week $nextWeek · Session $nextDay',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),

                // Exercise list
                if (sessionExercises.isEmpty)
                  const Text(
                    'No exercises in this session.',
                    style: TextStyle(color: Colors.white54, fontSize: 13),
                  )
                else
                  ...sessionExercises.map((e) {
                    final workSets =
                        e.sets.where((s) => !s.isWarmup).toList();
                    final count = workSets.length;

                    // Build set summary label
                    String setLabel;
                    if (workSets.isEmpty) {
                      setLabel = '';
                    } else {
                      final first = workSets.first;
                      if (e.goalType == 'reps' && first.targetReps != null) {
                        setLabel = '${count}×${first.targetReps}';
                      } else if (e.goalType == 'reps_range' &&
                          first.targetReps != null &&
                          first.targetRepsMax != null) {
                        setLabel =
                            '${count}×${first.targetReps}–${first.targetRepsMax}';
                      } else if (e.goalType == 'amrap') {
                        setLabel = '${count}× AMRAP';
                      } else if (e.goalType == 'time' &&
                          first.targetDurationSecs != null) {
                        final secs = first.targetDurationSecs!;
                        final m = secs ~/ 60;
                        final s = (secs % 60).toString().padLeft(2, '0');
                        setLabel = '${count}×$m:$s';
                      } else {
                        setLabel = '$count sets';
                      }
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              e.exercise?.name ?? '',
                              style: const TextStyle(fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (setLabel.isNotEmpty)
                            Text(
                              setLabel,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white54),
                            ),
                        ],
                      ),
                    );
                  }),

                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: sessionExercises.isEmpty
                      ? null
                      : () => startPlanSession(
                          context, ref, plan, nextWeek, nextDay),
                  icon: const Icon(Icons.bolt),
                  label: Text('Start Week $nextWeek · Session $nextDay'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
