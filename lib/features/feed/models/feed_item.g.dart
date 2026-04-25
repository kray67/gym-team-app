// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedItem _$FeedItemFromJson(Map<String, dynamic> json) => _FeedItem(
  id: json['id'] as String,
  actorId: json['actor_id'] as String,
  type: json['type'] as String,
  payload: json['payload'] as Map<String, dynamic>,
  createdAt: DateTime.parse(json['created_at'] as String),
  actor: json['actor'] == null
      ? null
      : UserProfile.fromJson(json['actor'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FeedItemToJson(_FeedItem instance) => <String, dynamic>{
  'id': instance.id,
  'actor_id': instance.actorId,
  'type': instance.type,
  'payload': instance.payload,
  'created_at': instance.createdAt.toIso8601String(),
  'actor': instance.actor,
};
