import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym_team/features/profile/models/user_profile.dart';

part 'feed_item.freezed.dart';
part 'feed_item.g.dart';

@freezed
abstract class FeedItem with _$FeedItem {
  const factory FeedItem({
    required String id,
    @JsonKey(name: 'actor_id') required String actorId,
    required String type,
    required Map<String, dynamic> payload,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    // Not from JSON — injected after fetching profiles separately
    UserProfile? actor,
  }) = _FeedItem;

  factory FeedItem.fromJson(Map<String, dynamic> json) =>
      _$FeedItemFromJson(json);
}
