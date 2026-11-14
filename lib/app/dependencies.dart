import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/analytics/analytics_client.dart';
import '../core/diagnostics/crash_reporter.dart';
import '../core/networking/api_client.dart';
import '../core/storage/database/app_database.dart';
import '../core/storage/preferences/preferences_repository.dart';
import '../core/storage/secure/flutter_secure_store.dart';
import '../core/storage/secure/secure_store.dart';
import '../core/utilities/app_logger.dart';
import '../core/utilities/clock.dart';
import '../core/utilities/id_generator.dart';
import '../features/ai_generation/data/drift_document_import_store.dart';
import '../features/ai_generation/data/drift_generation_usage_store.dart';
import '../features/ai_generation/data/file_picker_document_picker.dart';
import '../features/ai_generation/data/http_ai_clients.dart';
import '../features/ai_generation/domain/ai_flashcard_generator.dart';
import '../features/ai_generation/domain/document_picker.dart';
import '../features/ai_generation/domain/generation_pipeline.dart';
import '../features/ai_generation/domain/heuristic_flashcard_generator.dart';
import '../features/ai_generation/domain/pending_document_bytes.dart';
import '../features/authentication/data/drift_account_repository.dart';
import '../features/authentication/data/local_auth_service.dart';
import '../features/authentication/data/secure_auth_session_store.dart';
import '../features/authentication/domain/account_repository.dart';
import '../features/authentication/domain/auth_service.dart';
import '../features/authentication/domain/user_account.dart';
import '../features/decks/data/drift_deck_repository.dart';
import '../features/decks/domain/deck_repository.dart';
import '../features/flashcards/data/drift_flashcard_repository.dart';
import '../features/flashcards/domain/flashcard_repository.dart';
import '../features/study/data/drift_study_repository.dart';
import '../features/study/data/study_stats_reader.dart';
import '../features/study/domain/study_repository.dart';
import '../features/insights/data/insights_reader.dart';
import '../features/quiz/data/drift_quiz_repository.dart';
import '../features/quiz/domain/pending_quiz_session.dart';
import '../features/quiz/domain/quiz_repository.dart';
import '../features/sync/data/drift_sync_outbox_repository.dart';
import '../features/sync/domain/sync_outbox_repository.dart';
import 'configuration/app_config.dart';

final appConfigProvider = Provider<AppConfig>(
  (ref) => AppConfig.fromEnvironment(),
);

final appLoggerProvider = Provider<AppLogger>(
  (ref) => const DeveloperAppLogger(),
);

final crashReporterProvider = Provider<CrashReporter>(
  (ref) => LoggingCrashReporter(ref.watch(appLoggerProvider)),
);

final clockProvider = Provider<Clock>((ref) => const SystemClock());

final idGeneratorProvider = Provider<IdGenerator>((ref) => UuidIdGenerator());

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase.open();
  ref.onDispose(database.close);
  return database;
});

final secureStoreProvider = Provider<SecureStore>(
  (ref) => FlutterSecureStore(),
);

final analyticsClientProvider = Provider<AnalyticsClient>((ref) {
  if (kReleaseMode) {
    return const NoOpAnalyticsClient();
  }
  return LoggingAnalyticsClient(ref.watch(appLoggerProvider));
});

final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(appConfigProvider);
  final base = config.apiBaseUrl.toString();
  final dio = Dio(
    BaseOptions(
      baseUrl: base.endsWith('/') ? base : '$base/',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      headers: const {'Accept': 'application/json'},
    ),
  );
  ref.onDispose(dio.close);
  return dio;
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return DioApiClient(
    dio: ref.watch(dioProvider),
    config: ref.watch(appConfigProvider),
    logger: ref.watch(appLoggerProvider),
  );
});

final preferencesRepositoryProvider = Provider<PreferencesRepository>((ref) {
  return DriftPreferencesRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(appLoggerProvider),
  );
});

final onboardingStatusProvider = StreamProvider<bool>((ref) {
  return ref.watch(preferencesRepositoryProvider).watchOnboardingCompleted();
});

final themeModeProvider = StreamProvider<ThemeMode>((ref) {
  return ref.watch(preferencesRepositoryProvider).watchThemeMode();
});

final syncOutboxRepositoryProvider = Provider<SyncOutboxRepository>((ref) {
  return DriftSyncOutboxRepository(
    database: ref.watch(appDatabaseProvider),
    ids: ref.watch(idGeneratorProvider),
    clock: ref.watch(clockProvider),
    logger: ref.watch(appLoggerProvider),
  );
});

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  return DriftAccountRepository(
    database: ref.watch(appDatabaseProvider),
    ids: ref.watch(idGeneratorProvider),
    clock: ref.watch(clockProvider),
    logger: ref.watch(appLoggerProvider),
    syncOutbox: ref.watch(syncOutboxRepositoryProvider),
  );
});

