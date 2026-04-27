import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_team/features/workout/providers/custom_exercises_notifier.dart';
import 'package:gym_team/shared/models/exercise.dart';

const _muscleOptions = [
  'Arms', 'Back', 'Chest', 'Core', 'Full-Body',
  'Glutes', 'Legs', 'Olympic', 'Other', 'Shoulders',
];

const _equipmentOptions = [
  'Barbell', 'Bodyweight', 'Cable', 'Cardio',
  'Dumbbell', 'Kettlebell', 'Machine', 'Safety Bar', 'Smith Machine',
];

const _trackingOptions = [
  ('weight_reps', 'Weight & Reps'),
  ('reps_only',   'Reps Only'),
  ('weight_time', 'Weight & Time'),
  ('time',        'Time Only'),
  ('distance_time', 'Distance & Time'),
];

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
  bool _loading = false;

  String? _selectedMuscle;
  String? _selectedEquipment;
  String _selectedTracking = 'weight_reps';

  @override
  void initState() {
    super.initState();
    _selectedMuscle = _muscleOptions.contains(widget.initial?.muscleGroup)
        ? widget.initial!.muscleGroup
        : null;
    _selectedEquipment = _equipmentOptions.contains(widget.initial?.category)
        ? widget.initial!.category
        : null;
    _selectedTracking = widget.initial?.trackingType ?? 'weight_reps';
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      final notifier = ref.read(customExercisesNotifierProvider.notifier);
      if (widget.initial == null) {
        await notifier.create(
          name: _nameCtrl.text.trim(),
          category: _selectedEquipment!,
          muscleGroup: _selectedMuscle!,
          trackingType: _selectedTracking,
        );
      } else {
        await notifier.updateExercise(
          id: widget.initial!.id,
          name: _nameCtrl.text.trim(),
          category: _selectedEquipment!,
          muscleGroup: _selectedMuscle!,
          trackingType: _selectedTracking,
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
              widget.initial == null ? 'Create Custom Exercise' : 'Edit Exercise',
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
              initialValue: _selectedMuscle,
              decoration: const InputDecoration(labelText: 'Muscle group'),
              items: _muscleOptions
                  .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedMuscle = v),
              validator: (v) => v == null ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _selectedEquipment,
              decoration: const InputDecoration(labelText: 'Equipment'),
              items: _equipmentOptions
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedEquipment = v),
              validator: (v) => v == null ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _selectedTracking,
              decoration: const InputDecoration(labelText: 'Tracking type'),
              items: _trackingOptions
                  .map((t) => DropdownMenuItem(value: t.$1, child: Text(t.$2)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedTracking = v!),
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
