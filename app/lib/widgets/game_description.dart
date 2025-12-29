import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:markdown_widget/widget/markdown_block.dart';

import '../models/game_record.dart';

class GameDescription extends HookWidget {
  const GameDescription({super.key, required this.game});

  final GameRecord game;

  @override
  Widget build(BuildContext context) {
    String? description = game.description ?? game.extra['description_raw'] as String?;
    if (description == null) return const SizedBox.shrink();

    Map<String, String> langs = parseLanguages(description);
    final lang = useState(langs.keys.firstOrNull);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('About', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            if (langs.keys.length > 1)
              SegmentedButton<String>(
                segments: langs.keys.map((lang) => ButtonSegment(value: lang, label: Text(lang))).toList(),
                selected: {lang.value ?? langs.keys.first},
                onSelectionChanged: (selected) => lang.value = selected.first,
              ),
          ],
        ),
        if (lang.value != null) ...[
          const SizedBox(height: 12),
          MarkdownBlock(data: langs[lang.value]!),
        ],
      ],
    );
  }

  Map<String, String> parseLanguages(String text) {
    Map<String, String> result = {};

    // REGEX EXPLANATION:
    // \n+            : Matches one or more newlines (handles spacing before header)
    // ([A-Z][a-zñ]+) : Capturing Group 1. Matches Capitalized word (The Language Name).
    //                  Added 'ñ' specifically for Español.
    // \n             : Matches the newline immediately after the language name
    final RegExp regex = RegExp(r'\n+([A-Z][a-zñ]+)\n');

    // 1. Find all Language Headers
    Iterable<Match> matches = regex.allMatches(text);

    // 2. Handle the Default/English part (Text before the first match)
    if (matches.isEmpty) {
      result['English'] = text.trim();
      return result;
    }

    // Extract text from start up to the first regex match
    result['English'] = text.substring(0, matches.first.start).trim();

    // 3. Loop through matches to extract other languages
    List<Match> matchList = matches.toList();

    for (int i = 0; i < matchList.length; i++) {
      Match currentMatch = matchList[i];

      // Group 1 is the Language Name (e.g., "Español")
      String languageName = currentMatch.group(1)!;

      // Calculate start index (end of the current header)
      int contentStart = currentMatch.end;

      // Calculate end index (start of the next header OR end of string)
      int contentEnd = (i + 1 < matchList.length) ? matchList[i + 1].start : text.length;

      // Extract and clean the text
      String content = text.substring(contentStart, contentEnd).trim();

      result[languageName] = content;
    }

    return result;
  }
}
