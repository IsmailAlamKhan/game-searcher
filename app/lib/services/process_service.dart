import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

import '../utils/logger.dart';

class ProcessService {
  Process? _process;
  bool _isShuttingDown = false;
  final Dio _dio = Dio();

  Future<void> startEngine() async {
    if (_process != null) return;

    try {
      String exePath;
      String workingDirectory;
      List<String> args = [];
      String executable;

      if (kDebugMode) {
        // In Debug mode, assume we are in app/ and engine/ is a sibling
        executable = 'python';
        // Correct path resolution for project root from app/lib/services
        // Directory.current in flutter run is usually the project root (e.g. app/)
        // needed to go up one level to get to the monorepo root
        final appDir = Directory.current.path;
        final projectRoot = p.dirname(appDir);
        final enginePath = p.join(projectRoot, 'engine');

        workingDirectory = enginePath;
        exePath = p.join(enginePath, 'main.py');
        args = [exePath];
        appLogger.i('Starting engine in DEBUG mode: $executable $args in $workingDirectory');
      } else {
        // In Release mode, the engine is bundled relative to the executable
        final executableDir = p.dirname(Platform.resolvedExecutable);
        final engineDir = p.join(executableDir, 'data', 'engine');
        workingDirectory = engineDir;
        executable = p.join(engineDir, 'game_search_engine.exe');
        exePath = executable;
        args = []; // Arguments are baked in or passed if needed
        appLogger.i('Starting engine in RELEASE mode: $executable in $workingDirectory');
      }

      _process = await Process.start(
        executable,
        args,
        workingDirectory: workingDirectory,
        runInShell: false,
      );

      _process!.stdout.listen((event) {
        final log = String.fromCharCodes(event);
        if (log.isNotEmpty) appLogger.t('[Engine] $log');
      });

      _process!.stderr.listen((event) {
        final log = String.fromCharCodes(event);
        if (log.isNotEmpty) appLogger.e('[Engine Error] $log');
      });

      _process!.exitCode.then((code) {
        if (!_isShuttingDown) {
          appLogger.w('Engine exited properly with code $code');
          _process = null;
        }
      });
    } catch (e, stack) {
      appLogger.e('Failed to start engine', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<bool> checkHealth() async {
    try {
      final response = await _dio.get('http://127.0.0.1:5678/health');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<void> stopEngine() async {
    _isShuttingDown = true;
    if (_process != null) {
      appLogger.i('Stopping engine...');
      _process!.kill();
      _process = null;
    }
  }
}

final processService = ProcessService();
