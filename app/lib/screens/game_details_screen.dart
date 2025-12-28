import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/game_record.dart';
import '../providers/game_details_provider.dart';
import '../utils/constants.dart';
import '../widgets/async_value_widget.dart';

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
                _buildHeader(context),
                const SizedBox(height: 16),
                _buildPlatformsSection(context),
                const SizedBox(height: 24),
                _buildActionButtons(context),
                const SizedBox(height: 32),
                _buildDescription(context),
                const SizedBox(height: 32),
                _buildMediaSection(context),
                const SizedBox(height: 32),
                if (game.platforms.any((p) => p.requirements != null)) ...[
                  const SizedBox(height: 32),
                  _buildRequirementsSection(context),
                ],
                if (game.trailers.isNotEmpty) ...[const SizedBox(height: 32), _buildTrailersSection(context)],
                if (game.dlcs.isNotEmpty) ...[
                  const SizedBox(height: 32),
                  _buildHorizontalListSection(
                    context,
                    "DLCs & Editions",
                    game.dlcs.map((dlc) => dlc.toHorizontalList()).toList(),
                  ),
                ],
                if (game.sameSeries.isNotEmpty) ...[
                  const SizedBox(height: 32),
                  _buildHorizontalListSection(
                    context,
                    "More in Series",
                    game.sameSeries.map((series) => series.toHorizontalList()).toList(),
                    onItemTap: (id) => context.push('/details/$id'),
                  ),
                ],
                // if (game.achievements.isNotEmpty) ...[const SizedBox(height: 32), _buildAchievementsSection(context)],
                if (game.redditPosts.isNotEmpty) ...[const SizedBox(height: 32), _buildRedditSection(context)],
                const SizedBox(height: 80),
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

  Widget _buildHeader(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.primary;

    final scoreInPercent = (game.score! / 5) * 100;

    Color scoreColor = Colors.green;
    if (scoreInPercent < 60) scoreColor = Colors.orange;
    if (scoreInPercent < 40) scoreColor = Colors.red;

    return SizedBox(
      height: 40,
      child: Row(
        children: [
          if (game.score != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: scoreColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: scoreColor.withValues(alpha: 0.5)),
              ),
              height: double.infinity,
              child: Row(
                children: [
                  Icon(Icons.star, color: scoreColor, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    game.score!.toString(),
                    style: TextStyle(color: scoreColor, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
          ],
          if (game.releaseDate != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: backgroundColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              height: double.infinity,

              child: Row(
                children: [
                  const Icon(Icons.calendar_today, size: 14),
                  const SizedBox(width: 6),
                  Text(appDateFormat.format(game.releaseDate!), style: const TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        ...game.stores.map((store) {
          final url = store.url;
          final name = store.name ?? 'Store';
          if (url == null || url.isEmpty) return const SizedBox.shrink();

          return ElevatedButton.icon(
            onPressed: () => _launchUrl(url),
            icon: FaIcon(_getStoreIcon(name), size: 16),
            label: Text("Get on $name"),
          );
        }),
        if (game.website != null)
          FilledButton.icon(
            onPressed: () => _launchUrl(game.website!),
            icon: const FaIcon(FontAwesomeIcons.globe, size: 16),
            label: const Text("Official Website"),
          ),
      ],
    );
  }

  IconData _getStoreIcon(String? storeName) {
    final name = (storeName ?? "").toLowerCase();
    if (name.contains('steam')) return FontAwesomeIcons.steam;
    if (name.contains('playstation')) return FontAwesomeIcons.playstation;
    if (name.contains('xbox')) return FontAwesomeIcons.xbox;
    // if (name.contains('epic')) return FontAwesomeIcons.epicGames;
    if (name.contains('apple') || name.contains('app store')) return FontAwesomeIcons.apple;
    if (name.contains('google') || name.contains('android')) return FontAwesomeIcons.googlePlay;
    if (name.contains('gog')) return FontAwesomeIcons.ghost;
    if (name.contains('itch')) return FontAwesomeIcons.itchIo;
    return FontAwesomeIcons.bagShopping;
  }

  Widget _buildDescription(BuildContext context) {
    if (game.description == null && game.extra['description_raw'] == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("About", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text(game.extra['description_raw'] ?? game.description ?? "", style: TextStyle(fontSize: 15, height: 1.6)),
      ],
    );
  }

  Widget _buildMediaSection(BuildContext context) {
    if (game.screenshots.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Gallery", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: game.screenshots.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedNetworkImage(
                    imageUrl: game.screenshots[index],
                    fit: BoxFit.cover,
                    placeholder: (_, _) => Container(color: Colors.grey[850]),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrailersSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Trailers", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: game.trailers.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final trailer = game.trailers[index];
              return GestureDetector(
                onTap: () {
                  if (trailer.video case String video) _launchUrl(video);
                },
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: trailer.preview != null
                        ? DecorationImage(
                            image: NetworkImage(trailer.preview!),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.4), BlendMode.darken),
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
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalListSection(
    BuildContext context,
    String title,
    List<HorizontalList> items, {
    ValueChanged<int>? onItemTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              return MouseRegion(
                cursor: onItemTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
                child: GestureDetector(
                  onTap: () => onItemTap?.call(item.id),
                  child: SizedBox(
                    width: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1.2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: item.image != null
                                ? CachedNetworkImage(imageUrl: item.image!, fit: BoxFit.cover, width: double.infinity)
                                : Container(
                                    color: Colors.grey[800],
                                    child: const Icon(Icons.image_not_supported, color: Colors.white24),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.name ?? "Unknown",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRedditSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Reddit", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Icon(Icons.reddit, color: Colors.deepOrange),
          ],
        ),
        const SizedBox(height: 16),
        ...game.redditPosts
            .take(5)
            .map(
              (post) => Card(
                color: Colors.grey[900],
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  onTap: () {
                    if (post.url != null) _launchUrl(post.url!);
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
                ),
              ),
            ),
      ],
    );
  }

  Widget _buildPlatformsSection(BuildContext context) {
    final theme = Theme.of(context);
    if (game.platforms.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Platforms",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: game.platforms.map((p) {
            return Chip(
              label: Text(p.name ?? "Unknown"),
              backgroundColor: theme.colorScheme.primary,
              labelStyle: TextStyle(color: theme.colorScheme.onPrimary),
              side: BorderSide.none,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRequirementsSection(BuildContext context) {
    // Only show for PC or MacOS
    final platforms = game.platforms.where((p) => p.requirements != null);

    if (platforms.isEmpty) return const SizedBox.shrink();
    final List<Widget> children = [];
    for (final platform in platforms) {
      if (platform.requirements != null) {
        final reqs = platform.requirements!;
        children.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "System Requirements (${platform.name})",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (reqs.minimum != null) ...[
                        const Text(
                          "Minimum",
                          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 12),
                        _buildSpecsList(reqs.minimum!),
                      ],
                      if (reqs.minimum != null && reqs.recommended != null) ...[
                        const SizedBox(height: 16),
                        const Divider(),
                      ],
                      if (reqs.recommended != null) ...[
                        const Text(
                          "Recommended",
                          style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 12),
                        _buildSpecsList(reqs.recommended!),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final child in children) ...[child, const SizedBox(height: 16)],
      ],
    );
  }

  Widget _buildSpecsList(String rawText) {
    final specs = _parseSpecs(rawText);
    return Column(
      children: specs.entries
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(e.key, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                  Expanded(
                    child: Text(e.value, style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4)),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Map<String, String> _parseSpecs(String text) {
    final Map<String, String> specs = {};

    // Map raw keys to normalized display keys
    final keyMap = {
      "OS": "OS",
      "Processor": "Processor",
      "Memory": "Memory",
      "Graphics": "Graphics",
      "Video Card": "Graphics",
      "DirectX": "DirectX",
      "Storage": "Storage",
      "Hard Disk Space": "Storage",
      "Hard Drive": "Storage",
      "Sound Card": "Sound Card",
      "Additional Notes": "Additional Notes",
      "Additional": "Additional Notes",
      "Other Requirements": "Additional Notes",
      "Other": "Additional Notes",
      "Partner Requirements": "Partner",
      "Partner": "Partner",
    };

    String remaining = text;
    // Remove initial "Minimum:" or "Recommended:" if present
    remaining = remaining.replaceAll(RegExp(r'^(Minimum|Recommended):'), '').trim();

    // Regex to match "Key:"
    // We sort keys by length descending to match longer keys first (e.g. "Additional Notes" before "Additional")
    final sortedKeys = keyMap.keys.toList()..sort((a, b) => b.length.compareTo(a.length));
    final regex = RegExp(r'(' + sortedKeys.map(RegExp.escape).join('|') + r'):');

    final matches = regex.allMatches(remaining).toList();

    if (matches.isEmpty) {
      return {"General": remaining};
    }

    for (int i = 0; i < matches.length; i++) {
      final match = matches[i];
      final rawKey = match.group(1)!;
      final normalizedKey = keyMap[rawKey] ?? rawKey;

      final start = match.end;
      final end = (i + 1 < matches.length) ? matches[i + 1].start : remaining.length;

      var value = remaining.substring(start, end).trim();
      // Clean up comma at the end if mostly clean
      if (value.endsWith(',')) value = value.substring(0, value.length - 1);

      if (specs.containsKey(normalizedKey)) {
        specs[normalizedKey] = "${specs[normalizedKey]} / $value";
      } else {
        specs[normalizedKey] = value;
      }
    }

    specs.removeWhere((key, value) => value.isEmpty);

    return specs;
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }
}
