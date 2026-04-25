import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/profile/models/user_profile.dart';

part 'profile_provider.g.dart';

// ── Read providers ────────────────────────────────────────────────────────────

@riverpod
Future<UserProfile> myProfile(MyProfileRef ref) async {
  final userId = supabase.auth.currentUser!.id;
  final data = await supabase
      .from('profiles')
      .select()
      .eq('id', userId)
      .single();
  return UserProfile.fromJson(data);
}

@riverpod
Future<UserProfile> userProfile(UserProfileRef ref, String userId) async {
  final data = await supabase
      .from('profiles')
      .select()
      .eq('id', userId)
      .single();
  return UserProfile.fromJson(data);
}

@riverpod
Future<int> followersCount(FollowersCountRef ref, String userId) async {
  final data = await supabase
      .from('follows')
      .select('follower_id')
      .eq('following_id', userId);
  return (data as List).length;
}

@riverpod
Future<int> followingCount(FollowingCountRef ref, String userId) async {
  final data = await supabase
      .from('follows')
      .select('following_id')
      .eq('follower_id', userId);
  return (data as List).length;
}

@riverpod
Future<List<UserProfile>> followers(FollowersRef ref, String userId) async {
  final data = await supabase
      .from('follows')
      .select('follower_id')
      .eq('following_id', userId);
  final ids =
      (data as List).map((row) => row['follower_id'] as String).toList();
  if (ids.isEmpty) return [];
  final profiles = await supabase
      .from('profiles')
      .select()
      .inFilter('id', ids);
  return (profiles as List)
      .map((e) => UserProfile.fromJson(e as Map<String, dynamic>))
      .toList();
}

@riverpod
Future<List<UserProfile>> following(FollowingRef ref, String userId) async {
  final data = await supabase
      .from('follows')
      .select('following_id')
      .eq('follower_id', userId);
  final ids =
      (data as List).map((row) => row['following_id'] as String).toList();
  if (ids.isEmpty) return [];
  final profiles = await supabase
      .from('profiles')
      .select()
      .inFilter('id', ids);
  return (profiles as List)
      .map((e) => UserProfile.fromJson(e as Map<String, dynamic>))
      .toList();
}

@riverpod
Future<bool> isFollowing(IsFollowingRef ref, String userId) async {
  final currentUserId = supabase.auth.currentUser!.id;
  final data = await supabase
      .from('follows')
      .select()
      .eq('follower_id', currentUserId)
      .eq('following_id', userId)
      .maybeSingle();
  return data != null;
}

@riverpod
Future<List<UserProfile>> allUsers(AllUsersRef ref) async {
  final currentUserId = supabase.auth.currentUser!.id;
  final data = await supabase
      .from('profiles')
      .select()
      .neq('id', currentUserId)
      .order('created_at');
  return (data as List)
      .map((e) => UserProfile.fromJson(e as Map<String, dynamic>))
      .toList();
}

// ── Mutations ─────────────────────────────────────────────────────────────────

@riverpod
class SocialNotifier extends _$SocialNotifier {
  @override
  void build() {}

  Future<void> follow(String userId) async {
    final currentUserId = supabase.auth.currentUser!.id;
    await supabase.from('follows').insert({
      'follower_id': currentUserId,
      'following_id': userId,
    });
    ref.invalidate(isFollowingProvider(userId));
    ref.invalidate(followersCountProvider(userId));
    ref.invalidate(followingCountProvider(currentUserId));
    ref.invalidate(followersProvider(userId));
  }

  Future<void> unfollow(String userId) async {
    final currentUserId = supabase.auth.currentUser!.id;
    await supabase
        .from('follows')
        .delete()
        .eq('follower_id', currentUserId)
        .eq('following_id', userId);
    ref.invalidate(isFollowingProvider(userId));
    ref.invalidate(followersCountProvider(userId));
    ref.invalidate(followingCountProvider(currentUserId));
    ref.invalidate(followersProvider(userId));
  }
}
