import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/app_state.dart';

part 'app_provider.g.dart';

@riverpod
class AppController extends _$AppController {
  @override
  AppState build() {
    return const AppState();
  }

  void setSelectedIndex(int index) {
    state = state.copyWith(selectedIndex: index);
  }
}
