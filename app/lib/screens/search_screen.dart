import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../models/game_record.dart';
import '../providers/search_provider.dart';
import '../utils/constants.dart';
import '../widgets/game_score.dart';

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

    return Scaffold(
      appBar: AppBar(title: const Text("Search Games")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
          if (searchController.selectedTags.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 50,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: searchController.selectedTags.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final tag = searchController.selectedTags[index];
                    return Chip(label: Text(tag.name), onDeleted: () => searchController.toggleTag(tag));
                  },
                ),
              ),
            ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 10;
                if (constraints.maxWidth < 1200) {
                  crossAxisCount = 8;
                }
                if (constraints.maxWidth < 1000) {
                  crossAxisCount = 6;
                }
                if (constraints.maxWidth < 800) {
                  crossAxisCount = 4;
                }
                if (constraints.maxWidth < 600) {
                  crossAxisCount = 2;
                }
                return PagingListener(
                  controller: searchController.pagingController,
                  builder: (context, state, fetchNextPage) {
                    return PagedGridView<int, GameRecord>(
                      // separatorBuilder: (context, index) => const SizedBox(height: 8),
                      state: state,
                      padding: const EdgeInsets.all(8),
                      fetchNextPage: fetchNextPage,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: .8,
                      ),
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
                        // firstPageProgressIndicatorBuilder: (context) => GameTile(),
                        newPageProgressIndicatorBuilder: (context) => GameTile(),
                      ),
                    );
                  },
                );
              },
            ),
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
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Shimmer(child: Column()),
      );
    }
    Widget Function(Widget child) builder;

    if (item.imageUrl != null) {
      builder = (child) => Ink.image(
        image: CachedNetworkImageProvider(item.imageUrl!),
        colorFilter: ColorFilter.mode(
          Colors.black45,
          BlendMode.darken,
        ),
        fit: BoxFit.cover,
        child: child,
      );
    } else {
      builder = (child) => child;
    }
    return Card(
      clipBehavior: Clip.antiAlias,
      child: builder(
        InkWell(
          onTap: () {
            context.push('/details/${item.id}');
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white),
                ),
                const Spacer(),
                Text(
                  "${item.releaseDate != null ? appDateFormat.format(item.releaseDate!) : 'Unknown'} • ${item.platforms.map((e) => e.name).take(3).join(', ')}",
                  style: const TextStyle(fontSize: 10, color: Colors.white70),
                ),
                const SizedBox(height: 2),
                if (item.score != null) GameScore(score: item.score!, size: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
