// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_chat_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiChatState _$AiChatStateFromJson(Map<String, dynamic> json) => _AiChatState(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => AiChatItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  isLoading: json['isLoading'] as bool? ?? false,
  initialLoading: json['initialLoading'] as bool? ?? false,
);

Map<String, dynamic> _$AiChatStateToJson(_AiChatState instance) =>
    <String, dynamic>{
      'items': instance.items,
      'isLoading': instance.isLoading,
      'initialLoading': instance.initialLoading,
    };

_AiChatItem _$AiChatItemFromJson(Map<String, dynamic> json) => _AiChatItem(
  id: json['id'] as String?,
  query: json['query'] as String?,
  error: json['error'] as String?,
  response: json['response'] == null
      ? null
      : AiChatResponse.fromJson(json['response'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AiChatItemToJson(_AiChatItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'query': instance.query,
      'error': instance.error,
      'response': instance.response,
    };
