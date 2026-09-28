import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/analytics/analytics_client.dart';
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
import '../features/authentication/data/local_account_seeder.dart';
import '../features/authentication/domain/user_account.dart';
import '../features/decks/data/drift_deck_repository.dart';
import '../features/decks/domain/deck_repository.dart';
import '../features/flashcards/data/drift_flashcard_repository.dart';
import '../features/flashcards/domain/flashcard_repository.dart';
import '../features/study/data/study_stats_reader.dart';
import 'configuration/app_config.dart';

final appConfigProvider = Provider<AppConfig>(
  (ref) => AppConfig.fromEnvironment(),
);

final appLoggerProvider = Provider<AppLogger>(
  (ref) => const DeveloperAppLogger(),
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

final deckRepositoryProvider = Provider<DeckRepository>((ref) {
  return DriftDeckRepository(
    database: ref.watch(appDatabaseProvider),
    ids: ref.watch(idGeneratorProvider),
    clock: ref.watch(clockProvider),
    logger: ref.watch(appLoggerProvider),
  );
});

final flashcardRepositoryProvider = Provider<FlashcardRepository>((ref) {
  return DriftFlashcardRepository(
    database: ref.watch(appDatabaseProvider),
    ids: ref.watch(idGeneratorProvider),
    clock: ref.watch(clockProvider),
    logger: ref.watch(appLoggerProvider),
  );
});

final studyStatsReaderProvider = Provider<StudyStatsReader>((ref) {
  return StudyStatsReader(
    database: ref.watch(appDatabaseProvider),
    logger: ref.watch(appLoggerProvider),
  );
});

final localAccountProvider = FutureProvider<UserAccount>((ref) {
  return LocalAccountSeeder(
    database: ref.watch(appDatabaseProvider),
    ids: ref.watch(idGeneratorProvider),
    clock: ref.watch(clockProvider),
    logger: ref.watch(appLoggerProvider),
  ).ensureGuestAccount();
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

final generationUsageStoreProvider = Provider<GenerationUsageStore>((ref) {
  return DriftGenerationUsageStore(
    database: ref.watch(appDatabaseProvider),
    logger: ref.watch(appLoggerProvider),
  );
});
