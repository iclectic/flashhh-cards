import 'package:flashhh_cards/app/router/app_router.dart';
import 'package:flashhh_cards/app/router/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('redirect waits, gates onboarding, and restores deep links', () {
    expect(
      redirectFor(
        onboarding: const AsyncLoading(),
        location: AppRoutes.settings,
      ),
      AppRoutes.splash,
    );
    expect(
      redirectFor(
        onboarding: const AsyncData(false),
        location: AppRoutes.settings,
      ),
      AppRoutes.onboarding,
    );
    expect(
      redirectFor(
        onboarding: const AsyncData(false),
        location: AppRoutes.onboarding,
      ),
      isNull,
    );
    expect(
      redirectFor(
        onboarding: const AsyncData(true),
        location: AppRoutes.splash,
      ),
      AppRoutes.home,
    );
    expect(
      redirectFor(
        onboarding: const AsyncData(true),
        location: AppRoutes.settings,
      ),
      isNull,
    );
  });
}
