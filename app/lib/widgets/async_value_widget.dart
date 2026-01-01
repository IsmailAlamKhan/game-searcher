import 'dart:async';

import 'package:dio/dio.dart';
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
    // isRetrying.value;
    return value.when(
      data: data,

      loading: () {
        if (skipLoadingOnReload && value.hasValue) {
          return data(value.value as T);
        }
        return const Center(child: CircularProgressIndicator());
      },
      error: (e, st) => AppErrorWidget.error(onRetry: onRetry, message: e),
      skipLoadingOnReload: skipLoadingOnReload,
    );
  }
}

class AppErrorWidget extends HookWidget {
  const AppErrorWidget.error({
    super.key,
    this.onRetry,
    required this.message,
    this.isError = true,
    String? title,
    this.isCompact = false,
  }) : title = title ?? "Something went wrong";

  const AppErrorWidget.empty({super.key, this.onRetry, String? title, this.isCompact = false})
    : message = null,
      isError = false,
      title = title ?? "No data available";

  final Future<void> Function()? onRetry;
  final Object? message;
  final bool isError;
  final String title;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final isRetrying = useState(false);
    String? message;
    if (this.message is String) {
      message = this.message.toString();
    }
    if (this.message is Exception) {
      message = this.message.toString();
    }
    if (this.message is DioException) {
      message = this.message.toString();
    }

    double padding = isCompact ? 8.0 : 16.0;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isError) ...[
              Icon(Icons.error_outline, color: Colors.red, size: isCompact ? 24 : 48),
              SizedBox(height: padding),
            ] else ...[
              Icon(Icons.info_outline, color: Colors.grey, size: isCompact ? 24 : 48),
              SizedBox(height: padding),
            ],
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: isCompact ? 16 : 20),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              SizedBox(height: padding),
              Text(
                message.toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: isCompact ? 12 : 16),
                textAlign: TextAlign.center,
              ),
            ],

            if (onRetry != null) ...[
              SizedBox(height: padding),
              FilledButton(
                onPressed: isRetrying.value
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
                  shape: isRetrying.value ? const CircleBorder() : null,
                ),
                child: isRetrying.value
                    ? SizedBox.square(
                        dimension: 20,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.refresh),
                          SizedBox(width: padding / 3),
                          const Text('Retry'),
                        ],
                      ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
