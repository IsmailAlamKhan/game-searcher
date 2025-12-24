import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/tag.dart';
import '../services/api_service.dart';

part 'tags_provider.g.dart';

@riverpod
TagsController tagsController(Ref ref) {
  final controller = TagsController(ref);
  controller.init();

  ref.onDispose(controller.dispose);
  controller.pagingController.addListener(() {
    ref.notifyListeners();
  });

  return controller;
}

class TagsController {
  final Ref ref;

  TagsController(this.ref);

  late PagingController<int, Tag> _pagingController;

  PagingController<int, Tag> get pagingController => _pagingController;

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

  void init() {
    _pagingController = PagingController<int, Tag>(
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

  String _searchQuery = '';

  void search(String query) {
    if (_searchQuery == query) return;
    _searchQuery = query;
    _pagingController.refresh();
  }

  Future<List<Tag>> _fetchPage(int pageKey) async {
    final api = ref.read(apiServiceProvider);
    final newTags = await api.getTags(query: _searchQuery, page: pageKey, pageSize: _pageSize);
    return newTags;
  }

  // TagsController({required super.getNextPageKey, required super.fetchPage});

  // Future<List<Tag>> _fetchTags({required int page}) async {
  //   final api = ref.read(apiServiceProvider);
  //   final newTags = await api.getTags(page: page, pageSize: _pageSize);
  //   if (newTags.length < _pageSize) {
  //     _hasMore = false;
  //   }
  //   return newTags;
  // }

  // Future<void> loadMore() async {
  //   if (_isLoadingMore || !_hasMore) return;

  //   _isLoadingMore = true;
  //   final currentTags = state.value ?? [];

  //   // Notify listeners we are loading more (optional, depends on UI needs)
  //   // We don't want to set state = AsyncLoading() because that clears the list usually.
  //   // Instead we just silently fetch and update.

  //   try {
  //     final nextTags = await _fetchTags(page: _page + 1);
  //     _page++;
  //     state = AsyncValue.data([...currentTags, ...nextTags]);
  //   } catch (e, st) {
  //     state = AsyncValue.error(e, st);
  //   } finally {
  //     _isLoadingMore = false;
  //   }
  // }

  // bool get hasMore => _hasMore;
  // bool get isLoadingMore => _isLoadingMore;
}
