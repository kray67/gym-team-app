import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/plans/models/workout_plan.dart';
import 'package:gym_team/features/plans/providers/plan_active_notifier.dart';
import 'package:gym_team/features/plans/providers/plan_editor_provider.dart';
import 'package:gym_team/features/plans/providers/plans_provider.dart';

class PlansListScreen extends ConsumerStatefulWidget {
  const PlansListScreen({super.key});

  @override
  ConsumerState<PlansListScreen> createState() => _PlansListScreenState();
}

class _PlansListScreenState extends ConsumerState<PlansListScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    // Tabs: Discover (0), Saved (1), My Plans (2)
    _tabs = TabController(length: 3, vsync: this);
    _tabs.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plans'),
        bottom: TabBar(
          controller: _tabs,
          tabs: const [
            Tab(text: 'Discover'),
            Tab(text: 'Saved'),
            Tab(text: 'My Plans'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          _DiscoverTab(),
          _SavedTab(),
          _MyPlansTab(),
        ],
      ),
      floatingActionButton: _tabs.index == 2
          ? FloatingActionButton.extended(
              onPressed: () {
                ref.read(planEditorNotifierProvider.notifier).startNew();
                context.push('/plans/new');
              },
              icon: const Icon(Icons.add),
              label: const Text('New Plan'),
            )
          : null,
    );
  }
}

// ── Discover tab ─────────────────────────────────────────────────────────────

class _DiscoverTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(publicPlansProvider);
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (plans) => plans.isEmpty
          ? Center(
              child: Text('There are no plans created by other users yet.',
                  style:
                      TextStyle(color: Colors.white.withValues(alpha: 0.4))),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: plans.length,
              itemBuilder: (context, i) =>
                  _PlanCard(plan: plans[i], mode: _CardMode.discover),
            ),
    );
  }
}

// ── Saved tab ─────────────────────────────────────────────────────────────────

class _SavedTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(savedPlansProvider);
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (plans) => plans.isEmpty
          ? Center(
              child: Text('No saved plans yet.',
                  style:
                      TextStyle(color: Colors.white.withValues(alpha: 0.4))),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: plans.length,
              itemBuilder: (context, i) =>
                  _PlanCard(plan: plans[i], mode: _CardMode.saved),
            ),
    );
  }
}

// ── My Plans tab ──────────────────────────────────────────────────────────────

class _MyPlansTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(myPlansProvider);
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (plans) => plans.isEmpty
          ? Center(
              child: Text('You haven\'t created any plans yet.',
                  style:
                      TextStyle(color: Colors.white.withValues(alpha: 0.4))),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: plans.length,
              itemBuilder: (context, i) =>
                  _PlanCard(plan: plans[i], mode: _CardMode.owned),
            ),
    );
  }
}

// ── Plan card (shared, mode-aware) ────────────────────────────────────────────

enum _CardMode { discover, saved, owned }

class _PlanCard extends ConsumerWidget {
  final WorkoutPlan plan;
  final _CardMode mode;

  const _PlanCard({required this.plan, required this.mode});

  Future<void> _deletePlan(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete plan?'),
        content: Text(
            '"${plan.title}" will be permanently deleted.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style:
                TextButton.styleFrom(foregroundColor: Colors.red.shade400),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    await supabase.from('workout_plans').delete().eq('id', plan.id);
    ref.invalidate(myPlansProvider);
  }

  Future<void> _unsavePlan(BuildContext context, WidgetRef ref) async {
    final userId = supabase.auth.currentUser!.id;
    await supabase
        .from('saved_plans')
        .delete()
        .eq('user_id', userId)
        .eq('plan_id', plan.id);
    ref.invalidate(savedPlansProvider);
    ref.invalidate(isPlanSavedProvider(plan.id));
  }

  String _buildSubtitle(String currentUserId) {
    final parts = <String>[];
    if (plan.weeks != null) parts.add('${plan.weeks} ${plan.weeks == 1 ? 'week' : 'weeks'}');
    if (plan.sessionsPerWeek != null) parts.add('${plan.sessionsPerWeek}x week');

    final isAppOwned = plan.ownerId == null;
    final isOwner = !isAppOwned && plan.ownerId == currentUserId;
    final ownerName = plan.owner?.displayName ?? plan.owner?.username;

    switch (mode) {
      case _CardMode.discover:
        parts.add(isAppOwned ? 'by GymTeam App' : (ownerName != null ? 'by $ownerName' : ''));
      case _CardMode.saved:
        if (isAppOwned) {
          parts.add('by GymTeam App');
        } else if (isOwner) {
          parts.add('by You');
          parts.add(plan.isPublic ? 'Public' : 'Private');
        } else if (ownerName != null) {
          parts.add('by $ownerName');
        }
      case _CardMode.owned:
        parts.add('by You');
        parts.add(plan.isPublic ? 'Public' : 'Private');
    }

    return parts.where((p) => p.isNotEmpty).join(' · ');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = supabase.auth.currentUser!.id;
    final activePlanId = ref.watch(activePlanProvider).valueOrNull?.id;
    final isActive = activePlanId == plan.id;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        title: Row(
          children: [
            Flexible(
              child: Text(plan.title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            if (isActive) ...[
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.shade900,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade600),
                ),
                child: const Text(
                  'Active',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: Text(
          _buildSubtitle(currentUserId),
          style: const TextStyle(color: Colors.white54, fontSize: 13),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (mode == _CardMode.owned)
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.white54),
                onSelected: (v) {
                  if (v == 'delete') _deletePlan(context, ref);
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete plan',
                        style: TextStyle(color: Colors.redAccent)),
                  ),
                ],
              )
            else if (mode == _CardMode.saved)
              IconButton(
                icon: const Icon(Icons.bookmark_remove_outlined,
                    color: Colors.white54),
                tooltip: 'Remove from saved',
                onPressed: () => _unsavePlan(context, ref),
              )
            else
              const Icon(Icons.chevron_right),
          ],
        ),
        onTap: () => context.push('/plans/${plan.id}'),
      ),
    );
  }
}
