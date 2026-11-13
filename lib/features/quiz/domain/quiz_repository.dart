import '../../flashcards/domain/flashcard.dart';
import 'quiz_models.dart';

abstract interface class QuizRepository {
  Future<List<Flashcard>> loadCardsForQuiz({
    required String deckId,
    int limit = 200,
  });

  Future<QuizAttempt> startAttempt({
    required String? deckId,
    required QuizQuestionStyle questionStyle,
    required int questionCount,
    int? timedSeconds,
  });

  Future<QuizAttempt?> findAttempt(String id);

  Future<QuizAnswer> recordAnswer({
    required String attemptId,
    required QuizQuestion question,
    required String? givenAnswer,
    int? elapsedMilliseconds,
  });

  Future<QuizAttempt> completeAttempt(String attemptId);

  Future<QuizAttemptSummary> loadSummary(String attemptId);

  Future<List<QuizAttempt>> listRecentAttempts({int limit = 20});
}
