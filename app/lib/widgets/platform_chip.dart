import 'package:flutter/material.dart';

import '../models/game_record.dart';

class PlatformChip extends StatelessWidget {
  const PlatformChip({super.key, required this.platform});

  final Platform platform;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: platform.color ?? Colors.blue, brightness: Brightness.dark),
      ),
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);

          return Chip(
            label: Text(platform.name ?? "Unknown"),
            backgroundColor: theme.colorScheme.primary,
            labelStyle: TextStyle(color: theme.colorScheme.onPrimary),
            side: BorderSide.none,
          );
        },
      ),
    );
  }
}
