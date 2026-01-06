import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/response.dart';

abstract class GameDetailsControllerBase<T> {
  abstract final Ref ref;
  abstract final String gameId;

  late PagingController<int, T> _pagingController;
  PagingController<int, T> get pagingController => _pagingController;

  int _pageSize = 20;
  int get pageSize => _pageSize;
  set pageSize(int value) {
    _pageSize = value;
    refresh();
  }

  int _count = 0;
  int get count => _count;

  int? _next = 1;
  int? get next => _next;

  void refresh() {
    _pagingController.refresh();
  }

  void retryLastFailedRequest() {
    _pagingController.fetchNextPage();
  }

  void init() {
    _pagingController = PagingController<int, T>(
      fetchPage: _fetchPage,
      getNextPageKey: (state) {
        return _next;
      },
    );

    _pagingController.addListener(() => ref.notifyListeners());
  }

  void dispose() {
    _pagingController.dispose();
  }

  Future<PagainatedApiResponse<T>> getPage(int pageKey);

  Future<List<T>> _fetchPage(int pageKey) async {
    final res = await getPage(pageKey);
    _count = res.count;
    _next = res.next;
    ref.notifyListeners();

    return res.results ?? [];
  }
}
