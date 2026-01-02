import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/game_record.dart';
import '../models/response.dart';
import '../services/api_service.dart';
import 'game_details_controller_base.dart';

part 'game_details_reddit_posts_provider.g.dart';

@riverpod
GameDetailsRedditPostsController gameDetailsRedditPostsController(Ref ref, String gameId) {
  final controller = GameDetailsRedditPostsController(ref, gameId);
  controller.init();
  ref.onDispose(controller.dispose);
  return controller;
}

class GameDetailsRedditPostsController extends GameDetailsControllerBase<RedditPost> {
  @override
  final Ref ref;
  @override
  final String gameId;
  GameDetailsRedditPostsController(this.ref, this.gameId);

  @override
  Future<PagainatedApiResponse<RedditPost>> getPage(int pageKey) {
    final api = ref.read(apiServiceProvider);
    return api.getRedditPosts(gameId, page: pageKey, pageSize: pageSize);
  }

  @override
  void init() {
    super.init();
    loadFirstPage();
  }

  void loadFirstPage() {
    pagingController.fetchNextPage();
  }
}
