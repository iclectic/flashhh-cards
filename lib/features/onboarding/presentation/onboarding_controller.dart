import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/dependencies.dart';
import '../../../core/analytics/analytics_event.dart';

final onboardingControllerProvider =
    AsyncNotifierProvider<OnboardingController, void>(OnboardingController.new);

final class OnboardingController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> complete() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(preferencesRepositoryProvider)
          .setOnboardingCompleted(completed: true);
      await ref
          .read(analyticsClientProvider)
          .track(AnalyticsEvent.onboardingCompleted);
    });
    return !state.hasError;
  }
}
