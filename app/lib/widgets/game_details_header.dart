import 'package:flutter/material.dart';

import '../models/game_record.dart';
import '../utils/constants.dart';
import 'game_score.dart';

class GameDetailsHeader extends StatelessWidget {
  const GameDetailsHeader({super.key, required this.game});

  final GameRecord game;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.primary;

    return SizedBox(
      height: 40,
      child: Row(
        children: [
          if (game.score != null) ...[GameScore(score: game.score!), const SizedBox(width: 16)],
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
}
