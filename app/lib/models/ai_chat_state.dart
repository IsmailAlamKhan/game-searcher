import 'package:freezed_annotation/freezed_annotation.dart';

import 'ai_chat_response.dart';

part 'ai_chat_state.freezed.dart';
part 'ai_chat_state.g.dart';

@freezed
abstract class AiChatState with _$AiChatState {
  const factory AiChatState({
    @Default([]) List<AiChatItem> items,
    @Default(false) bool isLoading,
    @Default(false) bool initialLoading,
  }) = _AiChatState;

  factory AiChatState.fromJson(Map<String, dynamic> json) => _$AiChatStateFromJson(json);
}

@freezed
abstract class AiChatItem with _$AiChatItem {
  const factory AiChatItem({
    String? id,
    String? query,
    String? error,
    AiChatResponse? response,
  }) = _AiChatItem;

  factory AiChatItem.fromJson(Map<String, dynamic> json) => _$AiChatItemFromJson(json);
}
