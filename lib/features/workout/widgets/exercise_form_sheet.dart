import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_team/features/workout/providers/custom_exercises_notifier.dart';
import 'package:gym_team/features/workout/providers/exercises_provider.dart';
import 'package:gym_team/shared/models/exercise.dart';

const _customCategoryOption = '__custom__';

/// Shows a bottom sheet to create or edit a custom exercise.
/// Returns true if the exercise was saved, false/null if cancelled.
Future<bool> showExerciseFormSheet(
  BuildContext context, {
  Exercise? initial,
}) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    builder: (_) => UncontrolledProviderScope(
      container: ProviderScope.containerOf(context),
      child: _ExerciseFormSheet(initial: initial),
    ),
  );
  return result == true;
}

class _ExerciseFormSheet extends ConsumerStatefulWidget {
  final Exercise? initial;
  const _ExerciseFormSheet({this.initial});

  @override
  ConsumerState<_ExerciseFormSheet> createState() => _ExerciseFormSheetState();
}

class _ExerciseFormSheetState extends ConsumerState<_ExerciseFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _nameCtrl = TextEditingController(text: widget.initial?.name);
  late final _muscleCtrl =
      TextEditingController(text: widget.initial?.muscleGroup);
  final _customCategoryCtrl = TextEditingController();

  // The dropdown value — either a catalog category name or _customCategoryOption
  String? _dropdownValue;
  bool _isCustomCategory = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial?.category;
    if (initial != null) {
      _dropdownValue = initial; // may be overridden below if not in catalog
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _muscleCtrl.dispose();
    _customCategoryCtrl.dispose();
    super.dispose();
  }

  List<String> _catalogCategories(List<Exercise> all) {
    return all
        .where((e) => !e.isCustom)
        .map((e) => e.category)
        .toSet()
        .toList()
      ..sort();
  }

  /// Resolves the final category string to save.
  String? get _resolvedCategory {
    if (_isCustomCategory) {
      final v = _customCategoryCtrl.text.trim();
      return v.isEmpty ? null : v;
    }
    return _dropdownValue == _customCategoryOption ? null : _dropdownValue;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      final notifier = ref.read(customExercisesNotifierProvider.notifier);
      final category = _resolvedCategory!;
      if (widget.initial == null) {
        await notifier.create(
          name: _nameCtrl.text.trim(),
          category: category,
          muscleGroup: _muscleCtrl.text.trim(),
        );
      } else {
        await notifier.updateExercise(
          id: widget.initial!.id,
          name: _nameCtrl.text.trim(),
          category: category,
          muscleGroup: _muscleCtrl.text.trim(),
        );
      }
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final allExercises = ref.watch(exercisesProvider).valueOrNull ?? [];
    final catalogCategories = _catalogCategories(allExercises);

    // If editing and the initial category is not in the catalog, pre-select custom
    if (widget.initial != null &&
        !_isCustomCategory &&
        _dropdownValue != null &&
        !catalogCategories.contains(_dropdownValue) &&
        _dropdownValue != _customCategoryOption) {
      _isCustomCategory = true;
      _customCategoryCtrl.text = _dropdownValue!;
      _dropdownValue = _customCategoryOption;
    }

    final dropdownItems = [
      ...catalogCategories
          .map((c) => DropdownMenuItem(value: c, child: Text(c))),
      const DropdownMenuItem(
        value: _customCategoryOption,
        child: Text(
          'Other (custom)…',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
    ];

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.initial == null
                  ? 'Create Custom Exercise'
                  : 'Edit Exercise',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Name'),
              textCapitalization: TextCapitalization.words,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _isCustomCategory ? _customCategoryOption : _dropdownValue,
              decoration: const InputDecoration(labelText: 'Category'),
              items: dropdownItems,
              onChanged: (v) {
                setState(() {
                  if (v == _customCategoryOption) {
                    _isCustomCategory = true;
                    _dropdownValue = _customCategoryOption;
                  } else {
                    _isCustomCategory = false;
                    _dropdownValue = v;
                    _customCategoryCtrl.clear();
                  }
                });
              },
              validator: (_) =>
                  _resolvedCategory == null ? 'Required' : null,
            ),
            if (_isCustomCategory) ...[
              const SizedBox(height: 8),
              TextFormField(
                controller: _customCategoryCtrl,
                decoration:
                    const InputDecoration(labelText: 'Custom category name'),
                textCapitalization: TextCapitalization.words,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
            ],
            const SizedBox(height: 12),
            TextFormField(
              controller: _muscleCtrl,
              decoration: const InputDecoration(labelText: 'Muscle group'),
              textCapitalization: TextCapitalization.words,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _loading ? null : _submit,
              child: _loading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(widget.initial == null ? 'Create' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }
}
