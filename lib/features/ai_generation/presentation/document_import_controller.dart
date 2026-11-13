import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/dependencies.dart';
import '../../../core/analytics/analytics_event.dart';
import '../../../core/errors/app_exception.dart';
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
    final bytes = picked.bytes;
    if (bytes != null && bytes.isNotEmpty) {
      ref.read(pendingDocumentBytesStoreProvider).put(created.id, bytes);
    }
    unawaited(
      ref.read(analyticsClientProvider).track(AnalyticsEvent.pdfUploaded),
    );
    final ready = await store.updateStatus(
      id: created.id,
      status: DocumentImportStatus.readyForGeneration,
    );
    ref.invalidateSelf();
    return ready;
  }

  Future<DocumentImport> importNotes({
    required String title,
    required String notes,
  }) async {
    final trimmed = notes.trim();
    if (trimmed.isEmpty) {
      throw const DocumentException(message: 'Paste some notes before saving.');
    }
    final safeTitle = title.trim().isEmpty ? 'Study notes' : title.trim();
    final fileName = safeTitle.toLowerCase().endsWith('.txt')
        ? safeTitle
        : '$safeTitle.txt';
    final bytes = utf8.encode(trimmed);
    final store = ref.read(documentImportStoreProvider);
    final created = await store.create(
      fileName: fileName,
      byteSize: bytes.length,
    );
    ref.read(pendingDocumentBytesStoreProvider).put(created.id, bytes);
    final ready = await store.updateStatus(
      id: created.id,
      status: DocumentImportStatus.readyForGeneration,
    );
    ref.invalidateSelf();
    return ready;
  }

  Future<void> discard(String id) async {
    ref.read(pendingDocumentBytesStoreProvider).discard(id);
    await ref.read(documentImportStoreProvider).delete(id);
    ref.invalidateSelf();
  }
}
