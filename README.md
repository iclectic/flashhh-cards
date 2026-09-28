# Flashhh

Local-first flashcard application. Phase 1 is the project foundation: Material 3 theme, routing, error model, Drift storage, and the contracts for study statistics and document generation. Deck editing, study sessions, PDF import, and the AI backend come in later phases. See [docs/architecture.md](docs/architecture.md).

Flutter 3.47.x stable and Dart 3.13.x. Package name `flashhh_cards`. Application id `com.flashhh.flashhh_cards`.

## Run

```bash
flutter pub get
flutter run
```

Configuration is compile-time only. There is no API key to set.

```bash
flutter run \
  --dart-define=APP_ENV=development \
  --dart-define=API_BASE_URL=http://127.0.0.1:8080 \
  --dart-define=MAX_UPLOAD_BYTES=20971520 \
  --dart-define=MAX_GENERATED_CARDS=40
```

`APP_ENV` is `development`, `staging`, or `production`. Staging and production require HTTPS. The default API host is a placeholder and Phase 1 does not call it.

## Checks

```bash
dart run build_runner build
flutter analyze
flutter test
```

Regenerate Drift and Freezed outputs after changing a table or a `@freezed` model. Generated `*.g.dart` and `*.freezed.dart` files are committed.

## Assumptions

- The first account is a guest on this device. Sign-in will attach to that account later rather than blocking the app.
- Review scheduling columns are reserved for SM-2. The algorithm is not implemented, and new cards are simply due.
- Generated cards stay drafts until a person saves them. That review screen is not built yet.
- Web is unsupported until a SQLite WASM setup is added.
