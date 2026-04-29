import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:gym_team/core/utils/formatters.dart';
import 'package:gym_team/features/plans/models/workout_plan.dart';
import 'package:gym_team/features/plans/providers/plan_active_notifier.dart';
import 'package:gym_team/features/plans/screens/plan_detail_screen.dart'
    show startPlanSession;
import 'package:gym_team/features/workout/models/workout_session.dart';
import 'package:gym_team/features/workout/providers/active_workout_provider.dart';
import 'package:gym_team/features/workout/providers/workout_history_provider.dart';

class WorkoutHistoryScreen extends ConsumerWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(workoutHistoryProvider);
    final activePlanAsync = ref.watch(activePlanProvider);
    final activePlan = activePlanAsync.valueOrNull;
    final planLoaded = activePlanAsync is AsyncData;
    final noActivePlan = planLoaded && activePlan == null;

    Widget? bottomBar;
    if (planLoaded) {
      bottomBar = activePlan != null
          ? _ActivePlanBar(plan: activePlan)
          : _NoActivePlanBar();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Workout')),
      body: history.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (sessions) {
          final banner = noActivePlan
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: Card(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: ListTile(
                      dense: true,
                      leading: const Icon(Icons.bolt_outlined, size: 20),
                      title: const Text(
                        'No active plan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      subtitle: const Text(
                        'Set a plan as active to track progress',
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                      onTap: () => context.go('/plans'),
                    ),
                  ),
                )
              : null;

          if (sessions.isEmpty) {
            return Column(
              children: [
                if (banner != null) banner,
                const Expanded(
                  child: Center(
                    child: Text(
                      'No workouts yet.\nTap the button below to start.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                ),
              ],
            );
          }

          return Column(
            children: [
              if (banner != null) banner,
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(
                      top: 8, bottom: activePlan != null ? 140 : 88),
                  itemCount: sessions.length,
                  itemBuilder: (context, i) =>
                      _SessionCard(session: sessions[i]),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: bottomBar,
    );
  }
}

// ── History list (used as the History tab inside WorkoutScreen) ───────────────

/// The workout history list without a Scaffold. Used as the History tab body
/// inside [WorkoutScreen].
class WorkoutHistoryList extends ConsumerWidget {
  const WorkoutHistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(workoutHistoryProvider);
    return history.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (sessions) {
        if (sessions.isEmpty) {
          return const Center(
            child: Text(
              'No workouts yet.\nStart a session to see your history here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: sessions.length,
          itemBuilder: (context, i) => _SessionCard(session: sessions[i]),
        );
      },
    );
  }
}

// ── Active plan bar ───────────────────────────────────────────────────────────

class _ActivePlanBar extends ConsumerWidget {
  final WorkoutPlan plan;
  const _ActivePlanBar({required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Determine next incomplete session
    final completed =
        ref.watch(planCompletedSessionsProvider(plan.id)).valueOrNull ?? {};
    final weeks = plan.weeks ?? 1;
    final sessionsPerWeek = plan.sessionsPerWeek ?? 1;

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

    final label = nextSession != null
        ? '${plan.title}: Start Week ${nextSession.$1} · Day ${nextSession.$2}'
        : '${plan.title}: Restart Week 1 · Day 1';
    final week = nextSession?.$1 ?? 1;
    final day = nextSession?.$2 ?? 1;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Active plan start button
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: plan.exercises.isEmpty
                    ? null
                    : () => startPlanSession(context, ref, plan, week, day),
                icon: const Icon(Icons.bolt),
                label: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Empty workout button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  ref
                      .read(activeWorkoutNotifierProvider.notifier)
                      .startWorkout();
                  context.push('/workout/active');
                },
                icon: const Icon(Icons.add),
                label: const Text('Start New Empty Workout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── No active plan bar ────────────────────────────────────────────────────────

class _NoActivePlanBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        child: SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              ref
                  .read(activeWorkoutNotifierProvider.notifier)
                  .startWorkout();
              context.push('/workout/active');
            },
            icon: const Icon(Icons.add),
            label: const Text('Start New Empty Workout'),
          ),
        ),
      ),
    );
  }
}

// ── Session card ──────────────────────────────────────────────────────────────

class _SessionCard extends StatelessWidget {
  final WorkoutSession session;
  const _SessionCard({required this.session});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('EEE, d MMM yyyy · HH:mm')
        .format(session.startedAt.toLocal());
    final planName = session.plan?.title ?? 'Workout';
    final durationStr = formatDuration(session.durationSecs);

    int totalSets = 0;
    double totalWeightKg = 0;
    for (final ex in session.exercises) {
      for (final s in ex.sets.where((s) => s.completed && !s.isWarmup)) {
        totalSets++;
        totalWeightKg += (s.weightKg ?? 0) * (s.reps ?? 0);
      }
    }
    final weightStr =
        totalWeightKg > 0 ? '${totalWeightKg.round()} kg' : '0 kg';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title:
            Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                planName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.timer_outlined,
                      size: 13, color: Colors.white54),
                  const SizedBox(width: 3),
                  Text(durationStr,
                      style: const TextStyle(
                          color: Colors.white54, fontSize: 12)),
                  const SizedBox(width: 12),
                  const Icon(Icons.monitor_weight_outlined,
                      size: 13, color: Colors.white54),
                  const SizedBox(width: 3),
                  Text(weightStr,
                      style: const TextStyle(
                          color: Colors.white54, fontSize: 12)),
                  const SizedBox(width: 12),
                  const Icon(Icons.repeat, size: 13, color: Colors.white54),
                  const SizedBox(width: 3),
                  Text('$totalSets sets',
                      style: const TextStyle(
                          color: Colors.white54, fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push('/workout/${session.id}'),
      ),
    );
  }
}
