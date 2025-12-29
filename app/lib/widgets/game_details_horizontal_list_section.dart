import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/game_record.dart';

class GameDetailsHorizontalListSection extends StatelessWidget {
  const GameDetailsHorizontalListSection({super.key, required this.title, required this.items, this.onItemTap});
  final String title;
  final List<HorizontalList> items;
  final ValueChanged<int>? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              return MouseRegion(
                cursor: onItemTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
                child: GestureDetector(
                  onTap: () => onItemTap?.call(item.id),
                  child: SizedBox(
                    width: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1.2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: item.image != null
                                ? CachedNetworkImage(imageUrl: item.image!, fit: BoxFit.cover, width: double.infinity)
                                : Container(
                                    color: Colors.grey[800],
                                    child: const Icon(Icons.image_not_supported, color: Colors.white24),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.name ?? "Unknown",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
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
