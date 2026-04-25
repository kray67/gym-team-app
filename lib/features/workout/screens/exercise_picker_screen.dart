import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_team/features/workout/providers/exercises_provider.dart';
import 'package:gym_team/features/workout/widgets/exercise_form_sheet.dart';
import 'package:gym_team/shared/models/exercise.dart';

const _all = 'All';

const _muscleOptions = [
  'Arms', 'Back', 'Chest', 'Core', 'Full-Body',
  'Glutes', 'Legs', 'Olympic', 'Other', 'Shoulders',
];

const _equipmentOptions = [
  'Barbell', 'Bodyweight', 'Cable', 'Cardio',
  'Dumbbell', 'Kettlebell', 'Machine', 'Safety Bar', 'Smith Machine',
];

class ExercisePickerResult {
  final List<Exercise> exercises;
  final bool asSuperset;
  const ExercisePickerResult({required this.exercises, required this.asSuperset});
}

class ExercisePickerScreen extends ConsumerStatefulWidget {
  final bool singleSelect;
  const ExercisePickerScreen({super.key, this.singleSelect = false});

  @override
  ConsumerState<ExercisePickerScreen> createState() =>
      _ExercisePickerScreenState();
}

class _ExercisePickerScreenState extends ConsumerState<ExercisePickerScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';
  String _selectedMuscle = _all;
  String _selectedEquipment = _all;
  final _selected = <Exercise>[];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Exercise> _filtered(List<Exercise> all) {
    return all.where((e) {
      final matchesMuscle = _selectedMuscle == _all ||
          e.muscles.contains(_selectedMuscle) ||
          e.muscleGroup == _selectedMuscle;
      final matchesEquipment =
          _selectedEquipment == _all || e.category == _selectedEquipment;
      final matchesQuery = _query.isEmpty ||
          e.name.toLowerCase().contains(_query.toLowerCase()) ||
          e.muscleGroup.toLowerCase().contains(_query.toLowerCase());
      return matchesMuscle && matchesEquipment && matchesQuery;
    }).toList();
  }

  void _toggle(Exercise ex) {
    setState(() {
      final idx = _selected.indexOf(ex);
      if (idx == -1) {
        _selected.add(ex);
      } else {
        _selected.removeAt(idx);
      }
    });
  }

  Widget _filterRow({
    required String label,
    required String selected,
    required List<String> options,
    required void Function(String) onSelect,
  }) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 6, top: 6, bottom: 6),
            child: Text(
              '$label:',
              style: const TextStyle(fontSize: 12, color: Colors.white38),
            ),
          ),
          ...[_all, ...options].map((opt) {
            final isSelected = opt == selected;
            return Padding(
              padding: const EdgeInsets.only(right: 6),
              child: FilterChip(
                label: Text(opt, style: const TextStyle(fontSize: 12)),
                selected: isSelected,
                onSelected: (_) => setState(() => onSelect(opt)),
                showCheckmark: false,
                visualDensity: VisualDensity.compact,
              ),
            );
          }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncExercises = ref.watch(exercisesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Exercise'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Create custom exercise',
            onPressed: () => showExerciseFormSheet(context),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: TextField(
              controller: _searchCtrl,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Search exercises…',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchCtrl.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
                isDense: true,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
        ),
      ),
      bottomNavigationBar: widget.singleSelect
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _selected.length >= 2
                            ? () => context.pop(ExercisePickerResult(
                                  exercises: List.of(_selected),
                                  asSuperset: true,
                                ))
                            : null,
                        child: const Text('Add as Superset'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: _selected.isNotEmpty
                            ? () => context.pop(ExercisePickerResult(
                                  exercises: List.of(_selected),
                                  asSuperset: false,
                                ))
                            : null,
                        child: const Text('Add Exercises'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      body: asyncExercises.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (all) {
          final filtered = _filtered(all);

          return Column(
            children: [
              // Muscle group filter
              _filterRow(
                label: 'Muscle',
                selected: _selectedMuscle,
                options: _muscleOptions,
                onSelect: (v) => _selectedMuscle = v,
              ),
              // Equipment filter
              _filterRow(
                label: 'Equipment',
                selected: _selectedEquipment,
                options: _equipmentOptions,
                onSelect: (v) => _selectedEquipment = v,
              ),
              const Divider(height: 1),
              // Create custom exercise banner
              InkWell(
                onTap: () => showExerciseFormSheet(context),
                child: Container(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withValues(alpha: 0.15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Icon(Icons.add_circle,
                          color: Theme.of(context).colorScheme.primary,
                          size: 22),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create custom exercise',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const Text(
                            'Add an exercise not in the catalog',
                            style:
                                TextStyle(fontSize: 12, color: Colors.white54),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.chevron_right,
                          color: Colors.white38, size: 18),
                    ],
                  ),
                ),
              ),
              const Divider(height: 1),
              // Exercise list
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Text(
                          'No exercises found',
                          style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.4)),
                        ),
                      )
                    : ListView.builder(
                        padding: widget.singleSelect
                            ? EdgeInsets.zero
                            : const EdgeInsets.only(bottom: 16),
                        itemCount: filtered.length,
                        itemBuilder: (context, i) {
                          final ex = filtered[i];
                          final selIdx = _selected.indexOf(ex);
                          final isSelected = selIdx != -1;

                          final showHeader = _selectedMuscle == _all &&
                              _selectedEquipment == _all &&
                              _query.isEmpty &&
                              (i == 0 ||
                                  filtered[i - 1].muscleGroup !=
                                      ex.muscleGroup);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (showHeader)
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 12, 16, 4),
                                  child: Text(
                                    ex.muscleGroup.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          letterSpacing: 1.2,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ListTile(
                                dense: true,
                                title: Text(ex.name),
                                subtitle: Text(
                                  ex.isCustom
                                      ? 'Custom · ${ex.muscleGroup} · ${ex.category}'
                                      : '${ex.muscleGroup} · ${ex.category}',
                                  style: TextStyle(
                                    color: ex.isCustom
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.white54,
                                    fontSize: 12,
                                  ),
                                ),
                                trailing: widget.singleSelect
                                    ? const Icon(Icons.add_circle_outline,
                                        size: 20)
                                    : isSelected
                                        ? CircleAvatar(
                                            radius: 12,
                                            backgroundColor: Colors.green,
                                            child: Text(
                                              '${selIdx + 1}',
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        : const Icon(Icons.add_circle_outline,
                                            size: 20),
                                onTap: () {
                                  if (widget.singleSelect) {
                                    context.pop(ExercisePickerResult(
                                      exercises: [ex],
                                      asSuperset: false,
                                    ));
                                  } else {
                                    _toggle(ex);
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
