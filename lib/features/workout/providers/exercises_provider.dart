import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/shared/models/exercise.dart';

part 'exercises_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<Exercise>> exercises(ExercisesRef ref) async {
  final data = await supabase
      .from('exercises')
      .select()
      .order('category')
      .order('name');
  return (data as List).map((e) => Exercise.fromJson(e)).toList();
}
