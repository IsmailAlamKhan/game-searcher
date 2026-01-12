import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/ai_chat_response.dart';
import '../utils/catch_exception.dart';
import '../utils/dio.dart';

part 'chat_service.g.dart';

@Riverpod(keepAlive: true)
AiChatService aiChatService(Ref ref) {
  return AiChatService(ref);
}

class AiChatService {
  final Dio _dio;

  AiChatService(Ref ref) : _dio = ref.read(webhookDioProvider(isTest: true));

  Future<AiChatResponse> sendMessage(String message, String userId) async {
    return catchException(() async {
      final response = await _dio.post(
        '/ai-chat',
        data: {'query': message, 'user_id': userId},
      );
      var data = response.data;
      if (data is String) {
        return AiChatResponse.fromJson(jsonDecode(data)['data']);
      }
      return AiChatResponse.fromJson(data['data']);
    });
  }
}
