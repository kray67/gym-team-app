import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/profile/providers/profile_provider.dart';
import 'package:gym_team/shared/widgets/user_avatar.dart';

class MyProfileScreen extends ConsumerWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = supabase.auth.currentUser!.id;
    final profileAsync = ref.watch(myProfileProvider);
    final followersAsync = ref.watch(followersCountProvider(currentUserId));
    final followingAsync = ref.watch(followingCountProvider(currentUserId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit profile',
            onPressed: () => context.push('/profile/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
            onPressed: () => context.push('/profile/settings'),
          ),
        ],
      ),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (profile) => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  UserAvatar(
                    name: profile.displayName ?? profile.username,
                    avatarId: profile.avatarId,
                    avatarColor: profile.avatarColor,
                    radius: 36,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.displayName ?? profile.username,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          '@${profile.username}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(profile.bio!),
              ],
              const SizedBox(height: 20),
              Row(
                children: [
                  _CountButton(
                    label: 'Followers',
                    countAsync: followersAsync,
                    onTap: () => context.push('/user/$currentUserId/followers'),
                  ),
                  const SizedBox(width: 32),
                  _CountButton(
                    label: 'Following',
                    countAsync: followingAsync,
                    onTap: () => context.push('/user/$currentUserId/followers?tab=following'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CountButton extends StatelessWidget {
  final String label;
  final AsyncValue<int> countAsync;
  final VoidCallback onTap;

  const _CountButton({
    required this.label,
    required this.countAsync,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: Column(
          children: [
            countAsync.when(
              data: (count) => Text(
                '$count',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              loading: () => const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              error: (_, _) => const Text('—'),
            ),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
