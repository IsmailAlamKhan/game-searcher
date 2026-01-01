import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'async_value_widget.dart';

class AppPagedChildBuilderDelegate<PageKey, ItemType> extends PagedChildBuilderDelegate<ItemType> {
  AppPagedChildBuilderDelegate({
    required super.itemBuilder,
    String? emptyTitle,
    String? errorTitle,
    required PagingController<PageKey, ItemType> pagingController,
    super.animateTransitions,
    super.firstPageProgressIndicatorBuilder,
    super.invisibleItemsThreshold,
    super.newPageErrorIndicatorBuilder,
    super.newPageProgressIndicatorBuilder,
    super.noMoreItemsIndicatorBuilder,
    super.transitionDuration,
  }) : super(
         firstPageErrorIndicatorBuilder: (context) {
           return AppErrorWidget.error(
             onRetry: () async => pagingController.refresh(),
             message: pagingController.error,
             title: errorTitle,
           );
         },

         noItemsFoundIndicatorBuilder: (context) {
           return AppErrorWidget.empty(title: emptyTitle);
         },
       );
}
