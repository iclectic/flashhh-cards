import '../../flashcards/domain/flashcard.dart';
import 'study_models.dart';

abstract interface class StudyRepository {
  /// Due cards for a deck, or every living deck when [deckId] is null.
  Future<List<Flashcard>> loadDueCards({
    String? deckId,
    required DateTime now,
    int limit = 50,
  });

  /// Queue for a sitting. [StudySessionMode.review] uses due cards;
  /// [StudySessionMode.cram] loads living cards and ignores the schedule.
  Future<List<Flashcard>> loadStudyQueue({
    String? deckId,
    required DateTime now,
    StudySessionMode mode = StudySessionMode.review,
    int limit = 50,
  });

  Future<StudySession> startSession({
    String? deckId,
    StudySessionMode mode = StudySessionMode.review,
  });

  Future<StudySession?> findSession(String id);

  /// Grades one card. Review mode updates SM-2; cram only records the review.
  Future<GradedReview> gradeCard({
    required String sessionId,
    required String cardId,
    required RecallGrade grade,
    int? elapsedMilliseconds,
  });

  Future<StudySession> completeSession(String sessionId);
}

final class GradedReview {
  const GradedReview({
    required this.session,
    required this.result,
    required this.card,
  });

  final StudySession session;
  final ReviewResult result;
  final Flashcard card;
}
