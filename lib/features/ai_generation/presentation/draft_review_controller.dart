import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/dependencies.dart';
import '../../../core/analytics/analytics_event.dart';
import '../../../core/errors/app_exception.dart';
import '../../flashcards/domain/flashcard.dart';
import '../../home/presentation/dashboard_controller.dart';
import '../domain/ai_models.dart';
import '../domain/generation_pipeline.dart';
import 'document_import_controller.dart';

final class DraftReviewState {
  const DraftReviewState({
    required this.document,
    required this.drafts,
    required this.rejectedCount,
    required this.selectedDeckId,
  });

  final DocumentImport document;
  final List<GeneratedFlashcardDraft> drafts;
  final int rejectedCount;
  final String? selectedDeckId;

  DraftReviewState copyWith({
    DocumentImport? document,
    List<GeneratedFlashcardDraft>? drafts,
    int? rejectedCount,
    String? selectedDeckId,
    bool clearDeck = false,
  }) {
    return DraftReviewState(
      document: document ?? this.document,
      drafts: drafts ?? this.drafts,
      rejectedCount: rejectedCount ?? this.rejectedCount,
      selectedDeckId: clearDeck
          ? null
          : (selectedDeckId ?? this.selectedDeckId),
    );
  }
}

final draftReviewControllerProvider = AsyncNotifierProvider.autoDispose
    .family<DraftReviewController, DraftReviewState, DraftReviewArgs>(
      DraftReviewController.new,
    );

final class DraftReviewArgs {
  const DraftReviewArgs({
    required this.documentImportId,
    this.notes,
    this.desiredCount = 12,
    this.difficulty = GenerationDifficulty.intermediate,
    this.questionStyle = QuestionStyle.mixed,
  });

  final String documentImportId;
  final String? notes;
  final int desiredCount;
  final GenerationDifficulty difficulty;
  final QuestionStyle questionStyle;

  @override
  bool operator ==(Object other) {
    return other is DraftReviewArgs &&
        other.documentImportId == documentImportId &&
        other.notes == notes &&
        other.desiredCount == desiredCount &&
        other.difficulty == difficulty &&
        other.questionStyle == questionStyle;
  }

  @override
  int get hashCode => Object.hash(
    documentImportId,
    notes,
    desiredCount,
    difficulty,
    questionStyle,
  );
}

final class DraftReviewController extends AsyncNotifier<DraftReviewState> {
  DraftReviewController(this.args);

  final DraftReviewArgs args;

  @override
  Future<DraftReviewState> build() async {
    final store = ref.watch(documentImportStoreProvider);
    final document = await store.findById(args.documentImportId);
    if (document == null) {
      throw const ValidationException(
        message: 'That import no longer exists.',
      );
    }

    await store.updateStatus(
      id: document.id,
      status: DocumentImportStatus.generating,
    );
    unawaited(
      ref.read(analyticsClientProvider).track(AnalyticsEvent.aiGenerationStarted),
    );

    try {
      final pipeline = ref.read(generationPipelineProvider);
      final result = args.notes != null && args.notes!.trim().isNotEmpty
          ? await pipeline.generateFromNotes(
              documentImportId: document.id,
              notes: args.notes!,
              desiredCount: args.desiredCount,
              difficulty: args.difficulty,
              questionStyle: args.questionStyle,
            )
          : await _generateForDocument(pipeline, document);

      final ready = await store.updateStatus(
        id: document.id,
        status: DocumentImportStatus.readyForReview,
      );
      unawaited(
        ref
            .read(analyticsClientProvider)
            .track(AnalyticsEvent.aiGenerationCompleted),
      );
      String? deckId;
      try {
        final account = await ref.read(localAccountProvider.future);
        final decks = await ref
            .read(deckRepositoryProvider)
            .listDecks(ownerId: account.id);
        if (decks.isNotEmpty) {
          deckId = decks.first.id;
        }
      } catch (_) {
        deckId = null;
      }
      return DraftReviewState(
        document: ready,
        drafts: result.accepted,
        rejectedCount: result.rejectedCount,
        selectedDeckId: deckId,
      );
    } catch (error) {
      await store.updateStatus(
        id: document.id,
        status: DocumentImportStatus.failed,
        errorMessage: failureFor(error).message,
      );
      unawaited(
        ref.read(analyticsClientProvider).track(AnalyticsEvent.aiGenerationFailed),
      );
      rethrow;
    }
  }

  Future<GeneratedFlashcardValidationResult> _generateForDocument(
    GenerationPipeline pipeline,
    DocumentImport document,
  ) async {
    if (document.fileName.toLowerCase().endsWith('.txt')) {
      final bytes = ref.read(pendingDocumentBytesStoreProvider).peek(document.id);
      if (bytes == null) {
        throw const DocumentException(
          message: 'Those notes are no longer available. Paste them again.',
        );
      }
      return pipeline.generateFromNotes(
        documentImportId: document.id,
        notes: utf8.decode(bytes),
        desiredCount: args.desiredCount,
        difficulty: args.difficulty,
        questionStyle: args.questionStyle,
      );
    }
    return pipeline.generateFromImport(
      document: document,
      desiredCount: args.desiredCount,
      difficulty: args.difficulty,
      questionStyle: args.questionStyle,
    );
  }

  void selectDeck(String? deckId) {
    final current = state.asData?.value;
    if (current == null) {
      return;
    }
    state = AsyncData(
      current.copyWith(selectedDeckId: deckId, clearDeck: deckId == null),
    );
  }

  void removeDraft(int index) {
    final current = state.asData?.value;
    if (current == null || index < 0 || index >= current.drafts.length) {
      return;
    }
    final next = [...current.drafts]..removeAt(index);
    state = AsyncData(current.copyWith(drafts: next));
  }

  void updateDraft(int index, GeneratedFlashcardDraft draft) {
    final current = state.asData?.value;
    if (current == null || index < 0 || index >= current.drafts.length) {
      return;
    }
    final next = [...current.drafts];
    next[index] = draft;
    state = AsyncData(current.copyWith(drafts: next));
  }

  Future<int> saveAccepted() async {
    final current = state.asData?.value;
    if (current == null) {
      throw const ValidationException(message: 'Nothing to save yet.');
    }
    final deckId = current.selectedDeckId;
    if (deckId == null || deckId.isEmpty) {
      throw const ValidationException(message: 'Choose a deck to save into.');
    }
    if (current.drafts.isEmpty) {
      throw const ValidationException(
        message: 'Keep at least one draft card to save.',
      );
    }

    final cards = ref.read(flashcardRepositoryProvider);
    final source = current.document.fileName.toLowerCase().endsWith('.pdf')
        ? FlashcardSource.pdf
        : FlashcardSource.aiGenerated;
    var saved = 0;
    for (final draft in current.drafts) {
      await cards.create(
        NewFlashcard(
          deckId: deckId,
          question: draft.question,
          answer: draft.answer,
          difficulty: draft.difficulty,
          source: source,
        ),
      );
      saved += 1;
    }

    await ref
        .read(documentImportStoreProvider)
        .updateStatus(
          id: current.document.id,
          status: DocumentImportStatus.saved,
        );
    ref.read(pendingDocumentBytesStoreProvider).discard(current.document.id);
    ref.invalidate(dashboardControllerProvider);
    ref.invalidate(documentImportListControllerProvider);
    return saved;
  }
}
