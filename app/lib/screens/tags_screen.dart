import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/tag.dart';
import '../providers/app_provider.dart';
import '../providers/search_provider.dart';
import '../providers/tags_provider.dart';

class TagsScreen extends HookConsumerWidget {
  const TagsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(tagsControllerProvider);
    final searchTextController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("Discovery Tags")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchTextController,
                    decoration: const InputDecoration(labelText: 'Search Tags', border: OutlineInputBorder()),
                    onSubmitted: (value) {
                      controller.search(value);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => controller.search(searchTextController.text),
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: PagingListener(
              controller: controller.pagingController,
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
                    itemBuilder: (context, item, index) => TagCard(item: item),
                    firstPageErrorIndicatorBuilder: (context) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Something went wrong.'),
                          const SizedBox(height: 16),
                          FilledButton(onPressed: () => controller.refresh(), child: const Text('Retry')),
                        ],
                      ),
                    ),
                    newPageErrorIndicatorBuilder: (context) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: IconButton(
                          onPressed: () => controller.retryLastFailedRequest(),
                          icon: const Icon(Icons.refresh),
                        ),
                      ),
                    ),
                    noItemsFoundIndicatorBuilder: (context) => const Center(child: Text('No tags found.')),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TagCard extends ConsumerWidget {
  const TagCard({super.key, required this.item});

  final Tag item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appController = ref.watch(appControllerProvider.notifier);
    final searchController = ref.watch(searchControllerProvider);
    Widget Function(Widget child) childBuilder;
    if (item.imageBackground != null) {
      childBuilder = (child) => Ink.image(
        image: CachedNetworkImageProvider(item.imageBackground!),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
        child: child,
      );
    } else {
      childBuilder = (child) => child;
    }
    return Card(
      clipBehavior: Clip.antiAlias,
      child: childBuilder(
        InkWell(
          onTap: () {
            appController.setSelectedIndex(0);
            searchController.search(item.name);
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.name,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
