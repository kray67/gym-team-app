import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/feed/models/feed_item.dart';
import 'package:gym_team/features/profile/models/user_profile.dart';

part 'feed_provider.g.dart';

@riverpod
Future<List<FeedItem>> activityFeed(ActivityFeedRef ref) async {
  final userId = supabase.auth.currentUser!.id;

  // 1. Get IDs of users we follow
  final followingData = await supabase
      .from('follows')
      .select('following_id')
      .eq('follower_id', userId);

  final followingIds = (followingData as List)
      .map((row) => row['following_id'] as String)
      .toList();

  // 2. Fetch items from followed users OR notifications targeting the current user
  final orFilter = followingIds.isEmpty
      ? 'target_id.eq.$userId'
      : 'actor_id.in.(${followingIds.join(',')}),target_id.eq.$userId';

  final feedData = await supabase
      .from('activity_feed')
      .select()
      .or(orFilter)
      .order('created_at', ascending: false)
      .limit(50);

  final feedList = feedData as List;
  if (feedList.isEmpty) return [];

  // 3. Fetch actor profiles in one query
  final actorIds =
      feedList.map((e) => e['actor_id'] as String).toSet().toList();
  final profilesData = await supabase
      .from('profiles')
      .select()
      .inFilter('id', actorIds);

  final profilesMap = {
    for (final p in (profilesData as List))
      p['id'] as String: UserProfile.fromJson(p as Map<String, dynamic>),
  };

  // 4. Assemble feed items with actor profiles attached
  return feedList.map((e) {
    final item = FeedItem.fromJson(e as Map<String, dynamic>);
    final actor = profilesMap[item.actorId];
    return actor != null ? item.copyWith(actor: actor) : item;
  }).toList();
}

/// Returns the activity_feed row id for a given workout session (if one exists).
@riverpod
Future<String?> workoutFeedItemId(
    WorkoutFeedItemIdRef ref, String sessionId) async {
  final data = await supabase
      .from('activity_feed')
      .select('id')
      .eq('type', 'workout_completed')
      .filter('payload', 'cs', '{"session_id":"$sessionId"}')
      .maybeSingle();
  return data?['id'] as String?;
}
