import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/plans/models/plan_exercise.dart';
import 'package:gym_team/features/plans/models/workout_plan.dart';
import 'package:gym_team/features/plans/providers/plan_active_notifier.dart';
import 'package:gym_team/features/plans/providers/plan_editor_provider.dart';
import 'package:gym_team/features/plans/providers/plans_provider.dart';
import 'package:gym_team/features/workout/providers/active_workout_provider.dart';
import 'package:gym_team/features/workout/providers/workout_history_provider.dart';
import 'package:gym_team/shared/widgets/user_avatar.dart';

const _equipmentLabels = {
  'bodyweight': 'Bodyweight',
  'dumbbells': 'Dumbbells',
  'garage_gym': 'Garage Gym',
  'commercial_gym': 'Commercial Gym',
};

const _difficultyLabels = {
  'novice': 'Novice',
  'intermediate': 'Intermediate',
  'advanced': 'Advanced',
};

// ── Top-level helpers ─────────────────────────────────────────────────────────

/// Sets [plan] as the active plan, showing the 1RM dialog if needed.
/// Reused by both [_ActivePlanButton] and the inline activation prompt in [_SessionCard].
Future<void> activatePlan(
    BuildContext context, WidgetRef ref, WorkoutPlan plan) async {
  // If there's already a different active plan, ask for confirmation first.
  final currentActive = await ref.read(activePlanProvider.future);
  if (currentActive != null && currentActive.id != plan.id) {
    if (!context.mounted) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Switch Active Plan?'),
        content: Text(
          'You currently have "${currentActive.title}" as your active plan. '
          'Switching will reset all your progress on it.\n\nContinue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Switch'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
  }

  final hasPercent1rm =
      plan.exercises.any((e) => e.weightType == 'percent_1rm');
  Map<String, double> oneRMs = {};
  if (hasPercent1rm) {
    final stored = await ref.read(userPlan1rmProvider(plan.id).future);
    if (!context.mounted) return;
    final result =
        await _showFullPlan1RMDialog(context, plan, prefilled: stored);
    if (result == null) return;
    oneRMs = result;
  }
  if (!context.mounted) return;
  try {
    await ref
        .read(planActiveNotifierProvider.notifier)
        .setActivePlan(plan.id, oneRMs);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('"${plan.title}" set as active plan')),
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

/// Starts a plan session. Pre-fills 1RM from stored values; shows dialog for
/// %1RM exercises so the user can verify/update them before starting.
Future<void> startPlanSession(
  BuildContext context,
  WidgetRef ref,
  WorkoutPlan plan,
  int week,
  int day,
) async {
  final sessionExercises = plan.exercises
      .where((e) => e.weekNumber == week && e.sessionNumber == day)
      .toList();

  final percentExercises =
      sessionExercises.where((e) => e.weightType == 'percent_1rm').toList();

  Map<String, double> oneRMs = {};
  if (percentExercises.isNotEmpty) {
    final stored = await ref.read(userPlan1rmProvider(plan.id).future);
    if (!context.mounted) return;

    final seen = <String>{};
    final unique =
        percentExercises.where((e) => seen.add(e.exerciseId)).toList();
    final missing =
        unique.where((e) => !stored.containsKey(e.exerciseId)).toList();

    if (missing.isEmpty) {
      oneRMs = stored;
    } else {
      final result =
          await _show1RMDialog(context, missing, prefilled: stored);
      if (result == null) return;
      oneRMs = {...stored, ...result};
    }
  }

  if (context.mounted) {
    ref
        .read(activeWorkoutNotifierProvider.notifier)
        .startWorkoutFromPlan(plan, week, day, oneRMs: oneRMs);
    context.push('/workout/active');
  }
}

Future<Map<String, double>?> _show1RMDialog(
    BuildContext context, List<PlanExercise> exercises,
    {Map<String, double> prefilled = const {}}) async {
  final seen = <String>{};
  final unique = exercises.where((e) => seen.add(e.exerciseId)).toList();
  final controllers = {
    for (final e in unique)
      e.exerciseId: TextEditingController(
        text: prefilled.containsKey(e.exerciseId)
            ? prefilled[e.exerciseId]!
                .toStringAsFixed(prefilled[e.exerciseId]! % 1 == 0 ? 0 : 1)
            : '',
      )
  };

  final result = await showDialog<Map<String, double>>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('1RM Values'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'This session uses % of 1RM.\nEnter your one-rep max (kg) for each exercise:',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 16),
            ...unique.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TextField(
                    controller: controllers[e.exerciseId],
                    decoration: InputDecoration(
                      labelText: e.exercise?.name ?? 'Exercise',
                      suffixText: 'kg',
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
                    ],
                  ),
                )),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel')),
        FilledButton(
          onPressed: () {
            final map = <String, double>{};
            for (final e in unique) {
              final v = double.tryParse(controllers[e.exerciseId]!.text);
              if (v != null && v > 0) map[e.exerciseId] = v;
            }
            Navigator.pop(ctx, map);
          },
          child: const Text('Start'),
        ),
      ],
    ),
  );

  for (final c in controllers.values) {
    c.dispose();
  }
  return result;
}

