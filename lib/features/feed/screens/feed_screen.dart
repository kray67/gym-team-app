import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:gym_team/features/feed/models/feed_item.dart';
import 'package:gym_team/features/feed/providers/feed_provider.dart';
import 'package:gym_team/features/feed/widgets/reaction_bar.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedAsync = ref.watch(activityFeedProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Feed')),
      body: feedAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.people_outline, size: 64, color: Colors.white38),
                    SizedBox(height: 16),
                    Text(
                      'Follow other users to see their activity here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => ref.refresh(activityFeedProvider.future),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: items.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) => _FeedItemTile(item: items[i]),
            ),
          );
        },
      ),
    );
  }
}

class _FeedItemTile extends StatelessWidget {
  final FeedItem item;
  const _FeedItemTile({required this.item});

  bool get _isWorkout => item.type == 'workout_completed';
  bool get _isNotification =>
      item.type == 'workout_commented' || item.type == 'workout_reacted';

  @override
  Widget build(BuildContext context) {
    final actor = item.actor;
    final actorName =
        actor != null ? (actor.displayName ?? actor.username) : 'Someone';
    final actorId = actor?.id ?? item.actorId;
    final timeAgo = _formatTimeAgo(item.createdAt);
    final sessionId = item.payload['session_id'] as String?;

    return InkWell(
      onTap: () => _handleTap(context, sessionId),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Actor row ──────────────────────────────────────────────────
            Row(
              children: [
                GestureDetector(
                  onTap: _isNotification
                      ? null
                      : () => context.push('/user/$actorId'),
                  child: CircleAvatar(
                    radius: 18,
                    child: Text(actorName[0].toUpperCase()),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(child: _buildTitle(actorName)),
                Text(timeAgo,
                    style:
                        const TextStyle(color: Colors.white38, fontSize: 12)),
                const SizedBox(width: 4),
                _buildTypeIcon(),
              ],
            ),
            // ── Reactions (only for content types, not notifications) ──────
            if (!_isNotification)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 46),
                child: ReactionBar(
                  feedItemId: item.id,
                  ownerId: item.actorId,
                  sessionId: sessionId,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _handleTap(BuildContext context, String? sessionId) {
    if (_isWorkout) {
      context.push('/feed/workout', extra: item);
    } else if (item.type == 'plan_published') {
      final planId = item.payload['plan_id'] as String?;
      if (planId != null) context.push('/plans/$planId');
    } else if (_isNotification && sessionId != null) {
      context.push('/workout/$sessionId');
    }
  }

  Widget _buildTitle(String actorName) {
    if (item.type == 'workout_completed') {
      final exerciseCount = item.payload['exercise_count'] as int? ?? 0;
      final durationMins =
          ((item.payload['duration_secs'] as int? ?? 0) / 60).round();
      return Text.rich(TextSpan(children: [
        TextSpan(
            text: actorName,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(
            text:
                ' completed a workout · $exerciseCount exercises · ${durationMins}min'),
      ]));
    } else if (item.type == 'plan_published') {
      final planTitle = item.payload['title'] as String? ?? 'a plan';
      return Text.rich(TextSpan(children: [
        TextSpan(
            text: actorName,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: ' published a plan: $planTitle'),
      ]));
    } else if (item.type == 'workout_commented') {
      return Text.rich(TextSpan(children: [
        TextSpan(
            text: actorName,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const TextSpan(text: ' commented on your workout'),
      ]));
    } else if (item.type == 'workout_reacted') {
      final emoji = _reactionEmoji(item.payload['reaction_type'] as String?);
      return Text.rich(TextSpan(children: [
        TextSpan(
            text: actorName,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: ' reacted $emoji to your workout'),
      ]));
    }
    return Text(actorName);
  }

  Widget _buildTypeIcon() {
    switch (item.type) {
      case 'workout_completed':
        return const Icon(Icons.fitness_center, size: 18, color: Colors.white38);
      case 'plan_published':
        return const Icon(Icons.list_alt, size: 18, color: Colors.white38);
      case 'workout_commented':
        return const Icon(Icons.comment_outlined,
            size: 18, color: Colors.white38);
      case 'workout_reacted':
        return const Icon(Icons.favorite_outline,
            size: 18, color: Colors.white38);
      default:
        return const SizedBox.shrink();
    }
  }

  String _reactionEmoji(String? type) {
    switch (type) {
      case 'heart':
        return '❤️';
      case 'thumbs_up':
        return '👍';
      case 'biceps':
        return '💪';
      default:
        return '';
    }
  }

  String _formatTimeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'now';
    if (diff.inHours < 1) return '${diff.inMinutes}m';
    if (diff.inDays < 1) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}d';
    return DateFormat('MMM d').format(dt);
  }
}
