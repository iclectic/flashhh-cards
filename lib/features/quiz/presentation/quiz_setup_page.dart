import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/dependencies.dart';
import '../../../app/router/app_routes.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/analytics/analytics_event.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/validation/field_limits.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../core/widgets/error_state_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../core/widgets/responsive_content.dart';
import '../../decks/domain/deck.dart';
import '../domain/pending_quiz_session.dart';
import '../domain/quiz_models.dart';
import '../domain/quiz_question_builder.dart';

final quizSetupDecksProvider = FutureProvider.autoDispose<List<Deck>>((
  ref,
) async {
  final account = await ref.watch(localAccountProvider.future);
  return ref.watch(deckRepositoryProvider).listDecks(ownerId: account.id);
});

final quizHistoryProvider = FutureProvider.autoDispose<List<QuizAttempt>>((
  ref,
) {
  return ref.watch(quizRepositoryProvider).listRecentAttempts();
});

class QuizSetupPage extends ConsumerStatefulWidget {
  const QuizSetupPage({this.deckId, super.key});

  final String? deckId;

  @override
  ConsumerState<QuizSetupPage> createState() => _QuizSetupPageState();
}

class _QuizSetupPageState extends ConsumerState<QuizSetupPage> {
  String? _deckId;
  var _count = FieldLimits.quizQuestionDefault;
  var _style = QuizQuestionStyle.mixed;
  var _timed = false;
  var _timedMinutes = 5;
  var _starting = false;

  @override
  void initState() {
    super.initState();
    _deckId = widget.deckId;
  }

