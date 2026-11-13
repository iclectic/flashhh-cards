import 'quiz_models.dart';

/// In-memory quiz queue for an active attempt. Not written to SQLite.
final class PendingQuizSession {
  const PendingQuizSession({
    required this.attempt,
    required this.questions,
    this.deadline,
  });

  final QuizAttempt attempt;
  final List<QuizQuestion> questions;
  final DateTime? deadline;
}

final class PendingQuizSessionStore {
  final Map<String, PendingQuizSession> _sessions = {};

  void put(PendingQuizSession session) {
    _sessions[session.attempt.id] = session;
  }

  PendingQuizSession? take(String attemptId) => _sessions.remove(attemptId);

  PendingQuizSession? peek(String attemptId) => _sessions[attemptId];

  void clear(String attemptId) => _sessions.remove(attemptId);
}
