// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_chat_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiChatResponse _$AiChatResponseFromJson(Map<String, dynamic> json) =>
    _AiChatResponse(
      message: json['message'] as String,
      results: (json['results'] as List<dynamic>)
          .map((e) => Game.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AiChatResponseToJson(_AiChatResponse instance) =>
    <String, dynamic>{'message': instance.message, 'results': instance.results};

_Game _$GameFromJson(Map<String, dynamic> json) => _Game(
  id: _fromJson(json['id']),
  name: json['name'] as String,
  reason: json['reason'] as String,
  compatibility: json['compatibility'] as String,
  rating: _fromJson(json['rating']),
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  backgroundImage: json['background_image'] as String?,
);

Map<String, dynamic> _$GameToJson(_Game instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'reason': instance.reason,
  'compatibility': instance.compatibility,
  'rating': instance.rating,
  'tags': instance.tags,
  'background_image': instance.backgroundImage,
};
