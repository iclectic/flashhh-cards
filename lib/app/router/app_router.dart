import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/ai_generation/domain/ai_models.dart';
import '../../features/ai_generation/presentation/document_import_page.dart';
import '../../features/ai_generation/presentation/draft_review_controller.dart';
import '../../features/ai_generation/presentation/draft_review_page.dart';
import '../../features/ai_generation/presentation/notes_import_page.dart';
import '../../features/decks/presentation/deck_detail_page.dart';
import '../../features/decks/presentation/deck_form_page.dart';
import '../../features/decks/presentation/deck_list_page.dart';
import '../../features/flashcards/presentation/flashcard_form_page.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/home/presentation/splash_page.dart';
import '../../features/onboarding/presentation/onboarding_page.dart';
import '../../features/insights/presentation/insights_page.dart';
import '../../features/quiz/presentation/quiz_session_page.dart';
import '../../features/quiz/presentation/quiz_setup_page.dart';
import '../../features/settings/presentation/settings_page.dart';
import '../../features/study/presentation/study_session_page.dart';
import '../dependencies.dart';
import 'app_routes.dart';

/// Keeps onboarding in front of the rest of the app until it is finished.
/// Paths are the deep-link surface for later deck and study routes.
String? redirectFor({
  required AsyncValue<bool> onboarding,
  required String location,
}) {
  if (onboarding.isLoading || onboarding.hasError) {
    return location == AppRoutes.splash ? null : AppRoutes.splash;
  }
  final completed = onboarding.value ?? false;
  final atOnboarding = location == AppRoutes.onboarding;
  final atSplash = location == AppRoutes.splash;
  if (!completed) {
    return atOnboarding ? null : AppRoutes.onboarding;
  }
  if (atOnboarding || atSplash) {
    return AppRoutes.home;
  }
  return null;
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final refresh = _RouterRefresh(ref);
  ref.onDispose(refresh.dispose);
  final router = GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: refresh,
    redirect: (context, state) {
      return redirectFor(
        onboarding: ref.read(onboardingStatusProvider),
        location: state.matchedLocation,
      );
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: AppRoutes.insights,
        builder: (context, state) => const InsightsPage(),
      ),
      GoRoute(
        path: AppRoutes.study,
        builder: (context, state) {
          return StudySessionPage(
            args: AppRoutes.studyArgsFrom(
              query: state.uri.queryParameters,
            ),
          );
        },
        routes: [
          GoRoute(
            path: ':deckId',
            builder: (context, state) {
              final deckId = state.pathParameters['deckId'];
              return StudySessionPage(
                args: AppRoutes.studyArgsFrom(
                  deckId: deckId,
                  query: state.uri.queryParameters,
                ),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.quiz,
        builder: (context, state) {
          final deckId = state.uri.queryParameters['deckId'];
          return QuizSetupPage(deckId: deckId);
        },
        routes: [
          GoRoute(
            path: ':attemptId',
            builder: (context, state) {
              final attemptId = state.pathParameters['attemptId']!;
              return QuizSessionPage(attemptId: attemptId);
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.importPdf,
        builder: (context, state) => const DocumentImportPage(),
      ),
      GoRoute(
        path: AppRoutes.importNotes,
        builder: (context, state) => const NotesImportPage(),
      ),
      GoRoute(
        path: '/import/:importId/review',
        builder: (context, state) {
          final importId = state.pathParameters['importId']!;
          final extra = state.extra;
          Map<String, Object?>? map;
          if (extra is Map<String, Object?>) {
            map = extra;
          } else if (extra is Map) {
            map = extra.map(
              (key, value) => MapEntry(key.toString(), value),
            );
          }
          final difficultyName = map?['difficulty'] as String?;
          final styleName = map?['questionStyle'] as String?;
          return DraftReviewPage(
            args: DraftReviewArgs(
              documentImportId: importId,
              notes: map?['notes'] as String?,
              desiredCount: map?['desiredCount'] as int? ?? 12,
              difficulty: GenerationDifficulty.values.firstWhere(
                (value) => value.name == difficultyName,
                orElse: () => GenerationDifficulty.intermediate,
              ),
              questionStyle: QuestionStyle.values.firstWhere(
                (value) => value.name == styleName,
                orElse: () => QuestionStyle.mixed,
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.decks,
        builder: (context, state) => const DeckListPage(),
        routes: [
          GoRoute(
            path: 'new',
            builder: (context, state) => const DeckFormPage(),
          ),
          GoRoute(
            path: ':deckId',
            builder: (context, state) {
              final deckId = state.pathParameters['deckId']!;
              return DeckDetailPage(deckId: deckId);
            },
            routes: [
              GoRoute(
                path: 'edit',
                builder: (context, state) {
                  final deckId = state.pathParameters['deckId']!;
                  return DeckFormPage(deckId: deckId);
                },
              ),
              GoRoute(
                path: 'cards/new',
                builder: (context, state) {
                  final deckId = state.pathParameters['deckId']!;
                  return FlashcardFormPage(deckId: deckId);
                },
              ),
              GoRoute(
                path: 'cards/:cardId/edit',
                builder: (context, state) {
                  final deckId = state.pathParameters['deckId']!;
                  final cardId = state.pathParameters['cardId']!;
                  return FlashcardFormPage(deckId: deckId, cardId: cardId);
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

final class _RouterRefresh extends ChangeNotifier {
  _RouterRefresh(Ref ref) {
    _subscription = ref.listen(onboardingStatusProvider, (previous, next) {
      notifyListeners();
    });
  }

  late final ProviderSubscription<AsyncValue<bool>> _subscription;

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}
