import 'dart:async';

import 'package:flutter_hooks/flutter_hooks.dart';

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({required this.delay});

  void call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  void cancel() {
    _timer?.cancel();
  }
}

Debouncer useDebouncer(Duration delay) {
  return useMemoized(
    () => Debouncer(delay: delay),
    [delay],
  );
}
