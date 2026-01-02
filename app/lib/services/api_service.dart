import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/app_exception.dart';
import '../models/compatibility_report.dart';
import '../models/game_record.dart';
import '../models/response.dart';
import '../models/search.dart';
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

  Future<PagainatedApiResponse<GameRecord>> search({
    int pageSize = 20,
    int page = 1,
    required SearchQueryParams parms,
  }) async {
    return catchException(() async {
      final SearchQueryParams(
        :query,
        :tags,
        :genres,
        :platform,
        :ordering,
        :searchPrecise,
        :searchExact,
      ) = parms;
      final response = await _dio.get(
        '/search',
        queryParameters: {
          'page_size': pageSize,
          'page': page,
          if (query != null && query.isNotEmpty) 'q': query,
          if (tags.isNotEmpty) 'tags': tags.map((t) => t.slug).join(','),
          'ordering': ordering.ordering(parms.reverseOrder),
          if (platform != null) 'platform': platform.id,
          if (genres.isNotEmpty) 'genres': genres.join(','),
          'search_precise': searchPrecise,
          'search_exact': searchExact,
        },
      );
      return PagainatedApiResponse<GameRecord>.fromJSON(
        response.data as Map<String, dynamic>,
        GameRecord.fromJson,
      );
    });
  }

  Future<PagainatedApiResponse<Tag>> getTags({String? query, int page = 1, int pageSize = 20}) async {
    return catchException(() async {
      final response = await _dio.get(
        '/tags',
        queryParameters: {if (query != null && query.isNotEmpty) 'q': query, 'page': page, 'page_size': pageSize},
      );
      return PagainatedApiResponse<Tag>.fromJSON(
        response.data as Map<String, dynamic>,
        Tag.fromJson,
      );
    });
  }

  Future<GameRecord> getGameDetails(String id) async {
    return catchException(() async {
      final response = await _dio.get('/game/$id');
      return GameRecord.fromJson(response.data as Map<String, dynamic>);
    });
  }

  Future<CompatibilityReport> checkCompatibility(String gameId, {Map<String, dynamic>? userSpecs}) async {
    return catchException(() async {
      final response = await _dio.post(
        '/game/$gameId/can-run-it',
        data: userSpecs != null ? {'user_specs': userSpecs} : null,
      );
      return CompatibilityReport.fromJson(response.data['report'] as Map<String, dynamic>);
    });
  }

  Future<PagainatedApiResponse<GameScreenshot>> getGameScreenshots(
    String gameId, {
    int pageSize = 20,
    int page = 1,
  }) async {
    return catchException(() async {
      final response = await _dio.get(
        '/game/$gameId/screenshots',
        queryParameters: {'page_size': pageSize, 'page': page},
      );
      return PagainatedApiResponse<GameScreenshot>.fromJSON(
        response.data as Map<String, dynamic>,
        GameScreenshot.fromJson,
      );
    });
  }

  Future<PagainatedApiResponse<Trailer>> getGameTrailers(String gameId, {int pageSize = 20, int page = 1}) async {
    return catchException(() async {
      final response = await _dio.get('/game/$gameId/trailers', queryParameters: {'page_size': pageSize, 'page': page});

      return PagainatedApiResponse<Trailer>.fromJSON(
        response.data as Map<String, dynamic>,
        Trailer.fromJson,
      );
    });
  }

  Future<PagainatedApiResponse<RedditPost>> getRedditPosts(String gameId, {int pageSize = 20, int page = 1}) async {
    return catchException(() async {
      final response = await _dio.get(
        '/game/$gameId/reddit',
        queryParameters: {'page_size': pageSize, 'page': page},
      );

      return PagainatedApiResponse<RedditPost>.fromJSON(
        response.data as Map<String, dynamic>,
        RedditPost.fromJson,
      );
    });
  }

  Future<PagainatedApiResponse<DLC>> getDLCs(String gameId, {int pageSize = 20, int page = 1}) async {
    return catchException(() async {
      final response = await _dio.get(
        '/game/$gameId/dlc',
        queryParameters: {'page_size': pageSize, 'page': page},
      );

      return PagainatedApiResponse<DLC>.fromJSON(
        response.data as Map<String, dynamic>,
        DLC.fromJson,
      );
    });
  }
}

Future<T> catchException<T>(Future<T> Function() func) async {
  AppException? exception;
  StackTrace? stackTrace;
  try {
    return await func();
  } on DioException catch (e, s) {
    exception = handleDioException(e);
    stackTrace = s;
  } catch (e, s) {
    exception = AppException('An unexpected error occurred');
    stackTrace = s;
  }

  appLogger.e('Exception: ${exception.message}', error: exception, stackTrace: stackTrace);

  throw exception;
}

AppException handleDioException(DioException e) {
  AppException exception;
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      exception = AppException(
        'The server took too long to respond',
        code: 504,
        type: 'connection-timeout',
      );
      break;
    case DioExceptionType.badResponse:
      final res = e.response;
      String message = "An unexpected error occurred";
      if (res?.statusCode == 401) {
        message = "You are not authorized to perform this action";
      } else if (res?.statusCode == 404 || res?.statusCode == 409) {
        message = "The resource you are trying to access does not exist";
      } else {
        if (res?.data is Map<String, dynamic>) {
          if (res?.data['message'] case String messageFromServer) {
            message = messageFromServer;
          }
          if (res?.data['detail'] case Map<String, dynamic> detail) {
            if (detail['message'] case String messageFromServer) {
              message = messageFromServer;
            }
          }
          if (res?.data['detail'] case String messageFromServer) {
            message = messageFromServer;
          }
        }
      }

      exception = AppException(
        message,
        code: e.response?.statusCode,
        type: 'bad-response',
        detail: e.response?.data,
      );
      break;
    case DioExceptionType.cancel:
      exception = AppException(
        'Request was canceled',
        code: 499,
        type: 'cancel',
      );
      break;
    case DioExceptionType.badCertificate:
      exception = AppException(
        'The server certificate is not trusted',
        code: 500,
        type: 'bad-certificate',
      );
      break;
    case DioExceptionType.unknown:
      exception = AppException(
        'An unknown error occurred',
        code: 500,
        type: 'unknown',
      );
    case DioExceptionType.connectionError:
      exception = AppException(
        'We could not connect to the server, maybe its an internet connection issue',
        code: 500,
        type: 'connection-error',
      );
      break;
  }

  return exception;
}
