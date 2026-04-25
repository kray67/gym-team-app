class FeedComment {
  final String id;
  final String feedItemId;
  final String userId;
  final String content;
  final DateTime createdAt;
  final String? authorDisplayName;
  final String? authorUsername;

  const FeedComment({
    required this.id,
    required this.feedItemId,
    required this.userId,
    required this.content,
    required this.createdAt,
    this.authorDisplayName,
    this.authorUsername,
  });

  String get authorName => authorDisplayName ?? authorUsername ?? 'Unknown';

  factory FeedComment.fromJson(Map<String, dynamic> json) {
    final profile = json['profiles'] as Map<String, dynamic>?;
    return FeedComment(
      id: json['id'] as String,
      feedItemId: json['feed_item_id'] as String,
      userId: json['user_id'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      authorDisplayName: profile?['display_name'] as String?,
      authorUsername: profile?['username'] as String?,
    );
  }
}
