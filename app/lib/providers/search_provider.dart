import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/game_record.dart';
import '../models/tag.dart';
import '../services/api_service.dart';

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

  final List<Tag> _selectedTags = [];
  List<Tag> get selectedTags => List.unmodifiable(_selectedTags);

  void toggleTag(Tag tag) {
    if (_selectedTags.contains(tag)) {
      _selectedTags.remove(tag);
    } else {
      _selectedTags.add(tag);
    }
    ref.notifyListeners();
    // Use low-level check to determine if we should refresh.
    // Maybe debounce this if user clicks rapidly, but for now instant refresh is okay.
    _pagingController.refresh();
  }

  // Allow searching without query if tags are present?
  // ApiService usually requires query 'q' or tags. The backend supports empty q if tags are present.

  Future<void> search(String query) async {
    // if (query.isEmpty && _selectedTags.isEmpty) return; // Allow empty query if tags selected
    _query = query;
    ref.notifyListeners();
    _pagingController.refresh();
  }

  Future<List<GameRecord>> _fetchPage(int pageKey) async {
    final api = ref.read(apiServiceProvider);
    final tagsParam = _selectedTags.map((t) => t.slug).toList();
    final newGames = await api.search(_query, page: pageKey, limit: _pageSize, tags: tagsParam);
    return newGames;
  }
}
