import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_chat_response.freezed.dart';
part 'ai_chat_response.g.dart';

@freezed
abstract class AiChatResponse with _$AiChatResponse {
  const factory AiChatResponse({
    required String message,
    required List<Game> results,
    // required List<Step> steps,
  }) = _AiChatResponse;

  factory AiChatResponse.fromJson(Map<String, dynamic> json) => _$AiChatResponseFromJson(json);
}

String? _fromJson(dynamic id) => id?.toString();

@freezed
abstract class Game with _$Game {
  const factory Game({
    @JsonKey(fromJson: _fromJson) String? id,
    required String name,
    required String reason,
    required String compatibility,
    @JsonKey(fromJson: _fromJson) String? rating,
    @Default([]) List<String> tags,
    @JsonKey(name: 'background_image') String? backgroundImage,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}
