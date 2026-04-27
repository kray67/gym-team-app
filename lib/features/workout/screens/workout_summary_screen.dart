import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import 'package:gym_team/features/workout/models/exercise_record.dart';
import 'package:gym_team/features/workout/models/session_exercise.dart';
import 'package:gym_team/features/workout/models/session_set.dart';
import 'package:gym_team/features/workout/models/workout_session.dart';
import 'package:gym_team/core/utils/formatters.dart';
import 'package:gym_team/features/workout/providers/exercise_records_provider.dart';
import 'package:gym_team/features/workout/providers/workout_history_provider.dart';

class WorkoutSummaryScreen extends ConsumerStatefulWidget {
  final String sessionId;
  const WorkoutSummaryScreen({super.key, required this.sessionId});

  @override
  ConsumerState<WorkoutSummaryScreen> createState() =>
      _WorkoutSummaryScreenState();
}

class _WorkoutSummaryScreenState extends ConsumerState<WorkoutSummaryScreen> {
  final _shareKey = GlobalKey();
  bool _sharingImage = false;

  // ── Helpers ────────────────────────────────────────────────────────────────

  double _totalWeight(WorkoutSession session) {
    double total = 0;
    for (final ex in session.exercises) {
      for (final s in ex.sets.where((s) => s.completed && !s.isWarmup)) {
        total += (s.weightKg ?? 0) * (s.reps ?? 0);
      }
    }
    return total;
  }

  int _totalSets(WorkoutSession session) =>
      session.exercises.fold(0, (sum, e) => sum + e.sets.where((s) => s.completed && !s.isWarmup).length);

  SessionSet? _bestSet(SessionExercise entry) {
    final completed = entry.sets.where((s) => s.completed).toList();
    if (completed.isEmpty) return null;
    final t = entry.exercise?.trackingType ?? 'weight_reps';
    if (t == 'time' || t == 'weight_time') {
      return completed.reduce((a, b) => (a.durationSecs ?? 0) >= (b.durationSecs ?? 0) ? a : b);
    }
    if (t == 'distance_time') {
      return completed.reduce((a, b) => (a.distanceM ?? 0) >= (b.distanceM ?? 0) ? a : b);
    }
    if (t == 'reps_only') {
      return completed.reduce((a, b) => (a.reps ?? 0) >= (b.reps ?? 0) ? a : b);
    }
    return completed.reduce((a, b) => (a.weightKg ?? 0) >= (b.weightKg ?? 0) ? a : b);
  }

  String _bestSetStr(SessionExercise entry) {
    final best = _bestSet(entry);
    if (best == null) return '—';
    final t = entry.exercise?.trackingType ?? 'weight_reps';
    switch (t) {
      case 'reps_only':
        return best.reps != null ? '${best.reps} reps' : '—';
      case 'time':
        return formatDuration(best.durationSecs);
      case 'weight_time':
        final w = best.weightKg;
        final wStr = w != null ? (w % 1 == 0 ? '${w.toInt()} kg' : '${w.toStringAsFixed(1)} kg') : null;
        final tStr = formatDuration(best.durationSecs);
        return wStr != null ? '$wStr — $tStr' : tStr;
      case 'distance_time':
        final km = best.distanceM != null ? '${(best.distanceM! / 1000).toStringAsFixed(2)} km' : null;
        final tStr = formatDuration(best.durationSecs);
        return km != null ? '$km — $tStr' : tStr;
      default: // weight_reps
        final repsStr = best.reps != null ? '${best.reps}' : 'AMRAP';
        if (best.weightKg != null && best.weightKg! > 0) {
          final w = best.weightKg!;
          final wStr = w % 1 == 0 ? '${w.toInt()} kg' : '${w.toStringAsFixed(1)} kg';
          return '$wStr × $repsStr';
        }
        return repsStr;
    }
  }

  String _formatWeight(double kg) {
    if (kg <= 0) return '0 kg';
    return '${kg.round()} kg';
  }

  // ── Share ──────────────────────────────────────────────────────────────────

  String _buildShareText(WorkoutSession session) {
    final date = DateFormat('EEE, d MMM yyyy').format(session.startedAt.toLocal());
    final buf = StringBuffer();
    buf.writeln('Gym Team Workout — $date');
    buf.writeln(
        '⏱ ${formatDuration(session.durationSecs)}  '
        '🏋 ${_formatWeight(_totalWeight(session))}  '
        '🔁 ${_totalSets(session)} sets');
    buf.writeln();
    for (final ex in session.exercises) {
      final completed = ex.sets.where((s) => s.completed).length;
      if (completed == 0) continue;
      final name = ex.exercise?.name ?? 'Exercise';
      buf.writeln('$completed × $name — best: ${_bestSetStr(ex)}');
    }
    return buf.toString().trim();
  }

  Future<void> _shareText(WorkoutSession session) async {
    await Share.share(_buildShareText(session));
  }

