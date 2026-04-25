import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/feed/models/feed_reaction.dart';

part 'reactions_provider.g.dart';

@riverpod
Future<List<FeedReaction>> feedReactions(
    FeedReactionsRef ref, String feedItemId) async {
  final data = await supabase
      .from('feed_reactions')
      .select()
      .eq('feed_item_id', feedItemId);
  return (data as List)
      .map((e) => FeedReaction.fromJson(e as Map<String, dynamic>))
      .toList();
}

@riverpod
class ReactionsNotifier extends _$ReactionsNotifier {
  @override
  void build() {}

  Future<void> toggleReaction(
    String feedItemId,
    String type, {
    required String ownerId,
    String? sessionId,
  }) async {
    final userId = supabase.auth.currentUser!.id;

    final existing = await supabase
        .from('feed_reactions')
        .select()
        .eq('feed_item_id', feedItemId)
        .eq('user_id', userId)
        .eq('type', type)
        .maybeSingle();

    if (existing != null) {
      await supabase
          .from('feed_reactions')
          .delete()
          .eq('feed_item_id', feedItemId)
          .eq('user_id', userId)
          .eq('type', type);
    } else {
      await supabase.from('feed_reactions').insert({
        'feed_item_id': feedItemId,
        'user_id': userId,
        'type': type,
      });

      // Notify the workout owner (skip if reacting to own workout)
      if (userId != ownerId) {
        final profileData = await supabase
            .from('profiles')
            .select('username, display_name')
            .eq('id', userId)
            .single();
        final reactorName = (profileData['display_name'] as String?) ??
            (profileData['username'] as String);
        await supabase.from('activity_feed').insert({
          'actor_id': userId,
          'target_id': ownerId,
          'type': 'workout_reacted',
          'payload': {
            'feed_item_id': feedItemId,
            if (sessionId != null) 'session_id': sessionId,
            'reactor_name': reactorName,
            'reaction_type': type,
          },
        });
      }
    }
    ref.invalidate(feedReactionsProvider(feedItemId));
  }
}
