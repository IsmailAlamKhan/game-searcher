import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/update_state.dart';
import '../services/package_service.dart';

class UpdateIndicator extends ConsumerWidget {
  const UpdateIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final updateState = ref.watch(updateControllerProvider);
    final packageInfo = ref.watch(packageInfoProvider);
    final theme = Theme.of(context);

    return InkWell(
      // onTap: () => _handleTap(context, ref, updateState),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // _buildIcon(updateState, theme),
            // const SizedBox(height: 4),
            Text(
              'v${packageInfo.version}',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(UpdateState state, ThemeData theme) {
    switch (state.status) {
      case UpdateStatus.idle:
        return Icon(
          Icons.download,
          color: theme.colorScheme.onSurfaceVariant,
          size: 20,
        );

      case UpdateStatus.checking:
        return const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        );

      case UpdateStatus.available:
        return Icon(
          Icons.download,
          color: Colors.amber,
          size: 20,
        );

      case UpdateStatus.downloading:
        return SizedBox(
          width: 20,
          height: 20,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: state.downloadProgress,
                strokeWidth: 2,
                color: Colors.blue,
              ),
              Text(
                '${(state.downloadProgress * 100).toInt()}',
                style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );

      case UpdateStatus.downloaded:
        return const Icon(
          Icons.download_done,
          color: Colors.green,
          size: 20,
        );

      case UpdateStatus.installing:
        return const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        );

      case UpdateStatus.error:
        return const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 20,
        );
    }
  }

  // void _handleTap(BuildContext context, WidgetRef ref, UpdateState state) {
  //   final controller = ref.read(updateControllerProvider.notifier);
  //   final navigator = Navigator.of(context);

  //   switch (state.status) {
  //     case UpdateStatus.idle:
  //       // Check for updates
  //       _showCheckingDialog(context);
  //       controller.checkForUpdates().then((_) {
  //         navigator.pop(); // Close checking dialog
  //         final newState = ref.read(updateControllerProvider);
  //         if (newState.status == UpdateStatus.idle && context.mounted) {
  //           _showUpToDateSnackbar(context);
  //         }
  //       });
  //       break;

  //     case UpdateStatus.available:
  //       // Start download and show changelog with progress
  //       _showDownloadingDialog(context, ref);
  //       controller.downloadUpdate().then((_) {
  //         navigator.pop(); // Close downloading dialog
  //         final newState = ref.read(updateControllerProvider);
  //         if (newState.status == UpdateStatus.downloaded && context.mounted) {
  //           _showChangelogDialog(context, ref);
  //         } else if (newState.status == UpdateStatus.error && context.mounted) {
  //           _showErrorSnackbar(context, newState.errorMessage);
  //         }
  //       });
  //       break;

  //     case UpdateStatus.downloaded:
  //       // Show changelog dialog
  //       _showChangelogDialog(context, ref);
  //       break;

  //     case UpdateStatus.error:
  //       // Show error and allow retry
  //       _showErrorDialog(context, state.errorMessage ?? 'Unknown error');
  //       break;

  //     default:
  //       // Do nothing for checking, downloading, installing states
  //       break;
  //   }
  // }

  // void _showCheckingDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) {
  //       final theme = Theme.of(context);
  //       return Dialog(
  //         child: Padding(
  //           padding: const EdgeInsets.all(24),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               const CircularProgressIndicator(),
  //               const SizedBox(height: 16),
  //               Text(
  //                 'Checking for updates...',
  //                 style: theme.textTheme.titleMedium,
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _showDownloadingDialog(BuildContext context, WidgetRef ref) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) {
  //       return Consumer(
  //         builder: (context, ref, child) {
  //           final state = ref.watch(updateControllerProvider);
  //           final theme = Theme.of(context);

  //           return Dialog(
  //             child: Padding(
  //               padding: const EdgeInsets.all(24),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   LinearProgressIndicator(value: state.downloadProgress),
  //                   const SizedBox(height: 16),
  //                   Text(
  //                     'Downloading update...',
  //                     style: theme.textTheme.titleMedium,
  //                   ),
  //                   const SizedBox(height: 8),
  //                   Text(
  //                     '${(state.downloadProgress * 100).toStringAsFixed(1)}%',
  //                     style: theme.textTheme.bodyLarge,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  // void _showChangelogDialog(BuildContext context, WidgetRef ref) {
  //   final update = ref.read(latestUpdateProvider);
  //   if (update != null) {
  //     showDialog(
  //       context: context,
  //       builder: (context) => ChangelogDialog(update: update),
  //     );
  //   }
  // }

  // void _showUpToDateSnackbar(BuildContext context) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text('You\'re up to date!'),
  //       backgroundColor: Colors.green,
  //       behavior: SnackBarBehavior.floating,
  //     ),
  //   );
  // }

  // void _showErrorSnackbar(BuildContext context, String? message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message ?? 'An error occurred'),
  //       backgroundColor: Colors.red,
  //       behavior: SnackBarBehavior.floating,
  //     ),
  //   );
  // }

  // void _showErrorDialog(BuildContext context, String message) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Update Error'),
  //         content: Text(message),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
