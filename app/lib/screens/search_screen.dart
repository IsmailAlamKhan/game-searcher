import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../models/game_record.dart';
import '../providers/app_provider.dart';
import '../providers/search_provider.dart';
import '../utils/constants.dart';
import '../widgets/game_score.dart';
import '../widgets/paged_child_builder.dart';
import '../widgets/search_header.dart';

class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = ref.watch(searchControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Search Games")),
      body: Column(
        children: [
          SearchHeader(),
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
                      builderDelegate: AppPagedChildBuilderDelegate<int, GameRecord>(
                        itemBuilder: (context, item, index) => GameTile(item: item),
                        pagingController: searchController.pagingController,
                        emptyTitle: "No games found",
                        errorTitle: "Error",
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
    final blurAdultContent = ref.watch(appControllerProvider).blurAdultContent;
    if (item == null) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Shimmer(child: Column()),
      );
    }
    Widget Function(Widget child) builder = (child) => child;

    final isAdultOnly = item.esrbRating?.isAdultOnly ?? false;
    if (item.imageUrl != null) {
      builder = (child) {
        Widget _child = Ink.image(
          image: CachedNetworkImageProvider(item.imageUrl!),
          colorFilter: ColorFilter.mode(
            Colors.black45,
            BlendMode.darken,
          ),
          fit: BoxFit.cover,
          child: child,
        );
        if (blurAdultContent && isAdultOnly) {
          _child = BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: _child,
          );
        }
        return _child;
      };
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
