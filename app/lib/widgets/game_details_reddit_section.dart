import 'package:flutter/material.dart';

import '../models/game_record.dart';
import '../utils/constants.dart';

class GameDetailsRedditSection extends StatelessWidget {
  const GameDetailsRedditSection({super.key, required this.game});

  final GameRecord game;

  @override
  Widget build(BuildContext context) {
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
                    if (post.url != null) launchUrlWithLogging(post.url!);
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
}
