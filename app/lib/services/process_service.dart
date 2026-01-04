import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;

import '../utils/logger.dart';

class ProcessService {
  Process? _process;
  bool _isShuttingDown = false;
  final Dio _dio = Dio();

  Future<void> startEngine() async {
    if (_process != null) return;

    try {
      String workingDirectory;
      List<String> args = [];
      String executable;

      // In Release mode, the engine is bundled relative to the executable
      final executableDir = p.dirname(Platform.resolvedExecutable);
      final engineDir = p.join(executableDir, 'data', 'engine');
      workingDirectory = engineDir;
      executable = p.join(engineDir, 'game_hunter_engine.exe');
      args = []; // Arguments are baked in or passed if needed
      appLogger.i('Starting engine in: $executable in $workingDirectory');

      _process = await Process.start(
        executable,
        args,
        workingDirectory: workingDirectory,
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
      _process!.kill(ProcessSignal.sigkill);
      _process = null;
    }
  }
}

final processService = ProcessService();
