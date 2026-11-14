# Flashhh

Local-first flashcard app for exams, interviews, and serious study. Decks, cards, SM-2 study, PDF/notes import, human-approved AI drafts, optional email account linking, a sync outbox, offline quizzes, insights, advanced study, Phase 10 hardening, and store polish (branded icons/splash, optional crash ingest, CI) ship through Phases 1–14. Cloud sync transport and Google/Apple auth follow — see [docs/architecture.md](docs/architecture.md) and [docs/product-roadmap.md](docs/product-roadmap.md).

Flutter 3.47+ stable / Dart 3.13+. Package name `flashhh_cards`. Application id `com.flashhh.flashhh_cards`.

## Run the app

```bash
flutter pub get
flutter run
```

Configuration is compile-time only. There is no API key in the mobile app.

```bash
flutter run \
  --dart-define=APP_ENV=development \
  --dart-define=API_BASE_URL=http://127.0.0.1:8080 \
  --dart-define=MAX_UPLOAD_BYTES=20971520 \
  --dart-define=MAX_GENERATED_CARDS=40 \
  --dart-define=CRASH_INGEST_URL=http://127.0.0.1:8080/v1/diagnostics/crash
```

`APP_ENV` is `development`, `staging`, or `production`. Staging and production require HTTPS. `CRASH_INGEST_URL` is optional.

## Run the API (PDF extract + generation)

```bash
cd backend
npm install
npm start
```

Optional `OPENAI_API_KEY` enables model drafts; without it the API uses a local heuristic. Details in [backend/README.md](backend/README.md).

Paste notes work offline via the on-device heuristic even when the API is down. PDF extraction needs the API.

## Checks

```bash
dart run build_runner build
flutter analyze
flutter test
cd backend && npm test
```

Regenerate Drift and Freezed outputs after changing a table or a `@freezed` model. Generated `*.g.dart` and `*.freezed.dart` files are committed.

## Assumptions

- The first account is a guest on this device. Email linking attaches to that same account rather than blocking the app. Google/Apple need the account service.
- New cards are due immediately; SM-2 updates intervals after grades. Cram mode records reviews without changing the schedule.
- Generated cards stay drafts until a person saves them.
- Local changes can queue in `sync_outbox`; cloud sync transport is not connected yet.
- Web is unsupported until a SQLite WASM setup is added.
