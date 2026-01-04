import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/update.dart';
import '../utils/dio.dart';
import '../utils/logger.dart';
import 'package_service.dart';
import 'preferences_service.dart';

part 'update_service.g.dart';

@riverpod
UpdateService updateService(Ref ref) {
  return UpdateService(ref);
}

class UpdateService {
  final PackageService _packageService;
  final PreferencesService _preferencesService;
  final Dio _dio;

  static const String _githubOwner = 'IsmailAlamKhan';
  static const String _githubRepo = 'game-searcher';
  static const String _githubApiUrl = '/repos/$_githubOwner/$_githubRepo/releases/latest';

  UpdateService(Ref ref)
    : _packageService = ref.read(packageServiceProvider),
      _preferencesService = ref.read(preferencesServiceProvider),
      _dio = ref.read(githubDioProvider);

  /// Check if an update is available by comparing versions
  Future<Update?> checkForUpdates() async {
    try {
      appLogger.i('Checking for updates from GitHub...');
      final response = await _dio.get(_githubApiUrl);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final latestVersion = (data['tag_name'] as String).replaceFirst('v', '');
        final currentVersion = _packageService.packageInfo.version;

        appLogger.d('Current version: $currentVersion, Latest version: $latestVersion');

        if (_isNewerVersion(latestVersion, currentVersion)) {
          // Find the installer asset
          final assets = data['assets'] as List<dynamic>;
          final installerAsset = assets.firstWhere(
            (asset) => (asset['name'] as String).endsWith('.exe'),
            orElse: () => null,
          );

          if (installerAsset == null) {
            appLogger.w('No installer found in release assets');
            return null;
          }

          // Find checksum file if available
          final checksumAsset = assets.firstWhere(
            (asset) => (asset['name'] as String).contains('checksum'),
            orElse: () => null,
          );

          String? checksum;
          if (checksumAsset != null) {
            final checksumUrl = checksumAsset['browser_download_url'] as String;
            final checksumResponse = await _dio.get(checksumUrl);
            if (checksumResponse.statusCode == 200) {
              // Parse checksum file (assuming format: "hash  filename")
              final checksumContent = checksumResponse.data as String;
              final lines = checksumContent.split('\n');
              for (final line in lines) {
                if (line.contains(installerAsset['name'])) {
                  checksum = line.split(RegExp(r'\s+'))[0];
                  break;
                }
              }
            }
          }

          return Update(
            version: latestVersion,
            changelog: data['body'] as String? ?? 'No changelog available',
            downloadUrl: installerAsset['browser_download_url'] as String,
            fileSize: installerAsset['size'] as int,
            checksum: checksum,
            releaseDate: DateTime.parse(data['published_at'] as String),
          );
        } else {
          appLogger.i('App is up to date');
          return null;
        }
      } else {
        appLogger.e('Failed to check for updates: ${response.statusCode}');
        return null;
      }
    } catch (e, stackTrace) {
      appLogger.e('Error checking for updates', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// Compare two version strings (e.g., "1.2.3" vs "1.2.4")
  bool _isNewerVersion(String latestVersion, String currentVersion) {
    final latestParts = latestVersion.split('.').map(int.tryParse).whereType<int>().toList();
    final currentParts = currentVersion.split('.').map(int.tryParse).whereType<int>().toList();

    final maxLength = latestParts.length > currentParts.length ? latestParts.length : currentParts.length;

    for (int i = 0; i < maxLength; i++) {
      final latest = i < latestParts.length ? latestParts[i] : 0;
      final current = i < currentParts.length ? currentParts[i] : 0;

      if (latest > current) return true;
      if (latest < current) return false;
    }

    return false; // Versions are equal
  }

  /// Download an update with progress tracking
  Future<File> downloadUpdate(
    Update update, {
    required void Function(double progress) onProgress,
  }) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final fileName = path.basename(Uri.parse(update.downloadUrl).path);
      final filePath = path.join(tempDir.path, fileName);
      final file = File(filePath);

      appLogger.i('Downloading update to: $filePath');

      await _dio.download(
        update.downloadUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = received / total;
            onProgress(progress);
            appLogger.d('Download progress: ${(progress * 100).toStringAsFixed(1)}%');
          }
        },
      );

