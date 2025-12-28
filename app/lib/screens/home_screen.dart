import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/app_state.dart';
import '../providers/app_provider.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appControllerProvider);
    final selectedIndex = appState.selectedIndex;
    final currentRoute = GoRouter.of(context).state.uri;

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) {
              // if (index == 0) {
              //   context.go('/');
              // } else if (index == 1) {
              //   context.go('/tags');
              // }
              context.go(AppState.routes[index]);
            },
            labelType: NavigationRailLabelType.all,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(icon: Icon(Icons.search), label: Text('Search')),
              NavigationRailDestination(icon: Icon(Icons.tag), label: Text('Tags')),
              // NavigationRailDestination(icon: Icon(Icons.save), label: Text('Presets')),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }

  // Widget _buildScreen(int index) {
  //   switch (index) {
  //     case 0:
  //       return const SearchScreen();
  //     case 1:
  //       return const TagsScreen();
  //     case 2:
  //       return const Center(child: Text("Presets (Coming Soon)"));
  //     default:
  //       return const Center(child: Text("Unknown"));
  //   }
  // }
}
