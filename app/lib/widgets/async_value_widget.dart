import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget<T> extends HookWidget {
  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final Future<void> Function()? onRetry;
  final bool skipLoadingOnReload;

  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.onRetry,
    this.skipLoadingOnReload = false,
  });

  @override
  Widget build(BuildContext context) {
    final isRetrying = useState(false);
    final _isRetrying = isRetrying.value;
    // isRetrying.value;
    return value.when(
      data: data,

      loading: () {
        if (skipLoadingOnReload && value.hasValue) {
          return data(value.value as T);
        }
        return const Center(child: CircularProgressIndicator());
      },
      error: (e, st) => Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text(
                'Something went wrong:\n$e',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _isRetrying
                      ? null
                      : () {
                          isRetrying.value = true;
                          final onRetry = this.onRetry;
                          if (onRetry != null) {
                            onRetry()
                                .then((_) => isRetrying.value = false)
                                .catchError((_, _) => isRetrying.value = false);
                          }
                        },
                  style: FilledButton.styleFrom(
                    shape: _isRetrying ? const CircleBorder() : null,
                  ),
                  child: _isRetrying
                      ? SizedBox.square(
                          dimension: 20,
                          child: const CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.refresh),
                            const SizedBox(width: 4),
                            const Text('Retry'),
                          ],
                        ),
                ),
              ],
            ],
          ),
        ),
      ),
      skipLoadingOnReload: skipLoadingOnReload,
    );
  }
}
