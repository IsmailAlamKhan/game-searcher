import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/game_record.dart';
import '../providers/app_provider.dart';
import '../providers/game_details_provider.dart';
import '../widgets/async_value_widget.dart';
import '../widgets/compatibility_fab.dart';
import '../widgets/game_description.dart';
import '../widgets/game_details_header.dart';
import '../widgets/game_details_horizontal_list_section.dart';
import '../widgets/game_details_media_section.dart';
import '../widgets/game_details_platform_section.dart';
import '../widgets/game_details_reddit_section.dart';
import '../widgets/game_details_requirement_section.dart';
import '../widgets/game_details_store_section.dart';
import '../widgets/game_details_trailer_section.dart';

class GameDetailsScreen extends HookConsumerWidget {
  final String gameId;

  const GameDetailsScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameAsync = ref.watch(gameDetailsProvider(gameId));

    final colors = ref.watch(gameDetailsProvider(gameId).select((value) => value.value?.colors));
    final appController = ref.watch(appControllerProvider.notifier);

    useEffect(() {
      if (colors != null && colors.isNotEmpty) {
        appController.setDefaultColor(colors.first);
      }
      return () {
        appController.setDefaultColor();
      };
    }, [colors]);
    return SelectionArea(
      child: Scaffold(
        body: AsyncValueWidget<GameRecord>(
          value: gameAsync,
          data: (game) => _GameDetailsContent(game: game),
          onRetry: () async {
            ref.invalidate(gameDetailsProvider(gameId));
            await ref.watch(gameDetailsProvider(gameId).future);
          },
        ),
        floatingActionButton: gameAsync.when(
          data: (game) => CompatibilityFab(gameId: gameId, gameTitle: game.title),
          error: (_, _) => null,
          loading: () => null,
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
    final colors = game.colors;
    return CustomScrollView(
      slivers: [
        _buildAppBar(context, colors), // Pass colors to app bar
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
                GameDetailsTrailerSection(game: game),
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
                if (game.redditPosts.isNotEmpty) ...[
                  const SizedBox(height: 32),
                  GameDetailsRedditSection(game: game),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context, List<Color>? extractedColors) {
    final backgroundColor = Theme.of(context).colorScheme.surface;

    // Create a gradient from extracted colors or fall back to a simple fade
    List<Color> gradientColors;

    gradientColors = [Colors.transparent, backgroundColor.withValues(alpha: 0.2), backgroundColor];

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
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 250,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: gradientColors,
                    stops: extractedColors != null && extractedColors.isNotEmpty
                        ? null // Let the gradient distribute evenly
                        : const [0.5, 0.8, 1.0],
                  ),
                ),
              ),
            ),
            // Gradient Overlay
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientColors,
                  stops: extractedColors != null && extractedColors.isNotEmpty
                      ? null // Let the gradient distribute evenly
                      : const [0.5, 0.8, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
