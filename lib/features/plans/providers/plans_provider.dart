import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/plans/models/workout_plan.dart';

part 'plans_provider.g.dart';

/// All plans visible to the current user: public source plans + user's own
/// non-copy private plans. Copies (source_plan_id IS NOT NULL) and
/// soft-deleted plans are excluded.
@riverpod
Future<List<WorkoutPlan>> allPlans(AllPlansRef ref) async {
  final userId = supabase.auth.currentUser!.id;
  final data = await supabase
      .from('workout_plans')
      .select(
          '*, plan_exercises(id, plan_id, exercise_id, position), profiles!owner_id(username, display_name, avatar_id, avatar_color, is_official)')
      .or('is_public.eq.true,owner_id.eq.$userId')
      .filter('source_plan_id', 'is', null)
      .eq('is_deleted', false)
      .order('created_at', ascending: false);
  return (data as List).map((e) => WorkoutPlan.fromJson(e)).toList();
}

/// Full plan detail including exercises + sets. Works for both source plans
/// and personal copies.
@riverpod
Future<WorkoutPlan> planDetail(PlanDetailRef ref, String planId) async {
  final data = await supabase
      .from('workout_plans')
      .select(
          '*, profiles!owner_id(username, display_name, avatar_id, avatar_color, is_official), plan_exercises(*, exercises(*), plan_exercise_sets(*))')
      .eq('id', planId)
      .single();
  return WorkoutPlan.fromJson(data);
}

/// Set of plan IDs the current user has favorited (references source plans only).
@riverpod
Future<Set<String>> userFavoritePlanIds(UserFavoritePlanIdsRef ref) async {
  final userId = supabase.auth.currentUser!.id;
  final data = await supabase
      .from('plan_favorites')
      .select('plan_id')
      .eq('user_id', userId);
  return {for (final row in (data as List)) row['plan_id'] as String};
}

/// Whether the current user has favorited a specific source plan.
@riverpod
Future<bool> isPlanFavorited(IsPlanFavoritedRef ref, String planId) async {
  final ids = await ref.watch(userFavoritePlanIdsProvider.future);
  return ids.contains(planId);
}

/// UUID of the GymTeam App official account (is_official = true on profiles).
/// Returns null if the account has not been created yet.
@riverpod
Future<String?> gymTeamUserId(GymTeamUserIdRef ref) async {
  final data = await supabase
      .from('profiles')
      .select('id')
      .eq('is_official', true)
      .maybeSingle();
  return data?['id'] as String?;
}
