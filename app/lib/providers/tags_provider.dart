import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/tag.dart';
import '../services/api_service.dart';

part 'tags_provider.g.dart';

@Riverpod(keepAlive: true)
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

  int _pageSize = 100;
  int get pageSize => _pageSize;
  set pageSize(int value) {
    _pageSize = value;
    refresh();
  }

  int? _next = 1;
  int? get next => _next;

  int _count = 0;
  int get count => _count;

  void refresh() {
    _next = 1;
    _count = 0;
    _pagingController.refresh();
  }

  void retryLastFailedRequest() {
    _pagingController.fetchNextPage();
  }

  void init() {
    _pagingController = PagingController<int, Tag>(
      fetchPage: _fetchPage,
      getNextPageKey: (state) {
        return _next;
      },
    );
  }

  void dispose() {
    _pagingController.dispose();
  }

  String _searchQuery = '';

  void search(String query) {
    if (_searchQuery == query) return;
    _next = 1;
    _count = 0;
    _searchQuery = query;
    _pagingController.refresh();
  }

  Future<List<Tag>> _fetchPage(int pageKey) async {
    final api = ref.read(apiServiceProvider);
    final newTags = await api.getTags(query: _searchQuery, page: pageKey, pageSize: _pageSize);
    _next = newTags.next;
    _count = newTags.count;
    return newTags.results ?? [];
  }
}
