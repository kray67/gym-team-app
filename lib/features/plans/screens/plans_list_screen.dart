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

  bool get _hasActiveFilters =>
      _sessionsPerWeek != null ||
      _difficulty != null ||
      _equipment != null ||
      _favoritesOnly ||
      _gymTeamOnly ||
      _myPlansOnly;

  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Padding(
          padding: EdgeInsets.fromLTRB(
              16, 16, 16, MediaQuery.of(ctx).viewInsets.bottom + 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text('Filters',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _sessionsPerWeek = null;
                        _difficulty = null;
                        _equipment = null;
                        _favoritesOnly = false;
                        _gymTeamOnly = false;
                        _myPlansOnly = false;
                      });
                      setSheetState(() {});
                    },
                    child: const Text('Clear all'),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Sessions / week
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Sessions / week',
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(),
                ),
                child: DropdownButton<int>(
                  value: _sessionsPerWeek,
                  hint: const Text('Any'),
                  isExpanded: true,
                  isDense: true,
                  underline: const SizedBox(),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('Any')),
                    for (var i = 1; i <= 7; i++)
                      DropdownMenuItem(value: i, child: Text('$i / week')),
                  ],
                  onChanged: (v) {
                    setState(() => _sessionsPerWeek = v);
                    setSheetState(() {});
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Difficulty
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Difficulty',
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(),
                ),
                child: DropdownButton<String>(
                  value: _difficulty,
                  hint: const Text('Any'),
                  isExpanded: true,
                  isDense: true,
                  underline: const SizedBox(),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('Any')),
                    ..._difficultyLabels.entries.map((e) =>
                        DropdownMenuItem(value: e.key, child: Text(e.value))),
                  ],
                  onChanged: (v) {
                    setState(() => _difficulty = v);
                    setSheetState(() {});
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Equipment
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Equipment',
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(),
                ),
                child: DropdownButton<String>(
                  value: _equipment,
                  hint: const Text('Any'),
                  isExpanded: true,
                  isDense: true,
                  underline: const SizedBox(),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('Any')),
                    ..._equipmentLabels.entries.map((e) =>
                        DropdownMenuItem(value: e.key, child: Text(e.value))),
                  ],
                  onChanged: (v) {
                    setState(() => _equipment = v);
                    setSheetState(() {});
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Filter chips
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: [
                  FilterChip(
                    label: const Text('Favorites'),
                    selected: _favoritesOnly,
                    visualDensity: VisualDensity.compact,
                    onSelected: (v) {
                      _setFavoritesOnly(v);
                      setSheetState(() {});
                    },
                  ),
                  FilterChip(
                    label: const Text('GymTeam App'),
                    selected: _gymTeamOnly,
                    visualDensity: VisualDensity.compact,
                    onSelected: (v) {
                      _setGymTeamOnly(v);
                      setSheetState(() {});
                    },
                  ),
                  FilterChip(
                    label: const Text('My Plans'),
                    selected: _myPlansOnly,
                    visualDensity: VisualDensity.compact,
                    onSelected: (v) {
                      _setMyPlansOnly(v);
                      setSheetState(() {});
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allAsync = ref.watch(allPlansProvider);
    final favoriteIdsAsync = ref.watch(userFavoritePlanIdsProvider);
    final gymTeamIdAsync = ref.watch(gymTeamUserIdProvider);
    final currentUserId = supabase.auth.currentUser!.id;

    return Scaffold(
      appBar: AppBar(title: const Text('Plans')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref.read(planEditorNotifierProvider.notifier).startNew();
          context.push('/plans/new');
        },
        icon: const Icon(Icons.add),
        label: const Text('New Plan'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search plans…',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                              },
                            )
                          : null,
                    ),
                    onChanged: (v) => setState(() => _searchQuery = v),
                  ),
                ),
                const SizedBox(width: 8),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.tune),
                      tooltip: 'Filters',
                      style: IconButton.styleFrom(
                        side: BorderSide(
                          color: _hasActiveFilters
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white24,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () => _openFilterSheet(context),
                    ),
                    if (_hasActiveFilters)
                      Positioned(
                        right: 4,
                        top: 4,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
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
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 88),
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

  String _planInfo() {
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
    return parts.join(' · ');
  }

  String _ownerLine() {
    final owner = plan.owner;
    if (owner?.isOfficial == true) return 'GymTeam App';
    if (_isOwner) return 'You · ${plan.isPublic ? 'Public' : 'Private'}';
    if (owner != null) return owner.displayName ?? owner.username;
    return '';
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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_planInfo().isNotEmpty)
              Text(_planInfo(),
                  style: const TextStyle(color: Colors.white54, fontSize: 13)),
            if (_ownerLine().isNotEmpty)
              Text(_ownerLine(),
                  style: const TextStyle(color: Colors.white38, fontSize: 12)),
          ],
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
            // Owner actions — same 40×40 footprint as chevron SizedBox
            if (_isOwner)
              PopupMenuButton<String>(
                padding: EdgeInsets.zero,
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
              const SizedBox(
                width: 40,
                height: 40,
                child: Icon(Icons.chevron_right),
              ),
          ],
        ),
        onTap: () => context.push('/plans/${plan.id}'),
      ),
    );
  }
}
