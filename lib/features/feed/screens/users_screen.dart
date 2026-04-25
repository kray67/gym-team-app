import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:gym_team/features/profile/models/user_profile.dart';
import 'package:gym_team/features/profile/providers/profile_provider.dart';
import 'package:gym_team/shared/widgets/user_avatar.dart';

class UsersScreen extends ConsumerWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(allUsersProvider);

    return usersAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (users) {
        if (users.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.group_outlined, size: 64, color: Colors.white38),
                  SizedBox(height: 16),
                  Text(
                    'No other users yet.',
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () => ref.refresh(allUsersProvider.future),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: users.length,
            itemBuilder: (context, i) => _UserTile(user: users[i]),
          ),
        );
      },
    );
  }
}

class _UserTile extends ConsumerWidget {
  final UserProfile user;
  const _UserTile({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFollowingAsync = ref.watch(isFollowingProvider(user.id));
    final name = user.displayName ?? user.username;
    final joined = user.createdAt != null
        ? 'Joined ${DateFormat('MMM yyyy').format(user.createdAt!)}'
        : user.username;

    return ListTile(
      leading: UserAvatar(
        name: name,
        avatarId: user.avatarId,
        avatarColor: user.avatarColor,
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(joined, style: const TextStyle(color: Colors.white54)),
      trailing: isFollowingAsync.when(
        loading: () => const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        error: (_, _) => const SizedBox.shrink(),
        data: (isFollowing) => _FollowButton(
          userId: user.id,
          isFollowing: isFollowing,
        ),
      ),
      onTap: () => context.push('/user/${user.id}'),
    );
  }
}

class _FollowButton extends ConsumerWidget {
  final String userId;
  final bool isFollowing;
  const _FollowButton({required this.userId, required this.isFollowing});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      onPressed: () async {
        final notifier = ref.read(socialNotifierProvider.notifier);
        if (isFollowing) {
          await notifier.unfollow(userId);
        } else {
          await notifier.follow(userId);
        }
      },
      child: Text(isFollowing ? 'Unfollow' : 'Follow'),
    );
  }
}