  Future<void> _shareImage() async {
    setState(() => _sharingImage = true);
    try {
      final boundary =
          _shareKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;
      final bytes = byteData.buffer.asUint8List();
      await Share.shareXFiles([
        XFile.fromData(bytes, mimeType: 'image/png', name: 'gym_team_workout.png'),
      ]);
    } finally {
      if (mounted) setState(() => _sharingImage = false);
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(workoutDetailProvider(widget.sessionId));
    final newRecords =
        ref.watch(sessionNewRecordsProvider(widget.sessionId)).valueOrNull ?? [];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Workout Complete'),
        actions: [
          TextButton(
            onPressed: () => context.go('/workout'),
            child: const Text('Done'),
          ),
        ],
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (session) => _buildBody(session, newRecords),
      ),
    );
  }

  Widget _buildBody(WorkoutSession session, List<ExerciseRecord> newRecords) {
    final totalKg = _totalWeight(session);
    final totalSets = _totalSets(session);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // ── Shareable card ─────────────────────────────────────────────────
          RepaintBoundary(
            key: _shareKey,
            child: _ShareCard(
              session: session,
              totalKg: totalKg,
              totalSets: totalSets,
              formatDuration: formatDuration,
              formatWeight: _formatWeight,
              bestSetStr: _bestSetStr,
            ),
          ),

          // ── New personal records ───────────────────────────────────────────
          if (newRecords.isNotEmpty) ...[
            const SizedBox(height: 20),
            _NewRecordsSection(records: newRecords),
          ],

          const SizedBox(height: 24),

          // ── Share buttons ──────────────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.text_snippet_outlined),
                  label: const Text('Share as text'),
                  onPressed: () => _shareText(session),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  icon: _sharingImage
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child:
                              CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Icon(Icons.image_outlined),
                  label: const Text('Share as image'),
                  onPressed: _sharingImage ? null : _shareImage,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ── Done button ────────────────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => context.go('/workout'),
              child: const Text('View workout history'),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Shareable card ────────────────────────────────────────────────────────────

class _ShareCard extends StatelessWidget {
  final WorkoutSession session;
  final double totalKg;
  final int totalSets;
  final String Function(int?) formatDuration;
  final String Function(double) formatWeight;
  final String Function(SessionExercise) bestSetStr;

  const _ShareCard({
    required this.session,
    required this.totalKg,
    required this.totalSets,
    required this.formatDuration,
    required this.formatWeight,
    required this.bestSetStr,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('EEE, d MMM yyyy').format(session.startedAt.toLocal());
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'GYM TEAM',
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(date,
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 13)),
                  ],
                ),
              ),
              Icon(Icons.fitness_center,
                  color: theme.colorScheme.primary, size: 22),
            ],
          ),

          const SizedBox(height: 16),

          // ── Stats row ────────────────────────────────────────────────────
          Row(
            children: [
              _StatItem(
                icon: Icons.timer_outlined,
                label: formatDuration(session.durationSecs),
              ),
              const SizedBox(width: 20),
              _StatItem(
                icon: Icons.monitor_weight_outlined,
                label: formatWeight(totalKg),
              ),
              const SizedBox(width: 20),
              _StatItem(
                icon: Icons.repeat,
                label: '$totalSets sets',
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ── Exercise table ───────────────────────────────────────────────
          const Row(
            children: [
              Expanded(
                child: Text('Exercise',
                    style: TextStyle(fontSize: 11, color: Colors.white38)),
              ),
              Text('Best Set',
                  style: TextStyle(fontSize: 11, color: Colors.white38)),
            ],
          ),
          const Divider(height: 12),

          ...session.exercises.where((e) {
            return e.sets.any((s) => s.completed && !s.isWarmup);
          }).map((ex) {
            final completedCount = ex.sets.where((s) => s.completed && !s.isWarmup).length;
            final name = ex.exercise?.name ?? 'Exercise';
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '$completedCount × $name',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  Text(
                    bestSetStr(ex),
                    style: const TextStyle(
                        fontSize: 13, color: Colors.white70),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _StatItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.white54),
        const SizedBox(width: 5),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 13)),
      ],
    );
  }
}

// ── New records section ───────────────────────────────────────────────────────

class _NewRecordsSection extends StatelessWidget {
  final List<ExerciseRecord> records;
  const _NewRecordsSection({required this.records});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Group records by exercise for a cleaner display.
    final byExercise = <String, List<ExerciseRecord>>{};
    for (final r in records) {
      byExercise.putIfAbsent(r.exerciseName ?? r.exerciseId, () => []).add(r);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.shade900.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.shade700.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.emoji_events, color: Colors.amber.shade400, size: 18),
              const SizedBox(width: 8),
              Text(
                'New Personal Records',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade300,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...() {
            final entries = byExercise.entries.toList();
            final widgets = <Widget>[];
            for (var i = 0; i < entries.length; i++) {
              if (i > 0) {
                widgets.add(Divider(
                  height: 16,
                  color: Colors.amber.shade700.withValues(alpha: 0.3),
                ));
              }
              final name = entries[i].key;
              final recs = entries[i].value;
              widgets.add(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  ...recs.map((r) => Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          '${r.typeLabel}  ${r.valueLabel}',
                          style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.primary),
                        ),
                      )),
                ],
              ));
            }
            return widgets;
          }(),
        ],
      ),
    );
  }
}
