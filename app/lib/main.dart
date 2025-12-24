import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/home_screen.dart';

final class _ProviderObserver extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderObserverContext context, Object? previousValue, Object? newValue) {
    super.didUpdateProvider(context, previousValue, newValue);
    print("Provider ${context.provider.name} updated from $previousValue to $newValue");
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    super.didDisposeProvider(context);
    print("Provider ${context.provider.name} disposed");
  }

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    super.didAddProvider(context, value);
    print("Provider ${context.provider.name} added with value $value");
  }
}

void main() {
  runApp(ProviderScope(child: GameSearchApp(), observers: [_ProviderObserver()]));
}

class GameSearchApp extends StatelessWidget {
  const GameSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameSearch Studio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
