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
  void didUpdateProvider(ProviderObserverContext context, Object? previousValue, Object? newValue) {
    super.didUpdateProvider(context, previousValue, newValue);
    if (newValue is AsyncError) {
      appLogger.e("Provider ${context.provider.name} updated from $previousValue to $newValue");
    } else {
      appLogger.d("Provider ${context.provider.name} updated from $previousValue to $newValue");
    }
  }

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    super.didAddProvider(context, value);
    appLogger.i("Provider ${context.provider.name} added with value $value");
  }
}

void main() {
  runApp(
    ProviderScope(
      observers: [_ProviderObserver()],
      child: GameSearchApp(),
      retry: (retryCount, error) {
        return null;
      },
    ),
  );
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
