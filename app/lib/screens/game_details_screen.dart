import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/game_record.dart';
import '../providers/game_details_provider.dart';
import '../widgets/async_value_widget.dart';
import '../widgets/game_description.dart';
import '../widgets/game_details_.dart';
import '../widgets/game_details_header.dart';
import '../widgets/game_details_horizontal_list_section.dart';
import '../widgets/game_details_media_section.dart';
import '../widgets/game_details_platform_section.dart';
import '../widgets/game_details_reddit_section.dart';
import '../widgets/game_details_requirement_section.dart';
import '../widgets/game_details_trailer_section.dart';

class GameDetailsScreen extends ConsumerWidget {
  final String gameId;

  const GameDetailsScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameAsync = ref.watch(gameDetailsProvider(gameId));

    return SelectionArea(
      child: Scaffold(
        body: AsyncValueWidget<GameRecord>(
          value: gameAsync,
          data: (game) => _GameDetailsContent(game: game),
        ),
      ),
    );
  }
}

class _GameDetailsContent extends StatelessWidget {
  final GameRecord game;

  const _GameDetailsContent({required this.game});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(context),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GameDetailsHeader(game: game),
                const SizedBox(height: 16),
                GameDetailsPlatformSection(game: game),
                const SizedBox(height: 24),
                GameDetailsStoreSection(game: game),
                const SizedBox(height: 32),
                GameDescription(game: game),
                const SizedBox(height: 32),
                if (game.platforms.any((p) => p.requirements != null)) ...[
                  const SizedBox(height: 32),
                  GameDetailsRequirementSection(game: game),
                ],
                GameDetailsMediaSection(game: game),
                const SizedBox(height: 32),
                if (game.trailers.isNotEmpty) ...[const SizedBox(height: 32), GameDetailsTrailerSection(game: game)],
                if (game.dlcs.isNotEmpty) ...[
                  const SizedBox(height: 32),
                  GameDetailsHorizontalListSection(
                    title: "DLCs & Editions",
                    items: game.dlcs.map((dlc) => dlc.toHorizontalList()).toList(),
                  ),
                ],
                if (game.sameSeries.isNotEmpty) ...[
                  const SizedBox(height: 32),
                  GameDetailsHorizontalListSection(
                    title: "More in Series",
                    items: game.sameSeries.map((series) => series.toHorizontalList()).toList(),
                    onItemTap: (id) => context.push('/details/$id'),
                  ),
                ],
                if (game.redditPosts.isNotEmpty) ...[const SizedBox(height: 32), GameDetailsRedditSection(game: game)],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.surface;
    return SliverAppBar(
      expandedHeight: 350,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground, StretchMode.blurBackground],
        title: Text(
          game.title,
          style: const TextStyle(
            shadows: [Shadow(blurRadius: 8, offset: Offset(0, 2))],
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (game.imageUrl != null)
              CachedNetworkImage(imageUrl: game.imageUrl!, fit: BoxFit.cover, placeholder: (_, _) => Container()),
            // Gradient Overlay
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, backgroundColor.withValues(alpha: 0.3), backgroundColor],
                  stops: const [0.5, 0.8, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
