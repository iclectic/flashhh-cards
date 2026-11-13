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

  static const importPdf = '/import';
  static const importNotes = '/import/notes';

  static String draftReview(String importId) => '/import/$importId/review';

  static const quiz = '/quiz';

  static String quizDeck(String deckId) => '/quiz?deckId=$deckId';

  static String quizAttempt(String attemptId) => '/quiz/$attemptId';

  static const insights = '/insights';
}
