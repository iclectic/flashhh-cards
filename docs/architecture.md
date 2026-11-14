# Flashhh architecture

Flashhh is a local-first flashcard application. Phases 1–14 cover foundation through advanced study plus Phase 10 hardening (a11y, pagination, offline banner, privacy, crash seam). Google/Apple providers, cloud sync transport, and branded store assets are not finished yet. The product vision and later phases live in [product-roadmap.md](product-roadmap.md).

## What already existed

The repository contained only a title in `README.md`. There was no Flutter project, no architecture, and no application code. This document is the architecture that Phase 1 established.

## Decisions

- Feature-first layout. A feature gets `domain`, `data`, and `presentation` only when that feature has something real in that layer.
- Riverpod is the composition root (`lib/app/dependencies.dart`). Providers are written by hand. `riverpod_generator` was skipped so the graph stays readable next to the Freezed and Drift generators that already run.
- Drift (SQLite) is the offline store. Repository interfaces stay free of Drift types so a sync implementation can sit beside the local one later.
- The app opens on a local guest account. Authentication must not block someone from creating decks. Email linking upgrades that same UUID row; Google/Apple wait on the account service.
- Identifiers are UUID v4. Timestamps stored in the database are UTC. “Today” and streaks use the device’s local calendar.
- Decks and cards are soft-deleted (`deletedAt`) so a future sync can propagate deletions. `cardCount` is computed from living cards.
- Scheduling columns exist so a spaced-repetition algorithm can be added without a redesign. No scheduler writes them yet. Ease is stored as integer thousandths (`easeFactorMillis`, default 2500) and exposed as `easeFactor` 2.5. That matches SM-2. FSRS would be a later schema migration if we choose it over SM-2.
- The client never holds an AI provider key. `HttpAiFlashcardGenerator` and `HttpDocumentTextExtractor` call the Flashhh API. `HeuristicAiFlashcardGenerator` drafts cards on-device when the API is unreachable (notes path).
- Web is not a supported runtime until SQLite WASM assets are added. `AppDatabase.open()` uses the native application-support directory.

## Folder structure

```
lib/
  app/                  composition: config, theme, router, providers
  core/
    analytics/          provider-neutral event interface
    errors/             AppException and user-facing AppFailure
    networking/         HTTPS API client, no embedded secrets
    storage/            Drift database, preferences, secure token store
    utilities/          clock, ids, logging, database guard
    validation/         shared length and text rules
    widgets/            loading, empty, error, dialog, responsive shell
  features/
    authentication/     guest account, email link, secure session store
    decks/              deck model, validation, repository, list/detail/form UI
    flashcards/         card model, validation, repository, form + deck card list
    study/              due policy, streak, SM-2, session repo, study UI
    ai_generation/      import, HTTP + heuristic generation, draft review
    sync/               outbox queue for future cloud sync
    quiz/               exam-mode quizzes, attempts, answers
    insights/           weak tags/cards, calendar, retention, next actions
backend/                Express extract + generate API (optional OpenAI)
    onboarding/
    home/
    settings/
```

## Models

| Model | Role |
| --- | --- |
| `UserAccount` | Local owner. `AuthProvider` is `guest`, `email`, `google`, or `apple`. |
| `AuthSession` | Access/refresh tokens kept in secure storage, never SQLite. |
| `SyncOutboxEntry` | Pending upsert/delete for a future sync endpoint. |
| `QuizAttempt` / `QuizAnswer` | Exam-mode sitting and each scored response. |
| `Deck` | Name, description, owner, timestamps, computed `cardCount`. |
| `Flashcard` | Question, answer, tags, difficulty, source (`manual`, `pdf`, `ai_generated`), review counters, SM-2 fields. |
| `StudySession` / `ReviewResult` | A sitting and one graded recall (`again`, `hard`, `good`, `easy`). |
| `DeckProgress` / `DashboardSnapshot` | Due today, studied today, streak, per-deck progress. |
| `DocumentImport` | Metadata only. File bytes are not stored. |
| `GenerationUsageRecord` | Generations, document size, tokens, estimated cost, failures. |
| `GeneratedFlashcardDraft` | Untrusted model output after validation. |

JSON uses camelCase. Multi-word enums use snake_case on the wire (`ai_generated`) and `.name` in SQLite (`aiGenerated`).

## AI and PDF pipeline

The Flutter app selects and validates a PDF (or accepts pasted notes), keeps bytes only in an in-memory pending store, then runs `GenerationPipeline`. PDFs upload to the backend for extraction; notes chunk on-device. Generation prefers the HTTPS API and falls back to the local heuristic.

```
PDF or notes
  → validate on the device
  → pending bytes in memory (never SQLite)
  → PDF: POST /v1/documents/extract
  → notes: chunk locally
  → POST /v1/flashcards/generate (or heuristic fallback)
  → client validator drops junk
  → draft review: edit / remove
  → save into a chosen deck (source = pdf | ai_generated)
```

Generation settings: card count, difficulty (`beginner`, `intermediate`, `advanced`), and style (`factual_recall`, `conceptual_understanding`, `mixed`). The response must be a `flashcards` array of objects with question, answer, difficulty, and an optional source reference. The client validator drops empty, oversized, duplicate, and unknown-difficulty cards. Drafts are never auto-saved into a deck.

Uploaded bytes are temporary. After save or discard, pending bytes are cleared. `DocumentImport` rows store metadata only.

## Flutter and the backend

| Flutter | Backend |
| --- | --- |
| Decks, cards, study, statistics, settings | PDF text extraction and OCR |
| Offline reads and writes | Prompting, structured output, deduplication |
| Review of generated drafts | Provider credentials |
| Document size and type checks before upload | Auth on generation routes, rate limits, usage accounting |
| Secure storage for future session tokens | Deleting temporary files after the job |

