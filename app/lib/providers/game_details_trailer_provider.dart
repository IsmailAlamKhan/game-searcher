import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/game_record.dart';
import '../models/response.dart';
import '../services/api_service.dart';
import 'game_details_controller_base.dart';

part 'game_details_trailer_provider.g.dart';

@riverpod
GameDetailsTrailerController gameDetailsTrailerController(Ref ref, String gameId) {
  final controller = GameDetailsTrailerController(ref, gameId);
  controller.init();
  ref.onDispose(controller.dispose);
  return controller;
}

class GameDetailsTrailerController extends GameDetailsControllerBase<Trailer> {
  @override
  final Ref ref;
  @override
  final String gameId;
  GameDetailsTrailerController(this.ref, this.gameId);

  @override
  Future<PagainatedApiResponse<Trailer>> getPage(int pageKey) {
    final api = ref.read(apiServiceProvider);
    return api.getGameTrailers(gameId, page: pageKey, pageSize: pageSize);
  }
}
