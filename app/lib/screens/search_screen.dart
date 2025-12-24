import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../models/game_record.dart';
import '../providers/search_provider.dart';

class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchTextController = useTextEditingController();
    final searchController = ref.watch(searchControllerProvider);
    useEffect(() {
      if (searchTextController.text != searchController.query) {
        searchTextController.text = searchController.query;
      }
      return () {};
    }, [searchController.query]);

    final scrollController = useScrollController();

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: const Text("Search Games"),
            pinned: true,
            // expandedHeight: 120,
            collapsedHeight: 120,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextController,
                      decoration: const InputDecoration(hintText: "Enter game title...", border: OutlineInputBorder()),
                      onSubmitted: (value) => searchController.search(value),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => searchController.search(searchTextController.text),
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
          ),

          PagingListener(
            controller: searchController.pagingController,
            builder: (context, state, fetchNextPage) {
              return PagedSliverList<int, GameRecord>.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                state: state,
                fetchNextPage: fetchNextPage,
                builderDelegate: PagedChildBuilderDelegate<GameRecord>(
                  itemBuilder: (context, item, index) => GameTile(item: item),
                  firstPageErrorIndicatorBuilder: (context) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Something went wrong.'),
                        const SizedBox(height: 16),
                        FilledButton(onPressed: () => searchController.refresh(), child: const Text('Retry')),
                      ],
                    ),
                  ),
                  newPageErrorIndicatorBuilder: (context) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: IconButton(
                        onPressed: () => searchController.retryLastFailedRequest(),
                        icon: const Icon(Icons.refresh),
                      ),
                    ),
                  ),
                  firstPageProgressIndicatorBuilder: (context) => Column(
                    children: [
                      for (int i = 0; i < 5; i++) ...[const SizedBox(height: 8), GameTile()],
                    ],
                  ),
                  newPageProgressIndicatorBuilder: (context) => GameTile(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class GameTile extends ConsumerWidget {
  const GameTile({super.key, this.item});

  final GameRecord? item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = this.item;
    if (item == null) {
      return Shimmer(child: ListTile());
    }
    return InkWell(
      onTap: () {},
      child: ListTile(
        mouseCursor: SystemMouseCursors.click,
        leading: Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.zero,
          shape: const CircleBorder(),
          child: item.imageUrl != null
              ? CachedNetworkImage(imageUrl: item.imageUrl!, width: 50, height: 50, fit: BoxFit.cover)
              : SizedBox.square(dimension: 50, child: const Icon(Icons.videogame_asset)),
        ),
        title: Text(item.title),
        subtitle: Text("${item.releaseDate ?? 'Unknown'} • ${item.platforms.take(3).join(', ')}"),
        trailing: item.score != null ? Text(item.score.toString()) : null,
      ),
    );
  }
}
