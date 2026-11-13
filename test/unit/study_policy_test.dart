import 'package:flashhh_cards/features/authentication/domain/user_account.dart';
import 'package:flashhh_cards/features/decks/domain/deck.dart';
import 'package:flashhh_cards/features/flashcards/domain/flashcard.dart';
import 'package:flashhh_cards/features/study/domain/due_policy.dart';
import 'package:flashhh_cards/features/study/domain/streak_calculator.dart';
import 'package:flashhh_cards/features/study/domain/study_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('models round-trip through JSON', () {
    final created = DateTime.utc(2026, 6, 15, 12);
    final user = UserAccount(
      id: 'user-1',
      displayName: 'Guest',
      authProvider: AuthProvider.guest,
      isGuest: true,
      createdAt: created,
    );
    final deck = Deck(
      id: 'deck-1',
      ownerId: user.id,
      name: 'Biology',
      description: '',
      createdAt: created,
      updatedAt: created,
    );
    final card = Flashcard(
      id: 'card-1',
      deckId: deck.id,
      question: 'What is a cell?',
      answer: 'The basic unit of life.',
      createdAt: created,
      updatedAt: created,
      source: FlashcardSource.aiGenerated,
      tags: const ['biology'],
    );
    final review = ReviewResult(
      id: 'review-1',
      sessionId: 'session-1',
      cardId: card.id,
      grade: RecallGrade.good,
      reviewedAt: created,
    );

    expect(UserAccount.fromJson(user.toJson()), user);
    expect(Deck.fromJson(deck.toJson()), deck);
    expect(card.toJson()['source'], 'ai_generated');
    expect(Flashcard.fromJson(card.toJson()), card);
    expect(ReviewResult.fromJson(review.toJson()), review);
  });

  test('due policy treats unscheduled cards as due', () {
    final now = DateTime.utc(2026, 6, 15, 12);
    expect(DuePolicy.isDue(nextReviewAt: null, now: now), isTrue);
    expect(
      DuePolicy.isDue(
        nextReviewAt: now.subtract(const Duration(minutes: 1)),
        now: now,
      ),
      isTrue,
    );
    expect(
      DuePolicy.isDue(nextReviewAt: now.add(const Duration(days: 1)), now: now),
      isFalse,
    );
  });

  test('streak stays alive through today and breaks after a missed day', () {
    const calculator = StreakCalculator();
    final today = DateTime(2026, 6, 15, 12);
    final yesterday = DateTime(2026, 6, 14, 12);
    final twoDaysAgo = DateTime(2026, 6, 13, 12);
    final now = today.toUtc();

    expect(calculator.currentStreak([yesterday.toUtc()], now), 1);
    expect(
      calculator.currentStreak([yesterday.toUtc(), today.toUtc()], now),
      2,
    );
    expect(calculator.currentStreak([twoDaysAgo.toUtc()], now), 0);
    expect(calculator.currentStreak(const [], now), 0);
  });
}