      appLogger.i('Download completed: $filePath');

      // Verify checksum if available
      if (update.checksum != null) {
        final isValid = await verifyChecksum(file, update.checksum!);
        if (!isValid) {
          await file.delete();
          throw Exception('Checksum verification failed');
        }
        appLogger.i('Checksum verification passed');
      }

      // Save downloaded update info
      _preferencesService.set<String>(PrefKey.downloadedUpdatePath, filePath);
      _preferencesService.set<String>(PrefKey.downloadedUpdateVersion, update.version);

      return file;
    } catch (e, stackTrace) {
      appLogger.e('Error downloading update', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Verify file checksum (SHA-256)
  Future<bool> verifyChecksum(File file, String expectedChecksum) async {
    try {
      final bytes = await file.readAsBytes();
      final digest = sha256.convert(bytes);
      final actualChecksum = digest.toString();

      appLogger.d('Expected checksum: $expectedChecksum');
      appLogger.d('Actual checksum: $actualChecksum');

      return actualChecksum.toLowerCase() == expectedChecksum.toLowerCase();
    } catch (e, stackTrace) {
      appLogger.e('Error verifying checksum', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// Install the update and restart the app
  Future<void> installUpdate(File installerFile) async {
    try {
      appLogger.i('Installing update from: ${installerFile.path}');

      // Get current app directory for silent install parameter
      final appDir = Directory.current.path;

      // Launch installer with silent parameters
      // /VERYSILENT = no dialogs
      // /SUPPRESSMSGBOXES = suppress message boxes
      // /NORESTART = don't restart system
      // /CLOSEAPPLICATIONS = close running instances
      // /RESTARTAPPLICATIONS = restart app after install
      // /DIR = installation directory
      final process = await Process.start(
        installerFile.path,
        [
          '/VERYSILENT',
          '/SUPPRESSMSGBOXES',
          '/NORESTART',
          '/CLOSEAPPLICATIONS',
          '/RESTARTAPPLICATIONS',
          '/DIR="$appDir"',
        ],
        mode: ProcessStartMode.detached,
      );

      appLogger.i('Installer launched with PID: ${process.pid}');

      // Clear downloaded update info
      _preferencesService.remove(PrefKey.downloadedUpdatePath);
      _preferencesService.remove(PrefKey.downloadedUpdateVersion);

      // Exit the current app
      appLogger.i('Exiting application for update installation...');
      exit(0);
    } catch (e, stackTrace) {
      appLogger.e('Error installing update', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Check if a downloaded update is available
  Future<Update?> getDownloadedUpdate() async {
    final filePath = _preferencesService.get<String>(PrefKey.downloadedUpdatePath);
    final version = _preferencesService.get<String>(PrefKey.downloadedUpdateVersion);

    if (filePath == null || version == null) {
      return null;
    }

    final file = File(filePath);
    if (!await file.exists()) {
      // Clean up stale references
      _preferencesService.remove(PrefKey.downloadedUpdatePath);
      _preferencesService.remove(PrefKey.downloadedUpdateVersion);
      return null;
    }

    // Return a minimal Update object for the downloaded version
    // We don't have all the original info, but we have what we need
    return Update(
      version: version,
      changelog: 'Update ready to install',
      downloadUrl: '', // Not needed for installed update
      fileSize: await file.length(),
    );
  }

  /// Check if it's time to check for updates based on interval
  bool shouldCheckForUpdates() {
    if (_preferencesService.get<bool>(PrefKey.autoUpdateEnabled) == false) {
      return false;
    }

    final lastCheck = _preferencesService.get<DateTime>(PrefKey.lastUpdateCheck);
    if (lastCheck == null) {
      return true;
    }

    final interval = _preferencesService.get<Duration>(
      PrefKey.updateCheckInterval,
      defaultValue: Duration(hours: 24),
    );
    final nextCheck = lastCheck.add(interval!);

    return DateTime.now().isAfter(nextCheck);
  }

  /// Update the last check timestamp
  void updateLastCheckTimestamp() {
    _preferencesService.set<DateTime>(PrefKey.lastUpdateCheck, DateTime.now());
  }
}
