import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/dependencies.dart';
import '../../study/domain/study_models.dart';

final dashboardControllerProvider =
    AsyncNotifierProvider<DashboardController, DashboardSnapshot>(
      DashboardController.new,
    );

final class DashboardController extends AsyncNotifier<DashboardSnapshot> {
  @override
  Future<DashboardSnapshot> build() async {
    await ref.watch(localAccountProvider.future);
    return ref
        .watch(studyStatsReaderProvider)
        .load(now: ref.watch(clockProvider).now());
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
