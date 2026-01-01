import 'dart:ui'; // Needed for AppExitResponse on recent versions? No, it's typically in services or ui.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/app_provider.dart';
import 'screens/startup_screen.dart';
import 'services/process_service.dart';
// Actually AppExitResponse is in services.dart since Flutter 3.13. No separate import needed usually if material is imported, but let's check.
// It is in dart:ui. But wait, `didRequestAppExit` is WidgetsBindingObserver.
// `AppExitResponse` is in `dart:ui`.
import 'utils/logger.dart';
import 'utils/router.dart';
import 'utils/theme.dart';

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
  WidgetsFlutterBinding.ensureInitialized();
  if (kReleaseMode) {
    runApp(const StartupScreen());
  } else {
    launchApp();
  }
}

void launchApp() {
  runApp(
    ProviderScope(
      observers: [_ProviderObserver()],
      child: const GameSearchApp(),
      retry: (retryCount, error) {
        return null;
      },
    ),
  );
}

class GameSearchApp extends ConsumerStatefulWidget {
  const GameSearchApp({super.key});

  @override
  ConsumerState<GameSearchApp> createState() => _GameSearchAppState();
}

class _GameSearchAppState extends ConsumerState<GameSearchApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    processService.stopEngine();
    super.dispose();
  }

  @override
  Future<AppExitResponse> didRequestAppExit() async {
    await processService.stopEngine();
    return AppExitResponse.exit;
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final appState = ref.watch(appControllerProvider);
    appLogger.d('======= Default color: ${appState.defaultColor}');
    return MaterialApp.router(
      title: 'GameSearch Studio',
      theme: getAppThemeData(appState.defaultColor),
      routerConfig: router,
    );
  }
}
