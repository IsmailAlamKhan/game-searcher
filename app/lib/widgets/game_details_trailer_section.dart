import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/game_record.dart';
import '../providers/game_details_trailer_provider.dart';
import '../utils/constants.dart';
import 'paged_child_builder.dart';

class GameDetailsTrailerSection extends ConsumerWidget {
  const GameDetailsTrailerSection({super.key, required this.game});

  final GameRecord game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(gameDetailsTrailerControllerProvider(game.id));
    return PagingListener(
      controller: controller.pagingController,
      builder: (context, state, fetchNextPage) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Trailers", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: PagedListView.separated(
                scrollDirection: Axis.horizontal,

                separatorBuilder: (_, _) => const SizedBox(width: 12),
                state: state,
                fetchNextPage: fetchNextPage,
                builderDelegate: AppPagedChildBuilderDelegate<int, Trailer>(
                  pagingController: controller.pagingController,
                  emptyTitle: "No trailers found for this game",
                  itemBuilder: (context, trailer, index) {
                    return MouseRegion(
                      cursor: trailer.video != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
                      child: GestureDetector(
                        onTap: () {
                          if (trailer.video case String video) launchUrlWithLogging(video);
                        },
                        child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: trailer.preview != null
                                ? DecorationImage(
                                    image: NetworkImage(trailer.preview!),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withValues(alpha: 0.4),
                                      BlendMode.darken,
                                    ),
                                  )
                                : null,
                            color: Colors.grey[850],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(Icons.play_circle_fill, size: 48),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                right: 10,
                                child: Text(
                                  trailer.name ?? "Trailer",
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
