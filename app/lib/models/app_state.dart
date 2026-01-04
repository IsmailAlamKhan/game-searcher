import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState({
    @Default(0) int selectedIndex,
    @Default(true) bool blurAdultContent,
    Color? themeSeedColor,
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(true) bool autoUpdateEnabled,
    @Default(Duration(hours: 1)) Duration autoUpdateInterval,
  }) = _AppState;

  static const routes = ["/", "/tags", "/settings"];
}
