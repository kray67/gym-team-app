import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/workout/providers/exercises_provider.dart';

part 'custom_exercises_notifier.g.dart';

@riverpod
class CustomExercisesNotifier extends _$CustomExercisesNotifier {
  @override
  FutureOr<void> build() {}

  Future<void> create({
    required String name,
    required String category,
    required String muscleGroup,
    String trackingType = 'weight_reps',
  }) async {
    final userId = supabase.auth.currentUser!.id;
    await supabase.from('exercises').insert({
      'name': name,
      'category': category,
      'muscle_group': muscleGroup,
      'is_custom': true,
      'created_by': userId,
      'tracking_type': trackingType,
    });
    ref.invalidate(exercisesProvider);
  }

  Future<void> updateExercise({
    required String id,
    required String name,
    required String category,
    required String muscleGroup,
    String trackingType = 'weight_reps',
  }) async {
    await supabase.from('exercises').update({
      'name': name,
      'category': category,
      'muscle_group': muscleGroup,
      'tracking_type': trackingType,
    }).eq('id', id).eq('created_by', supabase.auth.currentUser!.id);
    ref.invalidate(exercisesProvider);
  }

  Future<void> delete(String id) async {
    await supabase
        .from('exercises')
        .delete()
        .eq('id', id)
        .eq('created_by', supabase.auth.currentUser!.id);
    ref.invalidate(exercisesProvider);
  }
}
