import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/game_record.dart';
import '../utils/constants.dart';

class GameDetailsStoreSection extends StatelessWidget {
  const GameDetailsStoreSection({super.key, required this.game});
  final GameRecord game;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        if (game.website != null)
          OutlinedButton.icon(
            onPressed: () => launchUrlWithLogging(game.website!),
            icon: const FaIcon(FontAwesomeIcons.globe, size: 16),
            label: const Text("Official Website"),
          ),
        ...game.stores.map((store) {
          final url = store.url;
          final name = store.name ?? 'Store';
          if (url == null || url.isEmpty) return const SizedBox.shrink();

          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.fromSeed(seedColor: store.color ?? Colors.blue, brightness: Brightness.dark),
            ),
            child: FilledButton.icon(
              onPressed: () => launchUrlWithLogging(url),
              icon: FaIcon(getStoreIcon(name), size: 16),
              label: Text("Get on $name"),
            ),
          );
        }),
      ],
    );
  }
}
