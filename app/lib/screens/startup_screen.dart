import 'dart:async';

import 'package:flutter/material.dart';

import '../main.dart';
import '../services/process_service.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  String _status = 'Initializing...';
  double _progress = 0.0;
  Timer? _pollingTimer;

  @override
  void initState() {
    super.initState();
    _startUp();
  }

  Future<void> _startUp() async {
    setState(() {
      _status = 'Starting Engine...';
      _progress = 0.2;
    });

    try {
      await processService.startEngine();
    } catch (e) {
      setState(() {
        _status = 'Failed to start engine: $e';
        _progress = 0.0;
      });
      return;
    }

    setState(() {
      _status = 'Connecting to Engine...';
      _progress = 0.4;
    });

    int attempts = 0;
    _pollingTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) async {
      attempts++;
      final isReady = await processService.checkHealth();

      if (isReady) {
        timer.cancel();
        setState(() {
          _status = 'Engine Ready!';
          _progress = 1.0;
        });

        await Future.delayed(const Duration(milliseconds: 500));

        if (mounted) {
          launchApp();
        }
      } else {
        if (attempts > 60) {
          timer.cancel();
          setState(() {
            _status = 'Connection timed out. Please restart.';
            _progress = 0.0;
          });
        } else {
          if (mounted) {
            setState(() {
              _progress = 0.4 + (0.5 * (attempts / 60));
            });
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = getAppThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: Scaffold(
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.gamepad, size: 64, color: themeData.primaryColor),
                    const SizedBox(height: 24),
                    Text(
                      appName,
                      style: themeData.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 32),
                    LinearProgressIndicator(
                      value: _progress,
                      backgroundColor: Colors.white10,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _status,
                      style: themeData.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
