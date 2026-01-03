import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../models/game_record.dart';
import '../providers/game_details_reddit_posts_provider.dart';
import '../utils/constants.dart';
import 'async_value_widget.dart';

class GameDetailsRedditSection extends HookConsumerWidget {
  const GameDetailsRedditSection({super.key, required this.game});

  final GameRecord game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final redditPostsController = ref.watch(gameDetailsRedditPostsControllerProvider(game.id));
    final total = redditPostsController.count;
    return PagingListener(
      controller: redditPostsController.pagingController,
      builder: (context, state, fetchNextPage) {
        final items = state.items;
        final isLoading = state.status == PagingStatus.loadingFirstPage;
        final isLoadingMore = state.status == PagingStatus.ongoing;
        final hasMore = state.status != PagingStatus.completed && state.status != PagingStatus.noItemsFound;
        final error = state.error;
        final firstPageError = state.status == PagingStatus.firstPageError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Reddit($total)", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Icon(Icons.reddit, color: Colors.deepOrange),
              ],
            ),
            const SizedBox(height: 16),
            if (isLoading)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < 10; i++) ...[
                    RedditPostCard(),
                  ],
                ],
              )
            else if (firstPageError)
              AppErrorWidget.error(
                onRetry: () async => redditPostsController.refresh(),
                message: error,
              )
            else if (items != null && items.isNotEmpty) ...[
              ...items.map(
                (post) => RedditPostCard(post: post),
              ),
              if (hasMore)
                RedditPostCard(
                  isAddMore: !isLoadingMore,
                  onLoadMore: () async => redditPostsController.pagingController.fetchNextPage(),
                ),
            ] else if (total == 0)
              AppErrorWidget.empty(title: "No posts found"),
          ],
        );
      },
    );
  }
}

class RedditPostCard extends StatelessWidget {
  const RedditPostCard({
    super.key,
    this.post,
    this.isAddMore = false,
    this.onLoadMore,
  });
  final RedditPost? post;
  final bool isAddMore;
  final VoidCallback? onLoadMore;

  @override
  Widget build(BuildContext context) {
    final post = this.post;
    Widget child;
    if (post == null) {
      child = Shimmer(child: ListTile());
    } else if (isAddMore) {
      child = ListTile(
        onTap: onLoadMore,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          "Load more...",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(Icons.open_in_new, size: 16, color: Colors.grey),
        leading: Icon(Icons.add, size: 16, color: Colors.grey),
      );
    } else {
      child = ListTile(
        onTap: () {
          if (post.url != null) launchUrlWithLogging(post.url!);
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          post.name,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.open_in_new, size: 16, color: Colors.grey),
        leading: post.image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  post.image!,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const Icon(Icons.chat_bubble_outline, color: Colors.white54),
                ),
              )
            : const Icon(Icons.chat_bubble_outline, color: Colors.white54),
      );
    }
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
