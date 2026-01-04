import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/update.dart';
import '../models/update_state.dart';
import '../services/preferences_service.dart';
import '../services/update_service.dart';
import '../utils/logger.dart';

part 'update_provider.g.dart';

@Riverpod(keepAlive: true)
class UpdateController extends _$UpdateController {
  @override
  UpdateState build() {
    // Check for downloaded update on initialization
    // _checkDownloadedUpdate();
    return const UpdateState();
  }

  Future<void> _checkDownloadedUpdate() async {
    final updateService = ref.read(updateServiceProvider);
    final downloaded = await updateService.getDownloadedUpdate();
    if (downloaded != null) {
      state = state.copyWith(
        status: UpdateStatus.downloaded,
        availableVersion: downloaded.version,
      );
    }
  }

  Future<void> checkForUpdates() async {
    if (state.status == UpdateStatus.checking || state.status == UpdateStatus.downloading) {
      return; // Already in progress
    }

    state = state.copyWith(status: UpdateStatus.checking, errorMessage: null);

    try {
      final updateService = ref.read(updateServiceProvider);
      final update = await updateService.checkForUpdates();
      updateService.updateLastCheckTimestamp();

      if (update != null) {
        state = state.copyWith(
          status: UpdateStatus.available,
          availableVersion: update.version,
        );
        // Store the update info for later use
        ref.read(latestUpdateProvider.notifier).state = update;
      } else {
        state = state.copyWith(status: UpdateStatus.idle);
      }
    } catch (e, stackTrace) {
      appLogger.e('Error checking for updates', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        status: UpdateStatus.error,
        errorMessage: 'Failed to check for updates: ${e.toString()}',
      );
    }
  }

  Future<void> downloadUpdate() async {
    final update = ref.read(latestUpdateProvider);
    if (update == null || state.status == UpdateStatus.downloading) {
      return;
    }

    state = state.copyWith(
      status: UpdateStatus.downloading,
      downloadProgress: 0.0,
      errorMessage: null,
    );

    try {
      final updateService = ref.read(updateServiceProvider);
      await updateService.downloadUpdate(
        update,
        onProgress: (progress) {
          state = state.copyWith(downloadProgress: progress);
        },
      );

      state = state.copyWith(
        status: UpdateStatus.downloaded,
        downloadProgress: 1.0,
      );
    } catch (e, stackTrace) {
      appLogger.e('Error downloading update', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        status: UpdateStatus.error,
        errorMessage: 'Failed to download update: ${e.toString()}',
        downloadProgress: 0.0,
      );
    }
  }

  Future<void> installUpdate() async {
    if (state.status != UpdateStatus.downloaded) {
      return;
    }

    state = state.copyWith(status: UpdateStatus.installing);

    try {
      final updateService = ref.read(updateServiceProvider);
      final preferencesService = ref.read(preferencesServiceProvider);

      final downloadedPath = preferencesService.get<String>(PrefKey.downloadedUpdatePath);

      if (downloadedPath == null) {
        throw Exception('No downloaded update found');
      }

      final installerFile = File(downloadedPath);
      if (!await installerFile.exists()) {
        throw Exception('Installer file not found');
      }

      await updateService.installUpdate(installerFile);
      // App will exit during installation
    } catch (e, stackTrace) {
      appLogger.e('Error installing update', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        status: UpdateStatus.error,
        errorMessage: 'Failed to install update: ${e.toString()}',
      );
    }
  }

  void resetError() {
    if (state.status == UpdateStatus.error) {
      state = state.copyWith(status: UpdateStatus.idle, errorMessage: null);
    }
  }
}

// Internal provider to store the latest update info
@Riverpod(keepAlive: true)
class LatestUpdate extends _$LatestUpdate {
  @override
  Update? build() => null;
}
