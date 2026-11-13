import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/dependencies.dart';
import '../../../core/analytics/analytics_event.dart';
import '../domain/ai_models.dart';

final documentImportListControllerProvider =
    AsyncNotifierProvider<DocumentImportListController, List<DocumentImport>>(
      DocumentImportListController.new,
    );

final class DocumentImportListController
    extends AsyncNotifier<List<DocumentImport>> {
  @override
  Future<List<DocumentImport>> build() {
    return ref.watch(documentImportStoreProvider).listRecent();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  /// Returns null when the person cancels the file dialog.
  Future<DocumentImport?> importPickedPdf() async {
    final picked = await ref.read(documentPickerProvider).pickPdf();
    if (picked == null) {
      return null;
    }
    final store = ref.read(documentImportStoreProvider);
    final created = await store.create(
      fileName: picked.fileName,
      byteSize: picked.byteSize,
    );
    unawaited(
      ref.read(analyticsClientProvider).track(AnalyticsEvent.pdfUploaded),
    );
    // Generation requires the backend (Phase 7). After local validation the
    // import is ready for generation so the person can see it was accepted.
    final ready = await store.updateStatus(
      id: created.id,
      status: DocumentImportStatus.readyForGeneration,
    );
    ref.invalidateSelf();
    return ready;
  }

  Future<void> discard(String id) async {
    await ref.read(documentImportStoreProvider).delete(id);
    ref.invalidateSelf();
  }
}
