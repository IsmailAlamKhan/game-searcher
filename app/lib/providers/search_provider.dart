import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/game_record.dart';
import '../services/api_service.dart';

part 'search_provider.g.dart';

@riverpod
SearchController searchController(Ref ref) {
  final controller = SearchController(ref);
  controller.init();

  ref.onDispose(controller.dispose);
  controller.pagingController.addListener(() {
    ref.notifyListeners();
  });
  return controller;
}

class SearchController {
  final Ref ref;

  SearchController(this.ref);

  late PagingController<int, GameRecord> _pagingController;
  PagingController<int, GameRecord> get pagingController => _pagingController;
  void init() {
    _pagingController = PagingController<int, GameRecord>(
      fetchPage: _fetchPage,
      getNextPageKey: (state) {
        final lastPage = state.pages?.lastOrNull;
        return state.lastPageIsEmpty
            ///|| (lastPage?.length ?? 0) < _pageSize
            ? null
            : state.nextIntPageKey;
      },
    );
  }

  void dispose() {
    _pagingController.dispose();
  }

  int _pageSize = 50;
  int get pageSize => _pageSize;
  set pageSize(int value) {
    _pageSize = value;
    refresh();
  }

  void refresh() {
    _pagingController.refresh();
  }

  void retryLastFailedRequest() {
    _pagingController.fetchNextPage();
  }

  String _query = '';

  String get query => _query;

  Future<void> search(String query) async {
    if (query.isEmpty) return;
    _query = query;
    if (_query != query) return;
    ref.notifyListeners();
    _pagingController.refresh();
  }

  Future<List<GameRecord>> _fetchPage(int pageKey) async {
    final api = ref.read(apiServiceProvider);
    final newGames = await api.search(_query, page: pageKey, limit: _pageSize);
    return newGames;
  }
}
