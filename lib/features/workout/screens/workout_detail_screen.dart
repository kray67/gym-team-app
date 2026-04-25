import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:gym_team/core/utils/formatters.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/feed/providers/comments_provider.dart';
import 'package:gym_team/features/feed/providers/feed_provider.dart';
import 'package:gym_team/features/feed/widgets/reaction_bar.dart';
import 'package:gym_team/shared/widgets/user_avatar.dart';
import 'package:gym_team/features/workout/models/session_exercise.dart';
import 'package:gym_team/features/workout/models/session_set.dart';
import 'package:gym_team/features/workout/models/workout_session.dart';
import 'package:gym_team/features/workout/providers/exercise_records_provider.dart';
import 'package:gym_team/features/workout/providers/workout_history_provider.dart';

class WorkoutDetailScreen extends ConsumerStatefulWidget {
  final String sessionId;
  const WorkoutDetailScreen({super.key, required this.sessionId});

  @override
  ConsumerState<WorkoutDetailScreen> createState() =>
      _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends ConsumerState<WorkoutDetailScreen> {
  final _commentController = TextEditingController();
  bool _posting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _postComment(String feedItemId) async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;
    setState(() => _posting = true);
    try {
      await ref.read(commentsNotifierProvider.notifier).addComment(
            feedItemId,
            text,
            ownerId: supabase.auth.currentUser!.id,
            sessionId: widget.sessionId,
          );
      _commentController.clear();
    } finally {
      if (mounted) setState(() => _posting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sessionAsync = ref.watch(workoutDetailProvider(widget.sessionId));
    final feedItemIdAsync =
        ref.watch(workoutFeedItemIdProvider(widget.sessionId));
    final myUserId = supabase.auth.currentUser!.id;

    return Scaffold(
      appBar: AppBar(title: const Text('Workout Detail')),
      body: sessionAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 40, color: Colors.white38),
                const SizedBox(height: 12),
                const Text(
                  'This workout could not be loaded.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                const Text(
                  'It may have been deleted or is no longer available.',
                  style: TextStyle(color: Colors.white54, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        data: (session) {
          final feedItemId = feedItemIdAsync.valueOrNull;

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(12),
                  children: [
                    _buildSummaryCard(session),
                    const SizedBox(height: 8),
                    ...session.exercises.map((e) => _ExerciseDetail(
                          entry: e,
                          sessionId: widget.sessionId,
                        )),

                    // ── Reactions & Comments (if feed item exists) ──────────
                    if (feedItemId != null) ...[
                      const SizedBox(height: 12),
                      ReactionBar(
                        feedItemId: feedItemId,
                        ownerId: myUserId,
                      ),
                      const SizedBox(height: 16),
                      const Text('Comments',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      _CommentsSection(
                        feedItemId: feedItemId,
                        myUserId: myUserId,
                      ),
                      const SizedBox(height: 80),
                    ],
                  ],
                ),
              ),

              // ── Comment input (only when feed item exists) ────────────────
              if (feedItemIdAsync.valueOrNull != null)
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 8,
                      top: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _commentController,
                            decoration: const InputDecoration(
                              hintText: 'Add a comment…',
                              border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                            ),
                            textCapitalization: TextCapitalization.sentences,
                            maxLength: 500,
                            maxLines: null,
                            buildCounter: (_,
                                    {required currentLength,
                                    required isFocused,
                                    maxLength}) =>
                                null,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton.filled(
                          icon: _posting
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, color: Colors.white))
                              : const Icon(Icons.send),
                          onPressed: _posting
                              ? null
                              : () => _postComment(
                                  feedItemIdAsync.valueOrNull!),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard(WorkoutSession session) {
    final date = DateFormat('EEE, d MMM yyyy · HH:mm')
        .format(session.startedAt.toLocal());
    final totalSets = session.exercises
        .fold<int>(0, (sum, e) => sum + e.sets.where((s) => s.completed && !s.isWarmup).length);
    double totalWeightKg = 0;
    for (final ex in session.exercises) {
      for (final s in ex.sets.where((s) => s.completed && !s.isWarmup)) {
        totalWeightKg += (s.weightKg ?? 0) * (s.reps ?? 0);
      }
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 12),
            Row(
              children: [
                _StatChip(
                  icon: Icons.timer_outlined,
                  label: formatDuration(session.durationSecs),
                ),
                const SizedBox(width: 12),
                _StatChip(
                  icon: Icons.monitor_weight_outlined,
                  label: totalWeightKg > 0
                      ? '${totalWeightKg.round()} kg'
                      : '0 kg',
                ),
                const SizedBox(width: 12),
                _StatChip(
                  icon: Icons.repeat,
                  label: '$totalSets sets',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Comments section ──────────────────────────────────────────────────────────

class _CommentsSection extends ConsumerWidget {
  final String feedItemId;
  final String myUserId;
  const _CommentsSection(
      {required this.feedItemId, required this.myUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentsAsync = ref.watch(feedCommentsProvider(feedItemId));
    return commentsAsync.when(
      loading: () =>
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      error: (e, _) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          'Comments could not be loaded.',
          style: TextStyle(color: Colors.white38, fontSize: 12),
        ),
      ),
      data: (comments) {
        if (comments.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('No comments yet.',
                style: TextStyle(color: Colors.white38)),
          );
        }
        return Column(
          children: comments.map((c) {
            final isOwn = c.userId == myUserId;
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: UserAvatar(
                name: c.authorName,
                radius: 16,
              ),
              title: Text(c.authorName,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold)),
              subtitle: Text(c.content),
              trailing: isOwn
                  ? IconButton(
                      icon: const Icon(Icons.delete_outline, size: 18),
                      onPressed: () => ref
                          .read(commentsNotifierProvider.notifier)
                          .deleteComment(feedItemId, c.id),
                    )
                  : null,
            );
          }).toList(),
        );
      },
    );
  }
}

// ── Stat chip ─────────────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.white54),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 13)),
      ],
    );
  }
}

// ── Exercise detail card ──────────────────────────────────────────────────────

class _ExerciseDetail extends ConsumerWidget {
  final SessionExercise entry;
  final String sessionId;
  const _ExerciseDetail({required this.entry, required this.sessionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prSetIds =
        ref.watch(sessionPrSetIdsProvider(sessionId)).valueOrNull ?? {};
    final name = entry.exercise?.name ?? 'Unknown exercise';
    final muscleGroup = entry.exercise?.muscleGroup ?? '';
    final completedSets = entry.sets.where((s) => s.completed).length;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary)),
                      if (muscleGroup.isNotEmpty)
                        Text(muscleGroup,
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 12)),
                    ],
                  ),
                ),
                Text(
                  '$completedSets/${entry.sets.length} sets',
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
            if (entry.sets.isNotEmpty) ...[
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    SizedBox(
                        width: 36,
                        child: Text('SET',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                            textAlign: TextAlign.center)),
                    SizedBox(width: 8),
                    Expanded(
                        child: Text('KG',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                            textAlign: TextAlign.center)),
                    SizedBox(width: 8),
                    Expanded(
                        child: Text('REPS',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                            textAlign: TextAlign.center)),
                    SizedBox(width: 8),
                    SizedBox(
                        width: 36,
                        child: Text('✓',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                            textAlign: TextAlign.center)),
                  ],
                ),
              ),
              const Divider(height: 8),
              ...entry.sets.map((s) => _SetRow(
                    set: s,
                    isPr: prSetIds.contains(s.id),
                  )),
            ],
          ],
        ),
      ),
    );
  }
}

class _SetRow extends StatelessWidget {
  final SessionSet set;
  final bool isPr;
  const _SetRow({required this.set, this.isPr = false});

  @override
  Widget build(BuildContext context) {
    final weight = set.weightKg != null
        ? (set.weightKg! % 1 == 0
            ? set.weightKg!.toInt().toString()
            : set.weightKg!.toStringAsFixed(1))
        : '--';
    final reps = set.reps?.toString() ?? '--';

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            color: set.completed
                ? Colors.green.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Row(
            children: [
              SizedBox(
                width: 36,
                child: Text(
                  set.isWarmup ? 'W' : '${set.setNumber}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: set.isWarmup
                          ? Colors.orange.shade300
                          : set.completed
                              ? Colors.green
                              : Colors.white70),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                  child: Text(weight,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14))),
              const SizedBox(width: 8),
              Expanded(
                  child: Text(reps,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14))),
              const SizedBox(width: 8),
              SizedBox(
                width: 36,
                child: Icon(
                  set.completed ? Icons.check_circle : Icons.check_circle_outline,
                  size: 18,
                  color: set.completed ? Colors.green : Colors.white24,
                ),
              ),
            ],
          ),
        ),
        if (isPr)
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
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