  @override
  Widget build(BuildContext context) {
    final decksAsync = ref.watch(quizSetupDecksProvider);
    final historyAsync = ref.watch(quizHistoryProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: switch (decksAsync) {
        AsyncLoading() => const LoadingView(label: 'Loading decks'),
        AsyncError(:final error) => ErrorStateView(
          message: failureFor(error).message,
          onRetry: () => ref.invalidate(quizSetupDecksProvider),
        ),
        AsyncData(:final value) => ResponsiveContent(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Text(
                'Prove what you know',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Quizzes are separate from spaced review. Results are stored on '
                'this device.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              if (value.isEmpty)
                EmptyStateView(
                  title: 'No decks to quiz',
                  message: 'Create a deck with cards first.',
                  icon: Icons.quiz_outlined,
                  actionLabel: 'Create deck',
                  onAction: () => context.push(AppRoutes.deckNew),
                )
              else ...[
                DropdownMenu<String>(
                  initialSelection: _deckId ?? value.first.id,
                  label: const Text('Deck'),
                  expandedInsets: EdgeInsets.zero,
                  onSelected: (id) => setState(() => _deckId = id),
                  dropdownMenuEntries: [
                    for (final deck in value)
                      DropdownMenuEntry(
                        value: deck.id,
                        label: '${deck.name} (${deck.cardCount})',
                        enabled: deck.cardCount > 0,
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Text('Questions: $_count'),
                Slider(
                  value: _count.toDouble(),
                  min: 1,
                  max: FieldLimits.quizQuestionMax.toDouble(),
                  divisions: FieldLimits.quizQuestionMax - 1,
                  label: '$_count',
                  onChanged: (value) =>
                      setState(() => _count = value.round()),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text('Question style', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  children: [
                    for (final style in QuizQuestionStyle.values)
                      ChoiceChip(
                        label: Text(_styleLabel(style)),
                        selected: _style == style,
                        onSelected: (_) => setState(() => _style = style),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Timed exam'),
                  subtitle: Text(
                    _timed
                        ? '$_timedMinutes minute limit for the whole quiz'
                        : 'No countdown',
                  ),
                  value: _timed,
                  onChanged: (value) => setState(() => _timed = value),
                ),
                if (_timed) ...[
                  Text('Minutes: $_timedMinutes'),
                  Slider(
                    value: _timedMinutes.toDouble(),
                    min: 1,
                    max: FieldLimits.quizTimedMinutesMax.toDouble(),
                    divisions: FieldLimits.quizTimedMinutesMax - 1,
                    label: '$_timedMinutes',
                    onChanged: (value) =>
                        setState(() => _timedMinutes = value.round()),
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                FilledButton.icon(
                  onPressed: _starting ? null : () => _start(value),
                  icon: const Icon(Icons.play_arrow),
                  label: Text(_starting ? 'Starting…' : 'Start quiz'),
                ),
              ],
              const SizedBox(height: AppSpacing.xl),
              Text('Recent results', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              switch (historyAsync) {
                AsyncLoading() => const Text('Loading history…'),
                AsyncError(:final error) => Text(failureFor(error).message),
                AsyncData(:final value) when value.isEmpty => const Text(
                  'No quizzes yet.',
                ),
                AsyncData(:final value) => Column(
                  children: [
                    for (final attempt in value)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          attempt.completedAt == null
                              ? Icons.hourglass_empty
                              : Icons.fact_check_outlined,
                        ),
                        title: Text(
                          '${attempt.correctCount}/${attempt.questionCount} correct',
                        ),
                        subtitle: Text(_historySubtitle(attempt)),
                        onTap: attempt.completedAt == null
                            ? null
                            : () => context.push(
                                AppRoutes.quizAttempt(attempt.id),
                              ),
                      ),
                  ],
                ),
              },
            ],
          ),
        ),
      },
    );
  }

  Future<void> _start(List<Deck> decks) async {
    final deckId = _deckId ?? decks.first.id;
    final deck = decks.where((item) => item.id == deckId).firstOrNull;
    if (deck == null || deck.cardCount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Choose a deck that has cards.')),
      );
      return;
    }
    setState(() => _starting = true);
    try {
      final quiz = ref.read(quizRepositoryProvider);
      final cards = await quiz.loadCardsForQuiz(deckId: deckId);
      final questions = QuizQuestionBuilder(
        random: ref.read(quizRandomProvider),
      ).build(cards: cards, count: _count, style: _style);
      if (questions.isEmpty) {
        throw const ValidationException(
          message: 'Could not build quiz questions from this deck.',
        );
      }
      final timedSeconds = _timed ? _timedMinutes * 60 : null;
      final attempt = await quiz.startAttempt(
        deckId: deckId,
        questionStyle: _style,
        questionCount: questions.length,
        timedSeconds: timedSeconds,
      );
      final now = ref.read(clockProvider).now();
      ref
          .read(pendingQuizSessionStoreProvider)
          .put(
            PendingQuizSession(
              attempt: attempt,
              questions: questions,
              deadline: timedSeconds == null
                  ? null
                  : now.add(Duration(seconds: timedSeconds)),
            ),
          );
      await ref.read(analyticsClientProvider).track(
        AnalyticsEvent.quizStarted,
        properties: {
          'style': _style.name,
          'count': questions.length,
          'timed': timedSeconds != null,
        },
      );
      if (!mounted) {
        return;
      }
      await context.push(AppRoutes.quizAttempt(attempt.id));
      ref.invalidate(quizHistoryProvider);
    } on AppException catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(failureFor(error).message)));
    } finally {
      if (mounted) {
        setState(() => _starting = false);
      }
    }
  }

  String _styleLabel(QuizQuestionStyle style) {
    return switch (style) {
      QuizQuestionStyle.mcq => 'Multiple choice',
      QuizQuestionStyle.shortAnswer => 'Short answer',
      QuizQuestionStyle.mixed => 'Mixed',
    };
  }

  String _historySubtitle(QuizAttempt attempt) {
    final style = _styleLabel(attempt.questionStyle);
    final timed = attempt.timedSeconds == null ? 'untimed' : 'timed';
    return '$style · $timed';
  }
}
