import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/feed/models/feed_comment.dart';

part 'comments_provider.g.dart';

@riverpod
Future<List<FeedComment>> feedComments(
    FeedCommentsRef ref, String feedItemId) async {
  final data = await supabase
      .from('feed_comments')
      .select('*, profiles!user_id(username, display_name)')
      .eq('feed_item_id', feedItemId)
      .order('created_at');
  return (data as List)
      .map((e) => FeedComment.fromJson(e as Map<String, dynamic>))
      .toList();
}

@riverpod
class CommentsNotifier extends _$CommentsNotifier {
  @override
  void build() {}

  Future<void> addComment(
    String feedItemId,
    String content, {
    required String ownerId,
    String? sessionId,
  }) async {
    final userId = supabase.auth.currentUser!.id;
    await supabase.from('feed_comments').insert({
      'feed_item_id': feedItemId,
      'user_id': userId,
      'content': content.trim(),
    });

    // Notify the workout owner (skip if commenting on own workout)
    if (userId != ownerId) {
      final profileData = await supabase
          .from('profiles')
          .select('username, display_name')
          .eq('id', userId)
          .single();
      final commenterName = (profileData['display_name'] as String?) ??
          (profileData['username'] as String);
      await supabase.from('activity_feed').insert({
        'actor_id': userId,
        'target_id': ownerId,
        'type': 'workout_commented',
        'payload': {
          'feed_item_id': feedItemId,
          if (sessionId != null) 'session_id': sessionId,
          'commenter_name': commenterName,
        },
      });
    }

    ref.invalidate(feedCommentsProvider(feedItemId));
  }

  Future<void> deleteComment(String feedItemId, String commentId) async {
    await supabase.from('feed_comments').delete().eq('id', commentId);
    ref.invalidate(feedCommentsProvider(feedItemId));
  }
}
