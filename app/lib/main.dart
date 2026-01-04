import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'models/app_state.dart';
import 'providers/app_provider.dart';
import 'screens/startup_screen.dart';
// Actually AppExitResponse is in services.dart since Flutter 3.13. No separate import needed usually if material is imported, but let's check.
// It is in dart:ui. But wait, `didRequestAppExit` is WidgetsBindingObserver.
// `AppExitResponse` is in `dart:ui`.
import 'services/package_service.dart';
import 'services/preferences_service.dart';
import 'utils/constants.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    center: true,
    backgroundColor: defaultSeedColor,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    title: appName,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  if (kReleaseMode) {
    runApp(const StartupScreen());
  } else {
    await launchApp();
  }
}

Future<void> launchApp() async {
  final providerContainer = ProviderContainer(
    observers: [_ProviderObserver()],
    retry: (retryCount, error) => null,
  );
  await providerContainer.read(packageServiceProvider).init();
  await providerContainer.read(preferencesServiceProvider).init();
  await providerContainer.read(appControllerProvider.notifier).init();

  runApp(UncontrolledProviderScope(container: providerContainer, child: const GameSearchApp()));
}

class GameSearchApp extends ConsumerStatefulWidget {
  const GameSearchApp({super.key});

  @override
  ConsumerState<GameSearchApp> createState() => _GameSearchAppState();
}

class _GameSearchAppState extends ConsumerState<GameSearchApp> {
  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final appState = ref.watch(appControllerProvider);
    final virtualWindowFrameBuilder = VirtualWindowFrameInit();
    final AppState(:themeSeedColor, :themeMode) = appState;

    print("Theme seed color: $themeSeedColor");

    return MaterialApp.router(
      title: appName,
      theme: getAppThemeData(themeSeedColor, Brightness.light),
      darkTheme: getAppThemeData(themeSeedColor),
      themeMode: themeMode,
      routerConfig: router,
      builder: (context, child) {
        child = virtualWindowFrameBuilder(context, child!);
        return child;
      },
    );
  }
}
