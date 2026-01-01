import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/game_record.dart';
import '../providers/game_details_gallery_provider.dart';
import 'paged_child_builder.dart';

class GameDetailsMediaSection extends HookConsumerWidget {
  const GameDetailsMediaSection({super.key, required this.game});
  final GameRecord game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(gameDetailsGalleryControllerProvider(game.id));
    return PagingListener(
      controller: controller.pagingController,
      builder: (context, state, fetchNextPage) {
        // if (controller.count == 0) {
        //   return SizedBox.shrink();
        // }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Gallery", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 230,
              child: PagedListView<int, GameScreenshot>.separated(
                scrollDirection: Axis.horizontal,
                builderDelegate: AppPagedChildBuilderDelegate<int, GameScreenshot>(
                  pagingController: controller.pagingController,
                  itemBuilder: (context, item, index) {
                    double aspectRatio = 16 / 9;
                    if (item.width != null && item.height != null) {
                      aspectRatio = item.width! / item.height!;
                    }
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AspectRatio(
                        aspectRatio: aspectRatio,
                        child: CachedNetworkImage(
                          imageUrl: item.image!,
                          fit: BoxFit.cover,
                          placeholder: (_, _) => Container(color: Colors.grey[850]),
                        ),
                      ),
                    );
                  },
                  emptyTitle: "No screenshots found",
                ),

                separatorBuilder: (_, _) => const SizedBox(width: 12),
                state: state,
                fetchNextPage: fetchNextPage,
              ),
            ),
          ],
        );
      },
    );
  }
}
