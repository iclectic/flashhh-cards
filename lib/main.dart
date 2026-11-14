import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/dependencies.dart';
import 'core/diagnostics/crash_reporter.dart';
import 'core/utilities/app_logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const logger = DeveloperAppLogger();
  const crashReporter = LoggingCrashReporter(logger);
  FlutterError.onError = (details) {
    crashReporter.recordError(
      details.exception,
      details.stack,
      fatal: true,
    );
    if (!kReleaseMode) {
      FlutterError.presentError(details);
    }
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    crashReporter.recordError(error, stack, fatal: true);
    return true;
  };
  if (kReleaseMode) {
    ErrorWidget.builder = (details) => const _ReleaseErrorScreen();
  }
  runApp(
    ProviderScope(
      overrides: [
        appLoggerProvider.overrideWithValue(logger),
        crashReporterProvider.overrideWithValue(crashReporter),
      ],
      child: const FlashhhApp(),
    ),
  );
}

class _ReleaseErrorScreen extends StatelessWidget {
  const _ReleaseErrorScreen();

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Something went wrong. Please restart Flashhh.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
