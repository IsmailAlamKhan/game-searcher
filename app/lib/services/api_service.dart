import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/compatibility_report.dart';
import '../models/game_record.dart';
import '../models/tag.dart';
import '../utils/logger.dart';

part 'api_service.g.dart';

@Riverpod(keepAlive: true)
ApiService apiService(Ref ref) {
  final dio = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:5678'));
  dio.interceptors.add(PrettyDioLogger());
  return ApiService(dio);
}

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<List<GameRecord>> search(String query, {int pageSize = 20, int page = 1, List<String>? tags}) async {
    final response = await _dio.get(
      '/search',
      queryParameters: {
        'q': query,
        'page_size': pageSize,
        'page': page,
        if (tags != null && tags.isNotEmpty) 'tags': tags.join(','),
      },
    );
    return (response.data as List).map((e) => GameRecord.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<Tag>> getTags({String? query, int page = 1, int pageSize = 20}) async {
    final response = await _dio.get(
      '/tags',
      queryParameters: {if (query != null && query.isNotEmpty) 'q': query, 'page': page, 'page_size': pageSize},
    );
    return (response.data as List).map((e) => Tag.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<GameRecord> getGameDetails(String id) async {
    final response = await _dio.get('/game/$id');
    appLogger.i('Get game details: ${response.data}');
    return GameRecord.fromJson(response.data as Map<String, dynamic>);
  }

  Future<List<GameRecord>> runPreset(String presetId) async {
    final response = await _dio.get('/run/$presetId');
    return (response.data as List).map((e) => GameRecord.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<CompatibilityReport> checkCompatibility(String gameId, {Map<String, dynamic>? userSpecs}) async {
    final response = await _dio.post(
      '/game/$gameId/can-run-it',
      data: userSpecs != null ? {'user_specs': userSpecs} : null,
    );
    return CompatibilityReport.fromJson(response.data['report'] as Map<String, dynamic>);
  }
}