/// Shows 1RM dialog collecting values for the whole plan (all weeks).
/// Used when setting the active plan or restarting.
Future<Map<String, double>?> _showFullPlan1RMDialog(
    BuildContext context, WorkoutPlan plan,
    {Map<String, double> prefilled = const {}}) async {
  final percentExercises =
      plan.exercises.where((e) => e.weightType == 'percent_1rm').toList();
  if (percentExercises.isEmpty) return {};

  final seen = <String>{};
  final unique =
      percentExercises.where((e) => seen.add(e.exerciseId)).toList();
  final controllers = {
    for (final e in unique)
      e.exerciseId: TextEditingController(
        text: prefilled.containsKey(e.exerciseId)
            ? prefilled[e.exerciseId]!
                .toStringAsFixed(prefilled[e.exerciseId]! % 1 == 0 ? 0 : 1)
            : '',
      )
  };

  final result = await showDialog<Map<String, double>>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('1RM Values'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'This plan uses % of 1RM.\nEnter your current one-rep max (kg) for each exercise:',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 16),
            ...unique.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TextField(
                    controller: controllers[e.exerciseId],
                    decoration: InputDecoration(
                      labelText: e.exercise?.name ?? 'Exercise',
                      suffixText: 'kg',
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
                    ],
                  ),
                )),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel')),
        FilledButton(
          onPressed: () {
            final map = <String, double>{};
            for (final e in unique) {
              final v = double.tryParse(controllers[e.exerciseId]!.text);
              if (v != null && v > 0) map[e.exerciseId] = v;
            }
            Navigator.pop(ctx, map);
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );

  for (final c in controllers.values) {
    c.dispose();
  }
  return result;
}

// ── Restart Plan helper ───────────────────────────────────────────────────────

