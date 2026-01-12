import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/compatibility_report.dart';
import '../models/game_record.dart';
import '../models/response.dart';
import '../models/search.dart';
import '../models/tag.dart';
import '../utils/catch_exception.dart';
import '../utils/dio.dart';
import '../utils/supabase.dart';

part 'api_service.g.dart';

@Riverpod(keepAlive: true)
ApiService apiService(Ref ref) {
  return ApiService(ref);
}

class ApiService {
  final Dio _dio;
  final SupabaseClient _supabase;

  ApiService(Ref ref) : _dio = ref.read(engineDioProvider), _supabase = ref.read(supabaseProvider);

  Future<PagainatedApiResponse<GameRecordListItem>> search({
    int pageSize = 100,
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
        :reverseOrder,
      ) = parms;
      // final response = await _dio.get(
      //   '/search',
      //   queryParameters: {
      //     'page_size': pageSize,
      //     'page': page,
      //     if (query != null && query.isNotEmpty) 'q': query,
      //     if (tags.isNotEmpty) 'tags': tags.map((t) => t.slug).join(','),
      //     'ordering': ordering.ordering(parms.reverseOrder),
      //     if (platform != null) 'platform': platform.id,
      //     if (genres.isNotEmpty) 'genres': genres.join(','),
      //     'search_precise': searchPrecise,
      //     'search_exact': searchExact,
      //   },
      // );
      // return PagainatedApiResponse<GameRecord>.fromJSON(
      //   response.data as Map<String, dynamic>,
      //   GameRecord.fromJson,
      // );
      PostgrestFilterBuilder<List<Map<String, dynamic>>> supabaseQuery = _supabase.from('games').select();

      if (query != null && query.isNotEmpty) {
        supabaseQuery = supabaseQuery.textSearch('name', query, type: TextSearchType.phrase);
      }
      if (tags.isNotEmpty) {
        supabaseQuery = supabaseQuery.filter(
          'tags',
          'in',
          tags.map((t) => t.name).toList(),
        );
      }
      // if (platform != null) supabaseQuery.eq('platform', platform.id);
      // if (genres.isNotEmpty) supabaseQuery.in('genres', genres);
      // if (searchPrecise) supabaseQuery.eq('name', query);
      // if (searchExact) supabaseQuery.eq('name', query);
      final response = await supabaseQuery
          .order(ordering.name, ascending: !reverseOrder)
          .limit(pageSize)
          .range(
            (page - 1) * pageSize,
            page * pageSize,
          )
          .then((value) {
            final _value = value;
            return _value;
          });
      final count = await supabaseQuery.count();

      return PagainatedApiResponse(
        count: count.count,
        results: response.map(GameRecordListItem.fromJson).toList(),
      );
    });
  }

  Future<PagainatedApiResponse<Tag>> getTags({String? query, int page = 1, int pageSize = 100}) async {
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
