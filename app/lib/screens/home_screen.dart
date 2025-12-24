import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/app_provider.dart';
import 'search_screen.dart';
import 'tags_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appControllerProvider);
    final appController = ref.watch(appControllerProvider.notifier);
    final selectedIndex = appState.selectedIndex;
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) {
              appController.setSelectedIndex(index);
            },
            labelType: NavigationRailLabelType.all,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(icon: Icon(Icons.search), label: Text('Search')),
              NavigationRailDestination(icon: Icon(Icons.tag), label: Text('Tags')),
              NavigationRailDestination(icon: Icon(Icons.save), label: Text('Presets')),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: _buildScreen(selectedIndex)),
        ],
      ),
    );
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return const SearchScreen();
      case 1:
        return const TagsScreen();
      case 2:
        return const Center(child: Text("Presets (Coming Soon)"));
      default:
        return const Center(child: Text("Unknown"));
    }
  }
}
