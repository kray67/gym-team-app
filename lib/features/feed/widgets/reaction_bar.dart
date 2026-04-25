import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/feed/providers/reactions_provider.dart';

const _kReactions = [
  ('heart', '❤️'),
  ('thumbs_up', '👍'),
  ('biceps', '💪'),
];

class ReactionBar extends ConsumerWidget {
  final String feedItemId;
  final String ownerId;
  final String? sessionId;

  const ReactionBar({
    super.key,
    required this.feedItemId,
    required this.ownerId,
    this.sessionId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reactionsAsync = ref.watch(feedReactionsProvider(feedItemId));
    final myUserId = supabase.auth.currentUser!.id;

    return reactionsAsync.when(
      loading: () => const SizedBox(height: 32),
      error: (_, _) => const SizedBox(height: 32),
      data: (reactions) => Row(
        children: _kReactions.map((r) {
          final (type, emoji) = r;
          final count = reactions.where((rx) => rx.type == type).length;
          final isActive =
              reactions.any((rx) => rx.type == type && rx.userId == myUserId);
          return _ReactionChip(
            emoji: emoji,
            count: count,
            isActive: isActive,
            onTap: () => ref
                .read(reactionsNotifierProvider.notifier)
                .toggleReaction(
                  feedItemId,
                  type,
                  ownerId: ownerId,
                  sessionId: sessionId,
                ),
          );
        }).toList(),
      ),
    );
  }
}

class _ReactionChip extends StatelessWidget {
  final String emoji;
  final int count;
  final bool isActive;
  final VoidCallback onTap;

  const _ReactionChip({
    required this.emoji,
    required this.count,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 6),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: isActive
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 14)),
            if (count > 0) ...[
              const SizedBox(width: 4),
              Text(
                '$count',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
