import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_team/features/profile/models/user_profile.dart';
import 'package:gym_team/features/profile/providers/profile_provider.dart';
import 'package:gym_team/shared/widgets/user_avatar.dart';

class FollowersScreen extends ConsumerStatefulWidget {
  final String userId;
  final int initialTab;
  const FollowersScreen({super.key, required this.userId, this.initialTab = 0});

  @override
  ConsumerState<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends ConsumerState<FollowersScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTab,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connections'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Followers'),
            Tab(text: 'Following'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _UserList(usersAsync: ref.watch(followersProvider(widget.userId))),
          _UserList(usersAsync: ref.watch(followingProvider(widget.userId))),
        ],
      ),
    );
  }
}

class _UserList extends StatelessWidget {
  final AsyncValue<List<UserProfile>> usersAsync;
  const _UserList({required this.usersAsync});

  @override
  Widget build(BuildContext context) {
    return usersAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (users) {
        if (users.isEmpty) {
          return const Center(child: Text('No users yet'));
        }
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, i) {
            final user = users[i];
            return ListTile(
              leading: UserAvatar(
                name: user.displayName ?? user.username,
                avatarId: user.avatarId,
                avatarColor: user.avatarColor,
              ),
              title: Text(user.displayName ?? user.username),
              subtitle: Text('@${user.username}'),
              onTap: () => context.push('/user/${user.id}'),
            );
          },
        );
      },
    );
  }
}
