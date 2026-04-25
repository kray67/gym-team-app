import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/feed/models/feed_item.dart';
import 'package:gym_team/features/feed/providers/comments_provider.dart';
import 'package:gym_team/features/feed/widgets/reaction_bar.dart';
import 'package:gym_team/shared/widgets/user_avatar.dart';
import 'package:intl/intl.dart';
import 'package:gym_team/core/utils/formatters.dart';

class FeedWorkoutDetailScreen extends ConsumerStatefulWidget {
  final FeedItem item;
  const FeedWorkoutDetailScreen({super.key, required this.item});

  @override
  ConsumerState<FeedWorkoutDetailScreen> createState() =>
      _FeedWorkoutDetailScreenState();
}

class _FeedWorkoutDetailScreenState
    extends ConsumerState<FeedWorkoutDetailScreen> {
  final _commentController = TextEditingController();
  bool _posting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _postComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;
    setState(() => _posting = true);
    try {
      await ref.read(commentsNotifierProvider.notifier).addComment(
            widget.item.id,
            text,
            ownerId: widget.item.actorId,
            sessionId: widget.item.payload['session_id'] as String?,
          );
      _commentController.clear();
    } finally {
      if (mounted) setState(() => _posting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final actor = item.actor;
    final actorName =
        actor != null ? (actor.displayName ?? actor.username) : 'Someone';
    final actorId = actor?.id ?? item.actorId;
    final sessionId = item.payload['session_id'] as String?;

    final durationSecs = item.payload['duration_secs'] as int? ?? 0;
    final durationStr = formatDuration(durationSecs);

    final exercises =
        (item.payload['exercises'] as List<dynamic>? ?? []).cast<Map>();

    // Compute total weight and total sets from payload
    int totalSets = 0;
    double totalWeightKg = 0;
    for (final ex in exercises) {
      final sets = (ex['sets'] as List<dynamic>? ?? []).cast<Map>();
      totalSets += sets.length;
      for (final s in sets) {
        final w = (s['weight_kg'] as num?)?.toDouble() ?? 0;
        final r = (s['reps'] as int?) ?? 0;
        totalWeightKg += w * r;
      }
    }

    final commentsAsync = ref.watch(feedCommentsProvider(item.id));
    final myUserId = supabase.auth.currentUser!.id;

    return Scaffold(
      appBar: AppBar(title: const Text('Workout')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // ── Actor row ─────────────────────────────────────────────
                GestureDetector(
                  onTap: () => context.push('/user/$actorId'),
                  child: Row(
                    children: [
                      UserAvatar(
                        name: actorName,
                        avatarId: item.actor?.avatarId,
                        avatarColor: item.actor?.avatarColor,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(actorName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          Text(
                            DateFormat('MMM d · HH:mm').format(item.createdAt),
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // ── Stat chips: duration · total weight · sets ─────────────
                Wrap(
                  spacing: 8,
                  children: [
                    Chip(
                      avatar: const Icon(Icons.timer_outlined, size: 16),
                      label: Text(durationStr),
                      visualDensity: VisualDensity.compact,
                    ),
                    Chip(
                      avatar: const Icon(Icons.monitor_weight_outlined,
                          size: 16),
                      label: Text(_formatWeight(totalWeightKg)),
                      visualDensity: VisualDensity.compact,
                    ),
                    Chip(
                      avatar: const Icon(Icons.repeat, size: 16),
                      label: Text('$totalSets sets'),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // ── Simplified exercise table ──────────────────────────────
                if (exercises.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('No exercise detail available.',
                        style: TextStyle(color: Colors.white38)),
                  )
                else ...[
                  // Header row
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Exercise',
                              style: TextStyle(
                                  fontSize: 11, color: Colors.white38)),
                        ),
                        Text('Best Set',
                            style: TextStyle(
                                fontSize: 11, color: Colors.white38)),
                      ],
                    ),
                  ),
                  const Divider(height: 4),
                  ...exercises.map((ex) => _ExerciseRow(exercise: ex)),
                ],

                const SizedBox(height: 12),

                // ── Reactions ─────────────────────────────────────────────
                ReactionBar(
                  feedItemId: item.id,
                  ownerId: item.actorId,
                  sessionId: sessionId,
                ),
                const SizedBox(height: 20),

                // ── Comments ──────────────────────────────────────────────
                const Text('Comments',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                commentsAsync.when(
                  loading: () => const Center(
                      child: CircularProgressIndicator(strokeWidth: 2)),
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
                                  icon: const Icon(Icons.delete_outline,
                                      size: 18),
                                  onPressed: () => ref
                                      .read(commentsNotifierProvider.notifier)
                                      .deleteComment(item.id, c.id),
                                )
                              : null,
                        );
                      }).toList(),
                    );
                  },
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),

          // ── Comment input ──────────────────────────────────────────────────
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
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                    onPressed: _posting ? null : _postComment,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatWeight(double kg) {
    if (kg <= 0) return '0 kg';
    return '${kg.round()} kg';
  }
}

// ── Simplified exercise row ───────────────────────────────────────────────────

class _ExerciseRow extends StatelessWidget {
  final Map exercise;
  const _ExerciseRow({required this.exercise});

  @override
  Widget build(BuildContext context) {
    final name = exercise['name'] as String? ?? 'Exercise';
    final weightType = exercise['weight_type'] as String? ?? 'kg';
    final sets = (exercise['sets'] as List<dynamic>? ?? []).cast<Map>();
    final setCount = sets.length;

    // Find best set: highest weight_kg (or highest RPE for rpe type)
    Map? bestSet;
    for (final s in sets) {
      if (bestSet == null) {
        bestSet = s;
      } else if (weightType == 'rpe') {
        final cur = (s['rpe'] as num?)?.toDouble() ?? 0;
        final best = (bestSet['rpe'] as num?)?.toDouble() ?? 0;
        if (cur > best) bestSet = s;
      } else {
        final cur = (s['weight_kg'] as num?)?.toDouble() ?? 0;
        final best = (bestSet['weight_kg'] as num?)?.toDouble() ?? 0;
        if (cur > best) bestSet = s;
      }
    }

    String bestSetStr = '—';
    if (bestSet != null) {
      final reps = bestSet['reps'] as int?;
      final repsStr = reps != null ? '$reps' : 'AMRAP';
      if (weightType == 'rpe') {
        final rpe = (bestSet['rpe'] as num?)?.toDouble();
        bestSetStr = rpe != null ? 'RPE ${rpe.toStringAsFixed(1)} × $repsStr' : repsStr;
      } else {
        final w = (bestSet['weight_kg'] as num?)?.toDouble() ?? 0;
        final wStr = w > 0
            ? (w % 1 == 0 ? '${w.toInt()} kg' : '${w.toStringAsFixed(1)} kg')
            : '—';
        bestSetStr = '$wStr × $repsStr';
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$setCount × $name',
              style: const TextStyle(fontSize: 13),
            ),
          ),
          Text(
            bestSetStr,
            style: const TextStyle(fontSize: 13, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
