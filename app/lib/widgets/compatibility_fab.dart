import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/game_details_provider.dart';
import 'spec_selection_dialog.dart';

class CompatibilityFab extends ConsumerWidget {
  final String gameId;
  final String gameTitle;

  const CompatibilityFab({
    super.key,
    required this.gameId,
    required this.gameTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameDetailsProvider(gameId));
    final haveRequirementsForPC =
        game.value?.platforms.any((p) => p.name?.toLowerCase() == 'pc' && p.requirements != null) ?? false;
    if (!haveRequirementsForPC) {
      return SizedBox.shrink();
    }
    return FloatingActionButton.extended(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => SpecSelectionDialog(
            gameId: gameId,
            gameTitle: gameTitle,
          ),
        );
      },
      icon: const FaIcon(FontAwesomeIcons.gaugeHigh),
      label: const Text(
        "Can I Run It?",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
  }
}