final authSessionStoreProvider = Provider<SecureAuthSessionStore>((ref) {
  return SecureAuthSessionStore(
    secureStore: ref.watch(secureStoreProvider),
    logger: ref.watch(appLoggerProvider),
  );
});

final authServiceProvider = Provider<AuthService>((ref) {
  return LocalAuthService(
    accounts: ref.watch(accountRepositoryProvider),
    sessions: ref.watch(authSessionStoreProvider),
    ids: ref.watch(idGeneratorProvider),
    clock: ref.watch(clockProvider),
    analytics: ref.watch(analyticsClientProvider),
  );
});

final deckRepositoryProvider = Provider<DeckRepository>((ref) {
  return DriftDeckRepository(
    database: ref.watch(appDatabaseProvider),
    ids: ref.watch(idGeneratorProvider),
    clock: ref.watch(clockProvider),
    logger: ref.watch(appLoggerProvider),
    syncOutbox: ref.watch(syncOutboxRepositoryProvider),
    analytics: ref.watch(analyticsClientProvider),
  );
});

final flashcardRepositoryProvider = Provider<FlashcardRepository>((ref) {
  return DriftFlashcardRepository(
    database: ref.watch(appDatabaseProvider),
    ids: ref.watch(idGeneratorProvider),
    clock: ref.watch(clockProvider),
    logger: ref.watch(appLoggerProvider),
    syncOutbox: ref.watch(syncOutboxRepositoryProvider),
    analytics: ref.watch(analyticsClientProvider),
  );
});

final studyStatsReaderProvider = Provider<StudyStatsReader>((ref) {
  return StudyStatsReader(
    database: ref.watch(appDatabaseProvider),
    logger: ref.watch(appLoggerProvider),
  );
});

final insightsReaderProvider = Provider<InsightsReader>((ref) {
  return InsightsReader(
    database: ref.watch(appDatabaseProvider),
    logger: ref.watch(appLoggerProvider),
  );
});

final studyRepositoryProvider = Provider<StudyRepository>((ref) {
  return DriftStudyRepository(
    database: ref.watch(appDatabaseProvider),
    ids: ref.watch(idGeneratorProvider),
    clock: ref.watch(clockProvider),
    logger: ref.watch(appLoggerProvider),
  );
});

final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  return DriftQuizRepository(
    database: ref.watch(appDatabaseProvider),
    ids: ref.watch(idGeneratorProvider),
    clock: ref.watch(clockProvider),
    logger: ref.watch(appLoggerProvider),
  );
});

final pendingQuizSessionStoreProvider = Provider<PendingQuizSessionStore>((
  ref,
) {
  return PendingQuizSessionStore();
});

final quizRandomProvider = Provider<Random>((ref) => Random());

final localAccountProvider = FutureProvider<UserAccount>((ref) {
  return ref.watch(accountRepositoryProvider).ensureLocalAccount();
});

final documentImportStoreProvider = Provider<DocumentImportStore>((ref) {
  return DriftDocumentImportStore(
    database: ref.watch(appDatabaseProvider),
    ids: ref.watch(idGeneratorProvider),
    clock: ref.watch(clockProvider),
    logger: ref.watch(appLoggerProvider),
    config: ref.watch(appConfigProvider),
  );
});

final documentPickerProvider = Provider<DocumentPicker>((ref) {
  return FilePickerDocumentPicker();
});

final pendingDocumentBytesStoreProvider = Provider<PendingDocumentBytesStore>((
  ref,
) {
  return InMemoryPendingDocumentBytesStore();
});

final heuristicAiFlashcardGeneratorProvider =
    Provider<HeuristicAiFlashcardGenerator>((ref) {
      return HeuristicAiFlashcardGenerator(
        maxCards: ref.watch(appConfigProvider).maxGeneratedCards,
      );
    });

final httpDocumentTextExtractorProvider = Provider<HttpDocumentTextExtractor>((
  ref,
) {
  return HttpDocumentTextExtractor(
    dio: ref.watch(dioProvider),
    config: ref.watch(appConfigProvider),
    logger: ref.watch(appLoggerProvider),
  );
});

final aiFlashcardGeneratorProvider = Provider<AiFlashcardGenerator>((ref) {
  return HttpAiFlashcardGenerator(
    api: ref.watch(apiClientProvider),
    config: ref.watch(appConfigProvider),
  );
});

final generationPipelineProvider = Provider<GenerationPipeline>((ref) {
  final heuristic = ref.watch(heuristicAiFlashcardGeneratorProvider);
  return GenerationPipeline(
    generator: ref.watch(aiFlashcardGeneratorProvider),
    fallbackGenerator: heuristic,
    pendingBytes: ref.watch(pendingDocumentBytesStoreProvider),
    config: ref.watch(appConfigProvider),
    uploader: ref.watch(httpDocumentTextExtractorProvider),
  );
});

final generationUsageStoreProvider = Provider<GenerationUsageStore>((ref) {
  return DriftGenerationUsageStore(
    database: ref.watch(appDatabaseProvider),
    logger: ref.watch(appLoggerProvider),
  );
});
