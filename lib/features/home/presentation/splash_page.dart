import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/dependencies.dart';
import '../../../core/widgets/error_state_view.dart';
import '../../../core/widgets/loading_view.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(onboardingStatusProvider);
    if (status.hasError) {
      return Scaffold(
        body: ErrorStateView(
          message: 'Flashhh could not open your saved data on this device.',
          onRetry: () => ref.invalidate(onboardingStatusProvider),
        ),
      );
    }
    return const Scaffold(body: LoadingView(label: 'Loading Flashhh'));
  }
}
