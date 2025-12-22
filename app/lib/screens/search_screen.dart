import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/search_provider.dart';
import '../widgets/async_value_widget.dart';

class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchState = ref.watch(searchControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Search Games")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: "Enter game title...",
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) => ref
                        .read(searchControllerProvider.notifier)
                        .search(value),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => ref
                      .read(searchControllerProvider.notifier)
                      .search(searchController.text),
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: AsyncValueWidget(
              value: searchState,
              onRetry: () => ref
                  .read(searchControllerProvider.notifier)
                  .search(searchController.text),
              data: (games) => games.isEmpty
                  ? const Center(child: Text("No results found"))
                  : ListView.builder(
                      itemCount: games.length,
                      itemBuilder: (context, index) {
                        final game = games[index];
                        return ListTile(
                          leading: game.imageUrl != null
                              ? Image.network(
                                  game.imageUrl!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.videogame_asset),
                          title: Text(game.title),
                          subtitle: Text(
                            "${game.releaseDate ?? 'Unknown'} • ${game.platforms.take(3).join(', ')}",
                          ),
                          trailing: game.score != null
                              ? Text(game.score.toString())
                              : null,
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
