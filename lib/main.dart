import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/dependencies.dart';
import 'core/utilities/app_logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const logger = DeveloperAppLogger();
  FlutterError.onError = (details) {
    logger.error(
      'Uncaught Flutter framework error',
      error: details.exception,
      stackTrace: details.stack,
    );
    if (!kReleaseMode) {
      FlutterError.presentError(details);
    }
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    logger.error('Uncaught platform error', error: error, stackTrace: stack);
    return true;
  };
  if (kReleaseMode) {
    ErrorWidget.builder = (details) => const _ReleaseErrorScreen();
  }
  runApp(
    ProviderScope(
      overrides: [appLoggerProvider.overrideWithValue(logger)],
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
