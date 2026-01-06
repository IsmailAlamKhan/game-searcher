import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import '../models/app_state.dart';
import '../providers/app_provider.dart';
import '../utils/constants.dart';
import '../widgets/update_indicator.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, required this.child});
  final Widget child;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appControllerProvider);
    final selectedIndex = appState.selectedIndex;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kWindowCaptionHeight),
        child: WindowCaption(
          backgroundColor: theme.colorScheme.surface,
          brightness: theme.brightness,
          title: Text(appName, style: theme.textTheme.bodySmall),
        ),
      ),
      body: Row(
        children: [
          NavigationRail(
            trailingAtBottom: true,
            trailing: const UpdateIndicator(),
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) {
              context.go(AppState.routes[index]);
            },
            labelType: NavigationRailLabelType.all,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(icon: Icon(Icons.search), label: Text('Search')),
              NavigationRailDestination(icon: Icon(Icons.tag), label: Text('Tags')),
              NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}
