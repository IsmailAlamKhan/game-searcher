import 'package:flutter/material.dart';

import '../models/game_record.dart';

class GameDetailsRequirementSection extends StatelessWidget {
  const GameDetailsRequirementSection({super.key, required this.game});
  final GameRecord game;

  @override
  Widget build(BuildContext context) {
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
      "iPhone": "iPhone",
      "iPad": "iPad",
      "iPod": "iPod",
      "Watch": "Watch",
    };

    String remaining = text;
    // Remove initial "Minimum:" or "Recommended:" if present
    remaining = remaining.replaceAll(RegExp(r'^(Minimum|Recommended):'), '').trim();

    // Regex to match "Key:" or specific keys without colon (like iPhone)
    final appleKeys = {"iPhone", "iPad", "iPod", "Watch"};
    final sortedKeys = keyMap.keys.toList()..sort((a, b) => b.length.compareTo(a.length));

    final pattern = sortedKeys
        .map((k) {
          if (appleKeys.contains(k)) return RegExp.escape(k); // Apple keys don't need colon
          return "${RegExp.escape(k)}:"; // Standard keys need colon
        })
        .join('|');

    final regex = RegExp('($pattern)');

    final matches = regex.allMatches(remaining).toList();

    if (matches.isEmpty) {
      return {"General": remaining};
    }

    for (int i = 0; i < matches.length; i++) {
      final match = matches[i];
      // group(1) contains the match, which might include the colon (e.g. "OS:")
      final rawMatch = match.group(1)!;
      final rawKey = rawMatch.replaceAll(':', '').trim();
      final normalizedKey = keyMap[rawKey] ?? rawKey;

      final start = match.end;
      final end = (i + 1 < matches.length) ? matches[i + 1].start : remaining.length;

      var value = remaining.substring(start, end).trim();
      // Clean up comma or dash at the start/end if mostly clean
      if (value.startsWith(',') || value.startsWith('-')) value = value.substring(1).trim();
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
}
