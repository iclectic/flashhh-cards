import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/dependencies.dart';
import '../domain/insight_models.dart';

final insightsControllerProvider =
    AsyncNotifierProvider<InsightsController, InsightsSnapshot>(
      InsightsController.new,
    );

final class InsightsController extends AsyncNotifier<InsightsSnapshot> {
  @override
  Future<InsightsSnapshot> build() async {
    await ref.watch(localAccountProvider.future);
    return ref
        .watch(insightsReaderProvider)
        .load(now: ref.watch(clockProvider).now());
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
