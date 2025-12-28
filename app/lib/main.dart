import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'utils/logger.dart';
import 'utils/router.dart';

final class _ProviderObserver extends ProviderObserver {
  @override
  void didDisposeProvider(ProviderObserverContext context) {
    super.didDisposeProvider(context);
    appLogger.d("Provider ${context.provider.name} disposed");
  }

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    super.didAddProvider(context, value);
    appLogger.i("Provider ${context.provider.name} added with value $value");
  }
}

void main() {
  runApp(ProviderScope(observers: [_ProviderObserver()], child: GameSearchApp()));
}

class GameSearchApp extends ConsumerWidget {
  const GameSearchApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'GameSearch Studio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5865F2), brightness: Brightness.dark),
        useMaterial3: true,
      ),
      // home: const HomeScreen(),
      routerConfig: router,
    );
  }
}
