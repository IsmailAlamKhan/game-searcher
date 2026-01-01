import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/game_record.dart';
import '../models/response.dart';
import '../services/api_service.dart';
import 'game_details_controller_base.dart';

part 'game_details_gallery_provider.g.dart';

@riverpod
GameDetailsGalleryController gameDetailsGalleryController(Ref ref, String gameId) {
  final controller = GameDetailsGalleryController(ref, gameId);
  controller.init();
  ref.onDispose(controller.dispose);
  return controller;
}

class GameDetailsGalleryController extends GameDetailsControllerBase<GameScreenshot> {
  @override
  final Ref ref;
  @override
  final String gameId;
  GameDetailsGalleryController(this.ref, this.gameId);

  @override
  Future<PagainatedApiResponse<GameScreenshot>> getPage(int pageKey) {
    final api = ref.read(apiServiceProvider);
    return api.getGameScreenshots(gameId, page: pageKey, pageSize: pageSize);
  }
}