Future<void> _restartPlan(
    BuildContext context, WidgetRef ref, WorkoutPlan plan) async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Restart Plan?'),
      content: const Text(
        'This will reset your progress for this plan. Your workout history will be preserved.',
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel')),
        FilledButton(
          onPressed: () => Navigator.pop(ctx, true),
          style: FilledButton.styleFrom(backgroundColor: Colors.red.shade700),
          child: const Text('Restart'),
        ),
      ],
    ),
  );
  if (confirm != true || !context.mounted) return;

  Map<String, double> oneRMs = {};
  final hasPercent1rm =
      plan.exercises.any((e) => e.weightType == 'percent_1rm');
  if (hasPercent1rm) {
    final stored = await ref.read(userPlan1rmProvider(plan.id).future);
    if (!context.mounted) return;
    final result =
        await _showFullPlan1RMDialog(context, plan, prefilled: stored);
    if (result == null) return;
    oneRMs = result;
  }

  if (!context.mounted) return;
  try {
    await ref
        .read(planActiveNotifierProvider.notifier)
        .restartPlan(plan.id, oneRMs);
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

// ── Plan detail screen ────────────────────────────────────────────────────────

class PlanDetailScreen extends ConsumerStatefulWidget {
  final String planId;
  const PlanDetailScreen({super.key, required this.planId});

  @override
  ConsumerState<PlanDetailScreen> createState() => _PlanDetailScreenState();
}

class _PlanDetailScreenState extends ConsumerState<PlanDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(planDetailProvider(widget.planId));
    final activePlan = ref.watch(activePlanProvider).valueOrNull;
    final isActivePlan = activePlan?.id == widget.planId;

    return Scaffold(
      appBar: AppBar(
        title: async.maybeWhen(
          data: (p) => Text(p.title),
          orElse: () => const Text('Plan'),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Workouts'),
          ],
        ),
        actions: [
          async.maybeWhen(
            data: (plan) {
              final isOwner =
                  plan.ownerId == supabase.auth.currentUser?.id;
              final hasPercent1rm =
                  plan.exercises.any((e) => e.weightType == 'percent_1rm');

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Options popup (active plan only)
                  if (isActivePlan)
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) async {
                        if (value == 'edit_1rm') {
                          final stored = await ref
                              .read(userPlan1rmProvider(widget.planId).future);
                          if (!context.mounted) return;
                          final result = await _showFullPlan1RMDialog(
                              context, plan,
                              prefilled: stored);
                          if (result == null || !context.mounted) return;
                          try {
                            for (final entry in result.entries) {
                              await ref
                                  .read(planActiveNotifierProvider.notifier)
                                  .update1rm(
                                      widget.planId, entry.key, entry.value);
                            }
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('1RM values updated')),
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
                        } else if (value == 'restart') {
                          await _restartPlan(context, ref, plan);
                        }
                      },
                      itemBuilder: (ctx) => [
                        if (hasPercent1rm)
                          const PopupMenuItem(
                            value: 'edit_1rm',
                            child: Text('Edit 1RM'),
                          ),
                        const PopupMenuItem(
                          value: 'restart',
                          child: Text('Restart Plan'),
                        ),
                      ],
                    ),
                  // Edit plan (owner only)
                  if (isOwner)
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () {
                        ref
                            .read(planEditorNotifierProvider.notifier)
                            .startEdit(plan);
                        context.push('/plans/new');
                      },
                    ),
                ],
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (plan) => _PlanDetailBody(
          plan: plan,
          isActivePlan: isActivePlan,
          tabController: _tabController,
        ),
      ),
    );
  }
}

// ── Main body ─────────────────────────────────────────────────────────────────

class _PlanDetailBody extends ConsumerWidget {
  final WorkoutPlan plan;
  final bool isActivePlan;
  final TabController tabController;

