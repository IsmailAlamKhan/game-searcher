import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/game_record.dart';

class GameDetailsMediaSection extends StatelessWidget {
  const GameDetailsMediaSection({super.key, required this.game});
  final GameRecord game;

  @override
  Widget build(BuildContext context) {
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
}
