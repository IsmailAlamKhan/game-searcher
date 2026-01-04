// import 'package:flutter/material.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// import '../services/preferences_service.dart';

// part 'preferences_provider.g.dart';

// @riverpod
// class PreferencesController extends _$PreferencesController {
//   late PreferencesService _preferencesService;

//   @override
//   Future<void> build() async {

//     // Override the service provider with the actual instance
//     ref.read(preferencesServiceProvider.notifier).state = _preferencesService;
//   }

//   // Auto-update preferences
//   bool get autoUpdateEnabled => _preferencesService.autoUpdateEnabled;
//   Future<void> setAutoUpdateEnabled(bool value) async {
//     _preferencesService.autoUpdateEnabled = value;
//   }

//   bool get autoDownloadEnabled => _preferencesService.autoDownloadEnabled;
//   Future<void> setAutoDownloadEnabled(bool value) async {
//     _preferencesService.autoDownloadEnabled = value;
//   }

//   bool get showChangelogOnUpdate => _preferencesService.showChangelogOnUpdate;
//   Future<void> setShowChangelogOnUpdate(bool value) async {
//     _preferencesService.showChangelogOnUpdate = value;
//   }

//   Duration get updateCheckInterval => _preferencesService.updateCheckInterval;
//   Future<void> setUpdateCheckInterval(Duration value) async {
//     _preferencesService.updateCheckInterval = value;
//   }

//   // Theme preferences
//   ThemeMode get themeMode => _preferencesService.themeMode;
//   Future<void> setThemeMode(ThemeMode value) async {
//     _preferencesService.themeMode = value;
//     ref.invalidateSelf(); // Trigger rebuild if needed
//   }

//   Color? get themeSeedColor => _preferencesService.themeSeedColor;
//   Future<void> setThemeSeedColor(Color? value) async {
//     _preferencesService.themeSeedColor = value;
//     ref.invalidateSelf(); // Trigger rebuild if needed
//   }
// }