  const _PlanDetailBody({
    required this.plan,
    required this.isActivePlan,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completed =
        ref.watch(planCompletedSessionsProvider(plan.id)).valueOrNull ?? {};
    final isOwner = plan.ownerId == supabase.auth.currentUser?.id;

    final weeks = plan.weeks ?? 1;
    final sessionsPerWeek = plan.sessionsPerWeek ?? 1;

    // Find next incomplete session
    (int, int)? nextSession;
    outer:
    for (var w = 1; w <= weeks; w++) {
      for (var d = 1; d <= sessionsPerWeek; d++) {
        if (!completed.contains((w, d))) {
          nextSession = (w, d);
          break outer;
        }
      }
    }

    return Column(
      children: [
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              // ── Overview tab ──────────────────────────────────────────────
              _OverviewTab(plan: plan, isOwner: isOwner),
              // ── Workouts tab ──────────────────────────────────────────────
              _WorkoutsTab(
                plan: plan,
                completed: completed,
                nextSession: nextSession,
                isActivePlan: isActivePlan,
              ),
            ],
          ),
        ),

        // Bottom action bar
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    if (!isOwner) ...[
                      _SaveButton(planId: plan.id),
                      const SizedBox(width: 8),
                    ],
                    Expanded(
                      child: _ActivePlanButton(
                          plan: plan, isActivePlan: isActivePlan),
                    ),
                  ],
                ),
                if (isActivePlan) ...[
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: nextSession != null
                        ? FilledButton.icon(
                            onPressed: plan.exercises.isEmpty
                                ? null
                                : () => startPlanSession(context, ref, plan,
                                    nextSession!.$1, nextSession.$2),
                            icon: const Icon(Icons.play_arrow),
                            label: Text(
                                'Start Week ${nextSession.$1} · Day ${nextSession.$2}'),
                          )
                        : FilledButton.icon(
                            onPressed: () =>
                                startPlanSession(context, ref, plan, 1, 1),
                            icon: const Icon(Icons.replay),
                            label: const Text('Restart from Week 1 · Day 1'),
                          ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Overview tab ──────────────────────────────────────────────────────────────

class _OverviewTab extends StatelessWidget {
  final WorkoutPlan plan;
  final bool isOwner;

  const _OverviewTab({required this.plan, required this.isOwner});

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('MMM d, yyyy HH:mm');

    final hasDescription =
        plan.description != null && plan.description!.isNotEmpty;
    final hasDetails = plan.equipment != null ||
        plan.difficulty != null ||
        plan.weeks != null ||
        plan.sessionsPerWeek != null ||
        plan.avgDurationMins != null ||
        plan.createdAt != null ||
        plan.updatedAt != null;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      children: [
        // Owner row (for plans you don't own)
        if (!isOwner && plan.owner != null) ...[
          Builder(builder: (ctx) {
            return InkWell(
              onTap: plan.ownerId != null
                  ? () => ctx.push('/user/${plan.ownerId}')
                  : null,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    UserAvatar(
                      name: plan.owner!.displayName ?? plan.owner!.username,
                      avatarId: plan.owner!.avatarId,
                      avatarColor: plan.owner!.avatarColor,
                      radius: 14,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'by ${plan.owner!.displayName ?? plan.owner!.username}',
                      style: TextStyle(
                        color: Theme.of(ctx).colorScheme.primary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],

        // Description section
        if (hasDescription) ...[
          const Text(
            'Description',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            plan.description!,
            style: const TextStyle(color: Colors.white70, height: 1.5),
          ),
          const SizedBox(height: 24),
        ],

        // Program Details section
        if (hasDetails) ...[
          const Text(
            'Program Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Divider(color: Colors.white12),
          if (plan.equipment != null)
            _DetailRow(
              label: 'Equipment',
              value: _equipmentLabels[plan.equipment] ?? plan.equipment!,
            ),
          if (plan.difficulty != null)
            _DetailRow(
              label: 'Level',
              value: _difficultyLabels[plan.difficulty] ?? plan.difficulty!,
            ),
          if (plan.weeks != null)
            _DetailRow(
              label: 'Program Duration',
              value: '${plan.weeks} week${plan.weeks == 1 ? '' : 's'}',
            ),
          if (plan.sessionsPerWeek != null)
            _DetailRow(
              label: 'Frequency',
              value:
                  '${plan.sessionsPerWeek} day${plan.sessionsPerWeek == 1 ? '' : 's'} per week',
            ),
          if (plan.avgDurationMins != null)
            _DetailRow(
              label: 'Time Per Workout',
              value: '${plan.avgDurationMins} minutes',
            ),
          if (plan.createdAt != null)
            _DetailRow(
              label: 'Created',
              value: dateFmt.format(plan.createdAt!.toLocal()),
            ),
          if (plan.updatedAt != null)
            _DetailRow(
              label: 'Last Edited',
              value: dateFmt.format(plan.updatedAt!.toLocal()),
            ),
        ],

        if (!hasDescription && !hasDetails)
          const Padding(
            padding: EdgeInsets.only(top: 32),
            child: Center(
              child: Text('No details available.',
                  style: TextStyle(color: Colors.white38)),
            ),
          ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white54, fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Workouts tab ──────────────────────────────────────────────────────────────

class _WorkoutsTab extends StatelessWidget {
  final WorkoutPlan plan;
  final Set<(int, int)> completed;
  final (int, int)? nextSession;
  final bool isActivePlan;

  const _WorkoutsTab({
    required this.plan,
    required this.completed,
    required this.nextSession,
    required this.isActivePlan,
  });

  @override
  Widget build(BuildContext context) {
    final weeks = plan.weeks ?? 1;
    final sessionsPerWeek = plan.sessionsPerWeek ?? 1;

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        for (var w = 1; w <= weeks; w++)
          _WeekAccordion(
            weekNumber: w,
            sessionsPerWeek: sessionsPerWeek,
            plan: plan,
            completed: completed,
            nextSession: nextSession,
            isActivePlan: isActivePlan,
          ),
      ],
    );
  }
}

// ── Week accordion ────────────────────────────────────────────────────────────

class _WeekAccordion extends ConsumerWidget {
  final int weekNumber;
  final int sessionsPerWeek;
  final WorkoutPlan plan;
  final Set<(int, int)> completed;
  final (int, int)? nextSession;
  final bool isActivePlan;

  const _WeekAccordion({
    required this.weekNumber,
    required this.sessionsPerWeek,
    required this.plan,
    required this.completed,
    required this.nextSession,
    required this.isActivePlan,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekCompleted = List.generate(sessionsPerWeek, (i) => i + 1)
        .every((d) => completed.contains((weekNumber, d)));

    // Expand only the week that contains the next session
    final containsNext =
        nextSession != null && nextSession!.$1 == weekNumber;

    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: containsNext,
          tilePadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          title: Row(
            children: [
              if (isActivePlan) ...[
                if (weekCompleted)
                  const Icon(Icons.check_circle, size: 16, color: Colors.green)
                else
                  const Icon(Icons.calendar_today_outlined,
                      size: 16, color: Colors.white38),
                const SizedBox(width: 8),
              ],
              Text(
                'Week $weekNumber',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: weekCompleted ? Colors.white54 : Colors.white,
                ),
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Column(
                children: [
                  for (var d = 1; d <= sessionsPerWeek; d++)
                    _SessionCard(
                      plan: plan,
                      weekNumber: weekNumber,
                      dayNumber: d,
                      isCompleted: completed.contains((weekNumber, d)),
                      isNext: nextSession == (weekNumber, d),
                      isActivePlan: isActivePlan,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Session card (expandable) ─────────────────────────────────────────────────

class _SessionCard extends ConsumerWidget {
  final WorkoutPlan plan;
  final int weekNumber;
  final int dayNumber;
  final bool isCompleted;
  final bool isNext;
  final bool isActivePlan;

  const _SessionCard({
    required this.plan,
    required this.weekNumber,
    required this.dayNumber,
    required this.isCompleted,
    required this.isNext,
    required this.isActivePlan,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oneRMs =
        ref.watch(userPlan1rmProvider(plan.id)).valueOrNull ?? const {};

    final exercises = plan.exercises
        .where((e) =>
            e.weekNumber == weekNumber && e.sessionNumber == dayNumber)
        .toList();

    final totalWorkSets = exercises.fold<int>(
        0, (sum, e) => sum + e.sets.where((s) => !s.isWarmup).length);
    final exCount = exercises.length;

    Widget? leadingIcon;
    if (isActivePlan) {
      if (isCompleted) {
        leadingIcon = const Icon(Icons.check_circle, color: Colors.green, size: 20);
      } else if (isNext) {
        leadingIcon = Icon(Icons.play_circle_outline,
            color: Theme.of(context).colorScheme.primary, size: 20);
      } else {
        leadingIcon = const Icon(Icons.radio_button_unchecked,
            color: Colors.white24, size: 20);
      }
    }
    // else null → plan not active, no leading icon, title pulls left

    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      // No border — status is shown via icon only
      child: exercises.isEmpty
          ? ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: leadingIcon,
              title: Text('Day $dayNumber',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('No exercises',
                  style: TextStyle(color: Colors.white24, fontSize: 12)),
            )
          : Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                initiallyExpanded: isNext,
                tilePadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                leading: leadingIcon,
                title: Text(
                  'Day $dayNumber',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? Colors.white54 : Colors.white,
                  ),
                ),
                subtitle: Text(
                  exCount == 0
                      ? 'No exercises'
                      : '$exCount exercise${exCount == 1 ? '' : 's'} · $totalWorkSets set${totalWorkSets == 1 ? '' : 's'}',
                  style: const TextStyle(
                      color: Colors.white38, fontSize: 12),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                    child: Column(
                      children: [
                        for (final ex in exercises) ...[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ex.exercise?.name ?? '—',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(height: 1),
                                      Text(
                                        () {
                                          final wSets = ex.sets
                                              .where((s) => !s.isWarmup)
                                              .length;
                                          final warmups = ex.sets
                                              .where((s) => s.isWarmup)
                                              .length;
                                          final target =
                                              _setTargetDescription(ex,
                                                  oneRMs: oneRMs);
                                          final setLine =
                                              '$wSets set${wSets == 1 ? '' : 's'}'
                                              '${warmups > 0 ? ' + $warmups W' : ''}';
                                          return target.isNotEmpty
                                              ? '$setLine · $target'
                                              : setLine;
                                        }(),
                                        style: const TextStyle(
                                          color: Colors.white54,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (ex != exercises.last)
                            const Divider(height: 1, color: Colors.white12),
                        ],
                        if (isActivePlan) ...[
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: () => startPlanSession(
                                  context, ref, plan, weekNumber, dayNumber),
                              icon: const Icon(Icons.play_arrow, size: 16),
                              label: Text('Start Day $dayNumber'),
                              style: FilledButton.styleFrom(
                                  visualDensity: VisualDensity.compact),
                            ),
                          ),
                          const SizedBox(height: 4),
                        ] else if (!isCompleted) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.bolt_outlined,
                                  size: 14, color: Colors.white38),
                              const SizedBox(width: 6),
                              const Expanded(
                                child: Text(
                                  'Set this plan as active to start sessions',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white38),
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    activatePlan(context, ref, plan),
                                style: TextButton.styleFrom(
                                  visualDensity: VisualDensity.compact,
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text('Set as Active',
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

String _setTargetDescription(PlanExercise e,
    {Map<String, double> oneRMs = const {}}) {
  final workSets = e.sets.where((s) => !s.isWarmup).toList();
  final first = workSets.isNotEmpty ? workSets.first : null;
  if (first == null) return '';

  String fmtKg(double kg) =>
      kg % 1 == 0 ? '${kg.round()}kg' : '${kg.toStringAsFixed(1)}kg';

  String reps;
  switch (e.goalType) {
    case 'amrap':
      reps = 'AMRAP';
    case 'reps_range':
      reps = (first.targetReps != null && first.targetRepsMax != null)
          ? '${first.targetReps}–${first.targetRepsMax}'
          : '?';
    default:
      reps = first.targetReps?.toString() ?? '';
  }

  String intensity;
  switch (e.weightType) {
    case 'percent_1rm':
      if (first.targetWeight == null) {
        intensity = '';
      } else {
        final pct = first.targetWeight!;
        final oneRm = oneRMs[e.exerciseId];
        if (oneRm != null) {
          final workingKg = oneRm * pct / 100;
          final weightStr = fmtKg(workingKg);
          if (e.goalType == 'amrap') {
            intensity = '$weightStr AMRAP @ ${pct.round()}%';
            reps = '';
          } else {
            intensity = '$weightStr×$reps @ ${pct.round()}%';
            reps = '';
          }
        } else {
          intensity = '@ ${pct.round()}%';
        }
      }
    case 'rpe':
      intensity = first.targetRpe != null
          ? '@ RPE ${first.targetRpe!.toStringAsFixed(first.targetRpe! % 1 == 0 ? 0 : 1)}'
          : '';
    case 'rpe_range':
      intensity = (first.targetRpe != null && first.targetRpeMax != null)
          ? '@ RPE ${first.targetRpe!.round()}–${first.targetRpeMax!.round()}'
          : '';
    case 'prev_week_plus':
      intensity = first.weightIncrement != null
          ? '+ ${first.weightIncrement!.toStringAsFixed(first.weightIncrement! % 1 == 0 ? 0 : 1)}kg (prev wk)'
          : '';
    case 'prev_session_plus':
      intensity = first.weightIncrement != null
          ? '+ ${first.weightIncrement!.toStringAsFixed(first.weightIncrement! % 1 == 0 ? 0 : 1)}kg (prev sess)'
          : '';
    default:
      intensity = '';
  }

  if (reps.isNotEmpty && intensity.isNotEmpty &&
      e.weightType != 'percent_1rm') {
    final repsLabel = e.goalType == 'amrap' ? reps : '$reps reps';
    return '$repsLabel $intensity';
  }
  if (reps.isEmpty && intensity.isEmpty) return '';
  if (intensity.isEmpty) return e.goalType == 'amrap' ? reps : '$reps reps';
  if (reps.isEmpty) return intensity;
  return '$reps $intensity';
}

// ── Active Plan button ────────────────────────────────────────────────────────

class _ActivePlanButton extends ConsumerWidget {
  final WorkoutPlan plan;
  final bool isActivePlan;

  const _ActivePlanButton(
      {required this.plan, required this.isActivePlan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isActivePlan) {
      return OutlinedButton.icon(
        onPressed: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Remove Active Plan?'),
              content: const Text(
                  'This plan will no longer be active and all progress will be reset.'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text('Cancel')),
                FilledButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: const Text('Remove'),
                ),
              ],
            ),
          );
          if (confirm == true) {
            try {
              await ref
                  .read(planActiveNotifierProvider.notifier)
                  .clearActivePlan(plan.id);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Active plan removed')),
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
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.green,
          side: const BorderSide(color: Colors.green),
        ),
        icon: const Icon(Icons.check_circle_outline, size: 18),
        label: const Text('Active Plan'),
      );
    }

    return OutlinedButton.icon(
      onPressed: () => activatePlan(context, ref, plan),
      icon: const Icon(Icons.bolt_outlined, size: 18),
      label: const Text('Set as Active'),
    );
  }
}

// ── Save button ───────────────────────────────────────────────────────────────

class _SaveButton extends ConsumerWidget {
  final String planId;
  const _SaveButton({required this.planId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(isPlanSavedProvider(planId));
    final isSaved = async.valueOrNull ?? false;

    return OutlinedButton.icon(
      onPressed: () async {
        final userId = supabase.auth.currentUser!.id;
        if (isSaved) {
          await supabase
              .from('saved_plans')
              .delete()
              .eq('user_id', userId)
              .eq('plan_id', planId);
        } else {
          await supabase
              .from('saved_plans')
              .insert({'user_id': userId, 'plan_id': planId});
        }
        ref.invalidate(isPlanSavedProvider(planId));
        ref.invalidate(savedPlansProvider);
      },
      icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_outline),
      label: Text(isSaved ? 'Saved' : 'Save'),
    );
  }
}