The default base URL is `https://api.flashhh.app`. Override with `--dart-define=API_BASE_URL=...`. Development may use `http://localhost` or `http://127.0.0.1` against `backend/`. Every other environment requires HTTPS, and URLs must not contain credentials. Auth on generation routes lands in Phase 9.

## Packages

| Package | Why it is here |
| --- | --- |
| `flutter_riverpod` | Explicit, testable state and dependency injection. |
| `go_router` | Declarative routes and a pure redirect function. |
| `drift`, `drift_flutter`, `path_provider` | Typed SQLite with migrations and reactive queries. |
| `freezed_annotation`, `json_annotation` | Immutable models and JSON. |
| `uuid` | Sync-friendly identifiers. |
| `dio` | Timeouts and a single place to map HTTP failures. |
| `flutter_secure_storage` | Future tokens, not preferences. |
| `build_runner`, `drift_dev`, `freezed`, `json_serializable` | Code generation. |
| `mocktail` | Test doubles. |
| `flutter_secure_storage_platform_interface` | In-memory secure-storage tests. |

Not added yet: sign-in SDKs (Google/Apple), a vendor Sentry/Crashlytics adapter (optional `CRASH_INGEST_URL` + backend ingest is wired), and `riverpod_generator`.

## Phases

1. Foundation. Done.
2. Deck screens: create, rename, delete. Done.
3. Card screens: create, edit, delete, duplicate, search, tags. Done (move/filter polish can follow).
4. Study UI: reveal, grade, session statistics. Done.
5. Spaced repetition (SM-2). Done — scheduling stays out of the widgets.
6. PDF pick and validation. Done (extraction/generation wait on the backend).
7. Backend service and provider abstraction. Structured output only. Done.
8. Generation progress, draft review, save into a deck. Done.
9. Email link + sync outbox. Guest mode remains. Done (Google/Apple + cloud transport later).
10. Accessibility, performance, security, and store hardening. Done (branded icons/splash and hosted privacy URL remain for submission).
11. Quizzes from a deck (MCQ / short answer / timed) with stored results. Done.
12. Insights: weak tags/cards, study calendar, retention, next actions. Done.
13. Text/note import polish — largely covered by Phases 7–8 notes path.
14. Advanced study: cloze, reverse, cram, typed answers. Done.

## Phase 1 behaviour

Routes: `/splash`, `/onboarding`, `/`, `/settings`. Onboarding is stored. The home screen reads real due, studied-today, streak, and deck-progress figures. With no decks it shows an empty state. Settings switches system, light, and dark theme.

## Phase 2 behaviour

Routes: `/decks`, `/decks/new`, `/decks/:deckId`, `/decks/:deckId/edit`. Home offers a New deck action and opens deck detail from progress tiles. Soft-delete confirms before removing a deck and its cards.

## Phase 3 behaviour

Routes: `/decks/:deckId/cards/new`, `/decks/:deckId/cards/:cardId/edit`. Deck detail lists cards with search, add, edit, duplicate, and delete. Tags are comma-separated on the form. Move-between-decks UI is deferred; the repository already supports `move`.

## Phases 4–5 behaviour

Routes: `/study`, `/study/:deckId`. A session loads due cards, reveals the answer, grades Again/Hard/Good/Easy, writes `ReviewResults`, updates SM-2 fields on the card, and shows a summary. Home offers “Study due cards” when anything is due; deck detail offers “Study deck”.

## Phase 6 behaviour

Route: `/import`. The person picks a PDF; the client validates name/type/size and stores **metadata only** (`DocumentImport`). Status becomes `readyForGeneration`.

## Phases 7–8 behaviour

`backend/` exposes extract + generate. The app uploads PDF bytes only for the job, reviews drafts, and saves approved cards. Paste-notes use the same draft review path and can draft offline via the heuristic generator.

## Phase 9 behaviour

Settings shows Account and Sync. Linking an email upgrades the guest row in place and stores a local session in secure storage. Deck, card, and account writes enqueue `sync_outbox` rows. Cloud sync is not connected; the UI says so. Google and Apple are not offered as dead buttons.

## Phase 11 behaviour

Routes: `/quiz`, `/quiz/:attemptId`. Home and deck detail offer quiz entry points. Setup chooses deck, question count, style (MCQ / short answer / mixed), and an optional whole-quiz timer. Answers and scores persist in `quiz_attempts` / `quiz_answers`. Quiz grades do not change SM-2 scheduling.

## Phase 12 behaviour

Route: `/insights`. Aggregates recent reviews and quiz answers into weak tags/cards, a 28-day activity calendar, retention bars, and actionable next steps (study due, focus a weak tag, take a quiz).

## Phase 14 behaviour

Flashcards store `cardType` (`basic` | `cloze` | `reverse`). Cloze questions use Anki-style `{{c1::text}}` markup; study blanks the deletions and derives typed expected answers from them. Reverse cards show answer first. Study sessions store `mode` (`review` | `cram`); cram loads living cards and writes review rows without SM-2 updates. Query params: `/study?mode=cram`, `/study/:deckId?typed=1`.

## Phase 10 behaviour

Study and quiz progress bars expose labeled semantics; loading views are live regions. Deck detail can load more than the first 50 cards. Import screens show an offline banner via `connectivity_plus`. Settings → Privacy loads `docs/store/privacy-policy.md`. Store checklist lives in `docs/store/`.

## Store polish behaviour

Launcher icons and splash use the Flashhh teal flashcard mark. `CrashReporter` logs locally and, when `CRASH_INGEST_URL` is set, POSTs scrubbed diagnostics to the backend (`POST /v1/diagnostics/crash`). CI runs Flutter analyze/test and backend tests on push and pull requests.
