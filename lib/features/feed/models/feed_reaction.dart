class FeedReaction {
  final String feedItemId;
  final String userId;
  final String type; // 'heart' | 'thumbs_up' | 'biceps'

  const FeedReaction({
    required this.feedItemId,
    required this.userId,
    required this.type,
  });

  factory FeedReaction.fromJson(Map<String, dynamic> json) => FeedReaction(
        feedItemId: json['feed_item_id'] as String,
        userId: json['user_id'] as String,
        type: json['type'] as String,
      );
}
