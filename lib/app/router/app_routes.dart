import '../../features/study/domain/study_models.dart';

abstract final class AppRoutes {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const home = '/';
  static const settings = '/settings';
  static const decks = '/decks';
  static const deckNew = '/decks/new';

  static String deck(String id) => '/decks/$id';

  static String deckEdit(String id) => '/decks/$id/edit';

  static String cardNew(String deckId) => '/decks/$deckId/cards/new';

  static String cardEdit(String deckId, String cardId) =>
      '/decks/$deckId/cards/$cardId/edit';

  static const study = '/study';

  static String studyDeck(String deckId) => '/study/$deckId';

  /// Study or cram entry with optional typed-answer check.
  static String studyPath({
    String? deckId,
    StudySessionMode mode = StudySessionMode.review,
    bool typedAnswer = false,
  }) {
    final base = deckId == null ? study : studyDeck(deckId);
    final params = <String>[];
    if (mode == StudySessionMode.cram) {
      params.add('mode=cram');
    }
    if (typedAnswer) {
      params.add('typed=1');
    }
    if (params.isEmpty) {
      return base;
    }
    return '$base?${params.join('&')}';
  }

  static StudySessionArgs studyArgsFrom({
    String? deckId,
    required Map<String, String> query,
  }) {
    final modeName = query['mode'];
    final mode = modeName == StudySessionMode.cram.name
        ? StudySessionMode.cram
        : StudySessionMode.review;
    final typed =
        query['typed'] == '1' || query['typed']?.toLowerCase() == 'true';
    return StudySessionArgs(
      deckId: deckId,
      mode: mode,
      typedAnswer: typed,
    );
  }

  static const importPdf = '/import';
  static const importNotes = '/import/notes';

  static String draftReview(String importId) => '/import/$importId/review';

  static const quiz = '/quiz';

  static String quizDeck(String deckId) => '/quiz?deckId=$deckId';

  static String quizAttempt(String attemptId) => '/quiz/$attemptId';

  static const insights = '/insights';
}
