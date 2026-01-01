import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/game_record.dart';
import '../models/search.dart';
import '../models/tag.dart';
import '../services/api_service.dart';
import '../utils/debouncer.dart';

part 'search_provider.g.dart';

@Riverpod(keepAlive: true)
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
  final debouncer = Debouncer(delay: const Duration(seconds: 1));

  late PagingController<int, GameRecord> _pagingController;
  PagingController<int, GameRecord> get pagingController => _pagingController;

  int _count = 0;
  int get totalCount => _count;

  int? _next = 1;
  int? get next => _next;

  void init() {
    _pagingController = PagingController<int, GameRecord>(
      fetchPage: _fetchPage,
      getNextPageKey: (state) {
        return _next;
      },
    );
  }

  void dispose() {
    _pagingController.dispose();
  }

  int _pageSize = 100;
  int get pageSize => _pageSize;
  set pageSize(int value) {
    _pageSize = value;
    refresh();
  }

  void refresh() {
    _count = 0;
    _next = 1;
    _pagingController.refresh();
  }

  void retryLastFailedRequest() {
    _count = 0;
    _next = 1;
    _pagingController.fetchNextPage();
  }

  SearchQueryParams _searchQueryParams = SearchQueryParams();
  SearchQueryParams get searchQueryParams => _searchQueryParams;
  set searchQueryParams(SearchQueryParams value) {
    if (value == _searchQueryParams) {
      return;
    }
    _searchQueryParams = value;
    ref.notifyListeners();
    debouncer(refresh);
  }

  void toggleTag(Tag tag) {
    final _selectedTags = _searchQueryParams.tags.toList();
    if (_selectedTags.contains(tag)) {
      _selectedTags.remove(tag);
    } else {
      _selectedTags.add(tag);
    }
    _searchQueryParams = _searchQueryParams.copyWith(tags: _selectedTags);
    ref.notifyListeners();
    refresh();
  }

  Future<void> search(String query) async {
    _searchQueryParams = _searchQueryParams.copyWith(query: query);
    ref.notifyListeners();
    refresh();
  }

  Future<List<GameRecord>> _fetchPage(int pageKey) async {
    final api = ref.read(apiServiceProvider);

    final newGames = await api.search(
      page: pageKey,
      pageSize: _pageSize,
      parms: _searchQueryParams,
    );
    _count = newGames.count;
    _next = newGames.next;
    ref.notifyListeners();
    return newGames.results ?? [];
  }
}
