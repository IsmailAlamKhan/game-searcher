import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/tag.dart';
import '../providers/tags_provider.dart';

class TagsScreen extends ConsumerWidget {
  const TagsScreen({super.key});
  static const _pageSize = 20;

  // final PagingController<int, Tag> _pagingController = PagingController(
  //   fetchPage: _fetchPage,
  // );

  // @override
  // void initState() {
  //   super.initState();
  //   // _pagingController.addPageRequestListener((pageKey) {
  //   //   _fetchPage(pageKey);
  //   // });
  // }

  // Future<void> _fetchPage(int pageKey) async {
  //   try {
  //     final api = ref.read(apiServiceProvider);
  //     final newItems = await api.getTags(page: pageKey, pageSize: _pageSize);
  //     final isLastPage = newItems.length < _pageSize;
  //     if (isLastPage) {
  //       _pagingController.appendLastPage(newItems);
  //     } else {
  //       final nextPageKey = pageKey + 1;
  //       _pagingController.appendPage(newItems, nextPageKey);
  //     }
  //   } catch (error) {
  //     _pagingController.error = error;
  //   }
  // }

  // @override
  // void dispose() {
  //   _pagingController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _pagingController = ref.watch(tagsControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Discovery Tags")),
      body: PagingListener(
        controller: _pagingController.pagingController,
        builder: (context, state, fetchNextPage) {
          return PagedGridView<int, Tag>(
            state: state,
            fetchNextPage: fetchNextPage,

            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1.5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            builderDelegate: PagedChildBuilderDelegate<Tag>(
              itemBuilder: (context, item, index) => Card(
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (item.imageBackground != null)
                      Image.network(
                        item.imageBackground!,
                        fit: BoxFit.cover,
                        color: Colors.black45,
                        colorBlendMode: BlendMode.darken,
                        errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image)),
                      ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item.name,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              firstPageErrorIndicatorBuilder: (context) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Something went wrong.'),
                    const SizedBox(height: 16),
                    FilledButton(onPressed: () => _pagingController.refresh(), child: const Text('Retry')),
                  ],
                ),
              ),
              newPageErrorIndicatorBuilder: (context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: IconButton(
                    onPressed: () => _pagingController.retryLastFailedRequest(),
                    icon: const Icon(Icons.refresh),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
