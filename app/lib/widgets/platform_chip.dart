import 'package:flutter/material.dart';

import '../models/game_record.dart';
import '../utils/theme.dart';

class PlatformChip extends StatelessWidget {
  const PlatformChip({super.key, required this.platform});

  final Platform platform;

  @override
  Widget build(BuildContext context) {
    final theme = getAppThemeData(platform.color);
    return Theme(
      data: theme,
      child: Chip(
        label: Text(platform.name ?? "Unknown"),
        backgroundColor: theme.colorScheme.primary,
        labelStyle: TextStyle(color: theme.colorScheme.onPrimary),
        side: BorderSide.none,
      ),
    );
  }
}
