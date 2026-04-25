import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/plans/models/workout_plan.dart';

part 'plans_provider.g.dart';

@riverpod
Future<List<WorkoutPlan>> myPlans(MyPlansRef ref) async {
  final userId = supabase.auth.currentUser!.id;
  final data = await supabase
      .from('workout_plans')
      .select('*, plan_exercises(id, plan_id, exercise_id, position)')
      .eq('owner_id', userId)
      .order('title');
  return (data as List).map((e) => WorkoutPlan.fromJson(e)).toList();
}

@riverpod
Future<List<WorkoutPlan>> savedPlans(SavedPlansRef ref) async {
  final userId = supabase.auth.currentUser!.id;
  final data = await supabase
      .from('saved_plans')
      .select('workout_plans(*, plan_exercises(id, plan_id, exercise_id, position), profiles!owner_id(username, display_name, avatar_id, avatar_color))')
      .eq('user_id', userId);
  return (data as List)
      .map((row) =>
          WorkoutPlan.fromJson(row['workout_plans'] as Map<String, dynamic>))
      .toList();
}

@riverpod
Future<List<WorkoutPlan>> publicPlans(PublicPlansRef ref) async {
  final userId = supabase.auth.currentUser!.id;
  final data = await supabase
      .from('workout_plans')
      .select('*, plan_exercises(id, plan_id, exercise_id, position), profiles!owner_id(username, display_name, avatar_id, avatar_color)')
      .eq('is_public', true)
      .or('owner_id.neq.$userId,owner_id.is.null')
      .order('title');
  return (data as List).map((e) => WorkoutPlan.fromJson(e)).toList();
}

@riverpod
Future<WorkoutPlan> planDetail(PlanDetailRef ref, String planId) async {
  final data = await supabase
      .from('workout_plans')
      .select('*, profiles!owner_id(username, display_name, avatar_id, avatar_color), plan_exercises(*, exercises(*), plan_exercise_sets(*))')
      .eq('id', planId)
      .single();
  return WorkoutPlan.fromJson(data);
}

@riverpod
Future<bool> isPlanSaved(IsPlanSavedRef ref, String planId) async {
  final userId = supabase.auth.currentUser!.id;
  final data = await supabase
      .from('saved_plans')
      .select()
      .eq('user_id', userId)
      .eq('plan_id', planId)
      .maybeSingle();
  return data != null;
}
