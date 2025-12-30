import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/game_record.dart';
import '../services/api_service.dart';
import '../utils/logger.dart';

part 'game_details_provider.g.dart';

@riverpod
class GameDetails extends _$GameDetails {
  @override
  Future<GameRecord> build(String id) async {
    appLogger.d('------ Building game details for $id');
    final api = ref.watch(apiServiceProvider);
    appLogger.d('------ Fetching game details for $id');
    return api
        .getGameDetails(id)
        .then((value) {
          appLogger.d('------ Fetched game details for $id');
          return value;
        })
        .catchError((e, s) {
          appLogger.e('------ Failed to fetch game details for $id', error: e, stackTrace: s);
          throw e;
        });
  }
}
