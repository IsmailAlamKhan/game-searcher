import 'package:flutter/material.dart';

import '../models/game_record.dart';
import 'platform_chip.dart';

class GameDetailsPlatformSection extends StatelessWidget {
  const GameDetailsPlatformSection({super.key, required this.game});

  final GameRecord game;

  @override
  Widget build(BuildContext context) {
    if (game.platforms.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Platforms",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: game.platforms.map((p) => PlatformChip(platform: p)).toList()),
      ],
    );
  }
}
