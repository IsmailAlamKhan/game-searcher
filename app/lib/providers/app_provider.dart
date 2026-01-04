import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/app_state.dart';
import '../services/preferences_service.dart';
import '../utils/debouncer.dart';
import '../utils/theme.dart';

part 'app_provider.g.dart';

@Riverpod(keepAlive: true)
class AppController extends _$AppController {
  late PreferencesService _preferencesService;
  final debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  @override
  AppState build() {
    _preferencesService = ref.watch(preferencesServiceProvider);
    return const AppState();
  }

  void getIndexAccordingToRoute(String route) {
    final index = AppState.routes.indexOf(route);
    if (index == -1) return;

    setSelectedIndex(index);
  }

  void setSelectedIndex(int index) {
    if (index == state.selectedIndex) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = state.copyWith(selectedIndex: index);
    });
  }

  void setBlurAdultContent(bool blurAdultContent) {
    if (blurAdultContent == state.blurAdultContent) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = state.copyWith(blurAdultContent: blurAdultContent);
    });
    debouncer(() => _preferencesService.set<bool>(PrefKey.adultContentBlur, blurAdultContent));
  }

  void setThemeSeedColor({Color? color, bool shouldUpdateStorage = true}) {
    if (color == state.themeSeedColor) return;
    print('Color----: ${color?.toARGB32()}');
    if (color == null && !shouldUpdateStorage) {
      color = _preferencesService.get<Color>(PrefKey.themeSeedColor, defaultValue: defaultSeedColor);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = state.copyWith(themeSeedColor: color);
    });
    if (shouldUpdateStorage) {
      debouncer(
        () => _preferencesService.set<Color>(PrefKey.themeSeedColor, color ?? defaultSeedColor),
      );
    }
  }

  void setAutoUpdateEnabled(bool autoUpdateEnabled) {
    if (autoUpdateEnabled == state.autoUpdateEnabled) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = state.copyWith(autoUpdateEnabled: autoUpdateEnabled);
    });
    debouncer(() => _preferencesService.set<bool>(PrefKey.autoUpdateEnabled, autoUpdateEnabled));
  }

  void setThemeMode(ThemeMode themeMode) {
    if (themeMode == state.themeMode) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = state.copyWith(themeMode: themeMode);
    });
    debouncer(() => _preferencesService.set<String>(PrefKey.themeMode, themeMode.name));
  }

  void setAutoUpdateInterval(Duration autoUpdateInterval) {
    if (autoUpdateInterval == state.autoUpdateInterval) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = state.copyWith(autoUpdateInterval: autoUpdateInterval);
    });
    debouncer(() => _preferencesService.set<Duration>(PrefKey.updateCheckInterval, autoUpdateInterval));
  }

  Future<void> init() async {
    final themeModeFromStorage = _preferencesService.get<String>(
      PrefKey.themeMode,
      defaultValue: ThemeMode.system.name,
    );
    final blurAdultContentFromStorage = _preferencesService.get<bool>(PrefKey.adultContentBlur, defaultValue: true);
    final autoUpdateEnabledFromStorage = _preferencesService.get<bool>(PrefKey.autoUpdateEnabled, defaultValue: true);
    final seedColorFromStorage = _preferencesService.get<Color>(
      PrefKey.themeSeedColor,
      defaultValue: defaultSeedColor,
    );
    final autoUpdateIntervalFromStorage = _preferencesService.get<Duration>(
      PrefKey.updateCheckInterval,
      defaultValue: const Duration(hours: 1),
    );

    state = state.copyWith(
      themeMode: ThemeMode.values.firstWhere((e) => e.name == themeModeFromStorage),
      blurAdultContent: blurAdultContentFromStorage!,
      autoUpdateEnabled: autoUpdateEnabledFromStorage!,
      autoUpdateInterval: autoUpdateIntervalFromStorage!,
      themeSeedColor: seedColorFromStorage,
    );
  }
}
