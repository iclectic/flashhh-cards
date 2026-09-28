import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_page.dart';
import '../../features/home/presentation/splash_page.dart';
import '../../features/onboarding/presentation/onboarding_page.dart';
import '../../features/settings/presentation/settings_page.dart';
import '../dependencies.dart';
import 'app_routes.dart';

/// Keeps onboarding in front of the rest of the app until it is finished.
/// Paths are the deep-link surface for later deck and study routes.
String? redirectFor({
  required AsyncValue<bool> onboarding,
  required String location,
}) {
  if (onboarding.isLoading || onboarding.hasError) {
    return location == AppRoutes.splash ? null : AppRoutes.splash;
  }
  final completed = onboarding.value ?? false;
  final atOnboarding = location == AppRoutes.onboarding;
  final atSplash = location == AppRoutes.splash;
  if (!completed) {
    return atOnboarding ? null : AppRoutes.onboarding;
  }
  if (atOnboarding || atSplash) {
    return AppRoutes.home;
  }
  return null;
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final refresh = _RouterRefresh(ref);
  ref.onDispose(refresh.dispose);
  final router = GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: refresh,
    redirect: (context, state) {
      return redirectFor(
        onboarding: ref.read(onboardingStatusProvider),
        location: state.matchedLocation,
      );
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

final class _RouterRefresh extends ChangeNotifier {
  _RouterRefresh(Ref ref) {
    _subscription = ref.listen(onboardingStatusProvider, (previous, next) {
      notifyListeners();
    });
  }

  late final ProviderSubscription<AsyncValue<bool>> _subscription;

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}
