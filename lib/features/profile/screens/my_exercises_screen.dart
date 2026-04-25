import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/workout/providers/custom_exercises_notifier.dart';
import 'package:gym_team/features/workout/providers/exercises_provider.dart';
import 'package:gym_team/features/workout/widgets/exercise_form_sheet.dart';
import 'package:gym_team/shared/models/exercise.dart';

class MyExercisesScreen extends ConsumerWidget {
  const MyExercisesScreen({super.key});

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Exercise ex,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete exercise'),
        content: Text('Delete "${ex.name}"? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      try {
        await ref
            .read(customExercisesNotifierProvider.notifier)
            .delete(ex.id);
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting exercise: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = supabase.auth.currentUser?.id;
    final asyncExercises = ref.watch(exercisesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Exercises')),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('New Exercise'),
        onPressed: () => showExerciseFormSheet(context),
      ),
      body: asyncExercises.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (all) {
          final mine = all
              .where((e) => e.isCustom && e.createdBy == userId)
              .toList();

          if (mine.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.fitness_center,
                    size: 48,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No custom exercises yet',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create one from the exercise picker',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: mine.length,
            itemBuilder: (context, i) {
              final ex = mine[i];
              return ListTile(
                title: Text(ex.name),
                subtitle: Text(
                  '${ex.category} · ${ex.muscleGroup}',
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 20),
                      tooltip: 'Edit',
                      onPressed: () =>
                          showExerciseFormSheet(context, initial: ex),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        size: 20,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      tooltip: 'Delete',
                      onPressed: () => _confirmDelete(context, ref, ex),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
