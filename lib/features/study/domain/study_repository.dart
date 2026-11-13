import '../../flashcards/domain/flashcard.dart';
import 'study_models.dart';

abstract interface class StudyRepository {
  /// Due cards for a deck, or every living deck when [deckId] is null.
  Future<List<Flashcard>> loadDueCards({
    String? deckId,
    required DateTime now,
    int limit = 50,
  });

  Future<StudySession> startSession({String? deckId});

  Future<StudySession?> findSession(String id);

  /// Grades one card, updates SM-2 fields, and appends a review row.
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
