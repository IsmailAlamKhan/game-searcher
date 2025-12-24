import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/game_record.dart';
import '../models/tag.dart';
import 'logger_interceptor.dart';

part 'api_service.g.dart';

@riverpod
ApiService apiService(Ref ref) {
  final dio = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:5678'));
  dio.interceptors.add(PrettyDioLogger());
  return ApiService(dio);
}

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<List<GameRecord>> search(String query, {int limit = 20, int page = 1}) async {
    try {
      final response = await _dio.get('/search', queryParameters: {'q': query, 'limit': limit, 'page': page});
      return (response.data as List).map((e) => GameRecord.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Search failed: $e');
    }
  }

  Future<List<Tag>> getTags({String? query, int page = 1, int pageSize = 20}) async {
    try {
      final response = await _dio.get(
        '/tags',
        queryParameters: {if (query != null && query.isNotEmpty) 'q': query, 'page': page, 'page_size': pageSize},
      );
      return (response.data as List).map((e) => Tag.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Get tags failed: $e');
    }
  }

  Future<List<GameRecord>> runPreset(String presetId) async {
    try {
      final response = await _dio.get('/run/$presetId');
      return (response.data as List).map((e) => GameRecord.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Run preset failed: $e');
    }
  }
}
