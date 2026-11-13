import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../../../core/storage/database/app_database.dart';
import '../../../core/utilities/app_logger.dart';
import '../../../core/utilities/database_guard.dart';

abstract interface class PreferencesRepository {
  Stream<bool> watchOnboardingCompleted();

  Future<void> setOnboardingCompleted({required bool completed});

  Stream<ThemeMode> watchThemeMode();

  Future<void> setThemeMode(ThemeMode mode);
}

final class DriftPreferencesRepository implements PreferencesRepository {
  DriftPreferencesRepository(this._database, this._logger);

  final AppDatabase _database;
  final AppLogger _logger;
  static const _rowId = 1;

  @override
  Stream<bool> watchOnboardingCompleted() {
    return _watch().map((row) => row.hasCompletedOnboarding);
  }

  @override
  Future<void> setOnboardingCompleted({required bool completed}) {
    return runDatabase(
      logger: _logger,
      message: 'Your preferences could not be saved on this device.',
      action: () async {
        await _ensure();
        await (_database.update(
          _database.appPreferences,
        )..where((row) => row.id.equals(_rowId))).write(
          AppPreferencesCompanion(hasCompletedOnboarding: Value(completed)),
        );
      },
    );
  }

  @override
  Stream<ThemeMode> watchThemeMode() {
    return _watch().map((row) => _themeMode(row.themeMode));
  }

  @override
  Future<void> setThemeMode(ThemeMode mode) {
    return runDatabase(
      logger: _logger,
      message: 'Your preferences could not be saved on this device.',
      action: () async {
        await _ensure();
        await (_database.update(_database.appPreferences)
              ..where((row) => row.id.equals(_rowId)))
            .write(AppPreferencesCompanion(themeMode: Value(mode.name)));
      },
    );
  }

  Stream<AppPreferenceRow> _watch() async* {
    await _ensure();
    yield* (_database.select(
      _database.appPreferences,
    )..where((row) => row.id.equals(_rowId))).watchSingle();
  }

  Future<void> _ensure() {
    return _database
        .into(_database.appPreferences)
        .insert(
          AppPreferencesCompanion.insert(id: const Value(_rowId)),
          mode: InsertMode.insertOrIgnore,
        );
  }

  ThemeMode _themeMode(String value) {
    for (final mode in ThemeMode.values) {
      if (mode.name == value) {
        return mode;
      }
    }
    _logger.warning('Unknown theme mode "$value". Using system.');
    return ThemeMode.system;
  }
}
