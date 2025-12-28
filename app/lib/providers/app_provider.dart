import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/app_state.dart';

part 'app_provider.g.dart';

@riverpod
class AppController extends _$AppController {
  @override
  AppState build() {
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
}
