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
    final searchController = ref.watch(searchControllerProvider);
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
      floatingActionButton: searchController.selectedTags.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                ref.read(appControllerProvider.notifier).setSelectedIndex(0);
              },
              icon: const Icon(Icons.search),
              label: Text("Search (${searchController.selectedTags.length})"),
            )
          : null,
    );
  }
}

class TagCard extends ConsumerWidget {
  const TagCard({super.key, required this.item});

  final Tag item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = ref.watch(searchControllerProvider);
    final isSelected = searchController.selectedTags.contains(item);

    Widget Function(Widget child) childBuilder;
    if (item.imageBackground != null) {
      childBuilder = (child) => Ink.image(
        image: CachedNetworkImageProvider(item.imageBackground!),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          isSelected ? Colors.green.withValues(alpha: .6) : Colors.black45,
          BlendMode.darken,
        ),
        child: child,
      );
    } else {
      childBuilder = (child) => Container(color: isSelected ? Colors.green : Colors.grey[800], child: child);
    }
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: isSelected
          ? RoundedRectangleBorder(
              side: const BorderSide(color: Colors.greenAccent, width: 3),
              borderRadius: BorderRadius.circular(12),
            )
          : null,
      child: childBuilder(
        InkWell(
          onTap: () {
            // appController.setSelectedIndex(0); // Optional: stay on tags screen to select more?
            // Let's stay on tags screen to allow multi-select.
            searchController.toggleTag(item);
          },
          child: Stack(
            children: [
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
              if (isSelected)
                const Positioned(top: 8, right: 8, child: Icon(Icons.check_circle, color: Colors.greenAccent)),
            ],
          ),
        ),
      ),
    );
  }
}
