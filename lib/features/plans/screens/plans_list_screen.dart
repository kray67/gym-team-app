import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/plans/models/workout_plan.dart';
import 'package:gym_team/features/plans/providers/plan_active_notifier.dart';
import 'package:gym_team/features/plans/providers/plan_editor_provider.dart';
import 'package:gym_team/features/plans/providers/plans_provider.dart';

const _difficultyLabels = {
  'novice': 'Novice',
  'intermediate': 'Intermediate',
  'advanced': 'Advanced',
};

const _equipmentLabels = {
  'bodyweight': 'Bodyweight',
  'dumbbells': 'Dumbbells',
  'garage_gym': 'Garage Gym',
  'commercial_gym': 'Commercial Gym',
};

class PlansListScreen extends ConsumerStatefulWidget {
  const PlansListScreen({super.key});

  @override
  ConsumerState<PlansListScreen> createState() => _PlansListScreenState();
}

class _PlansListScreenState extends ConsumerState<PlansListScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  int? _sessionsPerWeek;
  String? _difficulty;
  String? _equipment;
  bool _favoritesOnly = false;
  bool _gymTeamOnly = false;
  bool _myPlansOnly = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _setFavoritesOnly(bool v) => setState(() {
        _favoritesOnly = v;
        if (v) _myPlansOnly = false;
      });

  void _setGymTeamOnly(bool v) => setState(() {
        _gymTeamOnly = v;
        if (v) _myPlansOnly = false;
      });

  void _setMyPlansOnly(bool v) => setState(() {
        _myPlansOnly = v;
        if (v) {
          _favoritesOnly = false;
          _gymTeamOnly = false;
        }
      });

  List<WorkoutPlan> _applyFilters(
    List<WorkoutPlan> all,
    Set<String> favoriteIds,
    String currentUserId,
    String? gymTeamUserId,
  ) {
    return all.where((p) {
      if (_searchQuery.isNotEmpty &&
          !p.title.toLowerCase().contains(_searchQuery.toLowerCase())) {
        return false;
      }
      if (_sessionsPerWeek != null && p.sessionsPerWeek != _sessionsPerWeek) {
        return false;
      }
      if (_difficulty != null && p.difficulty != _difficulty) return false;
      if (_equipment != null && p.equipment != _equipment) return false;

      if (_myPlansOnly) {
        return p.ownerId == currentUserId;
      }

      if (_favoritesOnly && !favoriteIds.contains(p.id)) return false;
      if (_gymTeamOnly && p.owner?.isOfficial != true) return false;

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final allAsync = ref.watch(allPlansProvider);
    final favoriteIdsAsync = ref.watch(userFavoritePlanIdsProvider);
    final gymTeamIdAsync = ref.watch(gymTeamUserIdProvider);
    final currentUserId = supabase.auth.currentUser!.id;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plans'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'New Plan',
            onPressed: () {
              ref.read(planEditorNotifierProvider.notifier).startNew();
              context.push('/plans/new');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _FilterPanel(
            searchController: _searchController,
            sessionsPerWeek: _sessionsPerWeek,
            difficulty: _difficulty,
            equipment: _equipment,
            favoritesOnly: _favoritesOnly,
            gymTeamOnly: _gymTeamOnly,
            myPlansOnly: _myPlansOnly,
            onSearchChanged: (v) => setState(() => _searchQuery = v),
            onSessionsPerWeekChanged: (v) =>
                setState(() => _sessionsPerWeek = v),
            onDifficultyChanged: (v) => setState(() => _difficulty = v),
            onEquipmentChanged: (v) => setState(() => _equipment = v),
            onFavoritesOnlyChanged: _setFavoritesOnly,
            onGymTeamOnlyChanged: _setGymTeamOnly,
            onMyPlansOnlyChanged: _setMyPlansOnly,
          ),
          const Divider(height: 1),
          Expanded(
            child: allAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (all) {
                final favoriteIds =
                    favoriteIdsAsync.valueOrNull ?? const <String>{};
                final gymTeamUserId = gymTeamIdAsync.valueOrNull;
                final plans = _applyFilters(
                    all, favoriteIds, currentUserId, gymTeamUserId);

                if (plans.isEmpty) {
                  return Center(
                    child: Text(
                      'No plans found.',
                      style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4)),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: plans.length,
                  itemBuilder: (context, i) => _PlanCard(
                    plan: plans[i],
                    currentUserId: currentUserId,
                    favoriteIds: favoriteIds,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Filter panel ──────────────────────────────────────────────────────────────

class _FilterPanel extends StatelessWidget {
  final TextEditingController searchController;
  final int? sessionsPerWeek;
  final String? difficulty;
  final String? equipment;
  final bool favoritesOnly;
  final bool gymTeamOnly;
  final bool myPlansOnly;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<int?> onSessionsPerWeekChanged;
  final ValueChanged<String?> onDifficultyChanged;
  final ValueChanged<String?> onEquipmentChanged;
  final ValueChanged<bool> onFavoritesOnlyChanged;
  final ValueChanged<bool> onGymTeamOnlyChanged;
  final ValueChanged<bool> onMyPlansOnlyChanged;

  const _FilterPanel({
    required this.searchController,
    required this.sessionsPerWeek,
    required this.difficulty,
    required this.equipment,
    required this.favoritesOnly,
    required this.gymTeamOnly,
    required this.myPlansOnly,
    required this.onSearchChanged,
    required this.onSessionsPerWeekChanged,
    required this.onDifficultyChanged,
    required this.onEquipmentChanged,
    required this.onFavoritesOnlyChanged,
    required this.onGymTeamOnlyChanged,
    required this.onMyPlansOnlyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search plans…',
              prefixIcon: const Icon(Icons.search, size: 20),
              isDense: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: () {
                        searchController.clear();
                        onSearchChanged('');
                      },
                    )
                  : null,
            ),
            onChanged: onSearchChanged,
          ),
          const SizedBox(height: 8),

          // Dropdowns row
          Row(
            children: [
              Expanded(
                child: _CompactDropdown<int>(
                  hint: 'Sessions/wk',
                  value: sessionsPerWeek,
                  items: [
                    for (var i = 1; i <= 7; i++)
                      DropdownMenuItem(value: i, child: Text('$i/wk')),
                  ],
                  onChanged: onSessionsPerWeekChanged,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _CompactDropdown<String>(
                  hint: 'Difficulty',
                  value: difficulty,
                  items: _difficultyLabels.entries
                      .map((e) => DropdownMenuItem(
                          value: e.key, child: Text(e.value)))
                      .toList(),
                  onChanged: onDifficultyChanged,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _CompactDropdown<String>(
                  hint: 'Equipment',
                  value: equipment,
                  items: _equipmentLabels.entries
                      .map((e) => DropdownMenuItem(
                          value: e.key, child: Text(e.value)))
                      .toList(),
                  onChanged: onEquipmentChanged,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Chip row: Favorites + GymTeam (independent) | My Plans (exclusive)
          Wrap(
            spacing: 6,
            children: [
              FilterChip(
                label: const Text('Favorites'),
                selected: favoritesOnly,
                onSelected: onFavoritesOnlyChanged,
              ),
              FilterChip(
                label: const Text('GymTeam App'),
                selected: gymTeamOnly,
                onSelected: onGymTeamOnlyChanged,
              ),
              FilterChip(
                label: const Text('My Plans'),
                selected: myPlansOnly,
                onSelected: onMyPlansOnlyChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CompactDropdown<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  const _CompactDropdown({
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: DropdownButton<T>(
        value: value,
        hint: Text(hint,
            style: const TextStyle(fontSize: 12, color: Colors.white54)),
        isDense: true,
        isExpanded: true,
        underline: const SizedBox(),
        items: [
          DropdownMenuItem<T>(
            value: null,
            child: Text('Any',
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary)),
          ),
          ...items,
        ],
        onChanged: onChanged,
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
  }
}

// ── Plan card ─────────────────────────────────────────────────────────────────

class _PlanCard extends ConsumerWidget {
  final WorkoutPlan plan;
  final String currentUserId;
  final Set<String> favoriteIds;

  const _PlanCard({
    required this.plan,
    required this.currentUserId,
    required this.favoriteIds,
  });

  bool get _isOwner => plan.ownerId == currentUserId;
  bool get _isFavorited => favoriteIds.contains(plan.id);

  Future<void> _toggleFavorite(WidgetRef ref) async {
    if (_isFavorited) {
      await supabase
          .from('plan_favorites')
          .delete()
          .eq('user_id', currentUserId)
          .eq('plan_id', plan.id);
    } else {
      await supabase.from('plan_favorites').insert({
        'user_id': currentUserId,
        'plan_id': plan.id,
      });
    }
    ref.invalidate(userFavoritePlanIdsProvider);
    ref.invalidate(isPlanFavoritedProvider(plan.id));
  }

  Future<void> _deletePlan(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete plan?'),
        content: Text('"${plan.title}" will be permanently deleted.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red.shade400),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    await supabase.from('workout_plans').delete().eq('id', plan.id);
    ref.invalidate(allPlansProvider);
  }

  String _subtitle() {
    final parts = <String>[];
    if (plan.weeks != null) {
      parts.add('${plan.weeks} ${plan.weeks == 1 ? 'week' : 'weeks'}');
    }
    if (plan.sessionsPerWeek != null) {
      parts.add('${plan.sessionsPerWeek}×/wk');
    }
    if (plan.difficulty != null) {
      parts.add(_difficultyLabels[plan.difficulty] ?? plan.difficulty!);
    }

    final owner = plan.owner;
    if (owner?.isOfficial == true) {
      parts.add('by GymTeam App');
    } else if (_isOwner) {
      parts.add('by You · ${plan.isPublic ? 'Public' : 'Private'}');
    } else if (owner != null) {
      final name = owner.displayName ?? owner.username;
      parts.add('by $name');
    }

    return parts.where((p) => p.isNotEmpty).join(' · ');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Active: the active plan is the copy; source plan's id will be copy's sourcePlanId
    final activePlan = ref.watch(activePlanProvider).valueOrNull;
    final isActive = activePlan?.sourcePlanId == plan.id;

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
          _subtitle(),
          style: const TextStyle(color: Colors.white54, fontSize: 13),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Favorite toggle — only on source plans, not copies
            if (plan.sourcePlanId == null)
              IconButton(
                icon: Icon(
                  _isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorited ? Colors.red.shade300 : Colors.white38,
                  size: 20,
                ),
                tooltip:
                    _isFavorited ? 'Remove from favorites' : 'Add to favorites',
                onPressed: () => _toggleFavorite(ref),
              ),
            // Owner actions
            if (_isOwner)
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.white54),
                onSelected: (v) {
                  if (v == 'delete') _deletePlan(context, ref);
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete plan',
                        style: TextStyle(color: Colors.red.shade400)),
                  ),
                ],
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
