import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/game_record.dart';
import '../services/api_service.dart';

part 'game_details_provider.g.dart';

// @riverpod
// Future<GameRecord> gameDetails(Ref ref, String id) async {
//   final api = ref.read(apiServiceProvider);
//   return api.getGameDetails(id);
// }

@riverpod
class GameDetails extends _$GameDetails {
  @override
  Future<GameRecord> build(String id) async {
    final api = ref.read(apiServiceProvider);
    return api.getGameDetails(id);
  }
}
