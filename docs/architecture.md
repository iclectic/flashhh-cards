# Flashhh architecture

Flashhh is a local-first flashcard application. Phases 1–5 cover foundation, decks, cards, study UI, and SM-2 scheduling. PDF import, the AI backend, authentication providers, and cloud sync are not built yet. The product vision and later phases (quizzes, insights, text import) live in [product-roadmap.md](product-roadmap.md).

## What already existed

The repository contained only a title in `README.md`. There was no Flutter project, no architecture, and no application code. This document is the architecture that Phase 1 established.

## Decisions

- Feature-first layout. A feature gets `domain`, `data`, and `presentation` only when that feature has something real in that layer.
- Riverpod is the composition root (`lib/app/dependencies.dart`). Providers are written by hand. `riverpod_generator` was skipped so the graph stays readable next to the Freezed and Drift generators that already run.
- Drift (SQLite) is the offline store. Repository interfaces stay free of Drift types so a sync implementation can sit beside the local one later.
- The app opens on a local guest account. Authentication must not block someone from creating decks.
- Identifiers are UUID v4. Timestamps stored in the database are UTC. “Today” and streaks use the device’s local calendar.
- Decks and cards are soft-deleted (`deletedAt`) so a future sync can propagate deletions. `cardCount` is computed from living cards.
- Scheduling columns exist so a spaced-repetition algorithm can be added without a redesign. No scheduler writes them yet. Ease is stored as integer thousandths (`easeFactorMillis`, default 2500) and exposed as `easeFactor` 2.5. That matches SM-2. FSRS would be a later schema migration if we choose it over SM-2.
- The client never holds an AI provider key. `AiFlashcardGenerator` and `DocumentTextExtractor` have no implementation.
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
    authentication/     guest account model and local seeder
    decks/              deck model, validation, repository, list/detail/form UI
    flashcards/         card model, validation, repository, form + deck card list
    study/              due policy, streak, SM-2, session repo, study UI
    ai_generation/      import policy, response validator, usage records
    onboarding/
    home/
    settings/
```

## Models

| Model | Role |
| --- | --- |
| `UserAccount` | Local owner. `AuthProvider` is `guest`, `email`, `google`, or `apple`. |
| `Deck` | Name, description, owner, timestamps, computed `cardCount`. |
| `Flashcard` | Question, answer, tags, difficulty, source (`manual`, `pdf`, `ai_generated`), review counters, SM-2 fields. |
| `StudySession` / `ReviewResult` | A sitting and one graded recall (`again`, `hard`, `good`, `easy`). |
| `DeckProgress` / `DashboardSnapshot` | Due today, studied today, streak, per-deck progress. |
| `DocumentImport` | Metadata only. File bytes are not stored. |
| `GenerationUsageRecord` | Generations, document size, tokens, estimated cost, failures. |
| `GeneratedFlashcardDraft` | Untrusted model output after validation. |

JSON uses camelCase. Multi-word enums use snake_case on the wire (`ai_generated`) and `.name` in SQLite (`aiGenerated`).

## AI and PDF pipeline

The Flutter app will select and validate a PDF, then send it to the backend. The backend owns extraction, OCR, chunking, the model call, and cost control.

```
PDF
  → validate name, type, and size on the device
  → backend stores the file only for the job
  → extract text
  → if the text is too thin, OCR
  → clean and chunk with overlap
  → structured generation
  → schema validation and deduplication
  → drafts returned to the app
  → person edits, removes, or regenerates
  → approved cards are saved into a chosen deck
```

Generation settings reserved on the request: card count, difficulty (`beginner`, `intermediate`, `advanced`), and style (`factual`, `conceptual`, `mixed`). The response must be a `flashcards` array of objects with question, answer, difficulty, and an optional source reference. The client validator drops empty, oversized, duplicate, and unknown-difficulty cards. A payload that is not an object with a `flashcards` list is rejected entirely. Drafts are not written into a deck by that validator.

Uploaded bytes are temporary processing data. `DocumentImport` rows can be deleted with their usage records. The app does not keep the PDF.

## Flutter and the backend

| Flutter | Backend |
| --- | --- |
| Decks, cards, study, statistics, settings | PDF text extraction and OCR |
| Offline reads and writes | Prompting, structured output, deduplication |
| Review of generated drafts | Provider credentials |
| Document size and type checks before upload | Auth on generation routes, rate limits, usage accounting |
| Secure storage for future session tokens | Deleting temporary files after the job |

Production generation requires an authenticated backend call. The placeholder base URL is `https://api.flashhh.app` and is not called in Phase 1. Override it with `--dart-define=API_BASE_URL=...`. Development may use `http://localhost` or `http://127.0.0.1`. Every other environment requires HTTPS, and URLs must not contain credentials.

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

Not added yet: file picker, PDF/OCR libraries, sign-in SDKs, crash reporting, and `riverpod_generator`.

## Phases

1. Foundation. Done.
2. Deck screens: create, rename, delete. Done.
3. Card screens: create, edit, delete, duplicate, search, tags. Done (move/filter polish can follow).
4. Study UI: reveal, grade, session statistics. Done.
5. Spaced repetition (SM-2). Done — scheduling stays out of the widgets.
6. PDF pick, validation, and extraction against the backend.
7. Backend service and provider abstraction. Structured output only.
8. Generation progress, draft review, save into a deck.
9. Email, Google, Apple, and sync. Guest mode remains.
10. Accessibility, performance, security, and store hardening.
11–14. Quizzes, insights, text/note import, advanced study — see [product-roadmap.md](product-roadmap.md).

## Phase 1 behaviour

Routes: `/splash`, `/onboarding`, `/`, `/settings`. Onboarding is stored. The home screen reads real due, studied-today, streak, and deck-progress figures. With no decks it shows an empty state. Settings switches system, light, and dark theme.

## Phase 2 behaviour

Routes: `/decks`, `/decks/new`, `/decks/:deckId`, `/decks/:deckId/edit`. Home offers a New deck action and opens deck detail from progress tiles. Soft-delete confirms before removing a deck and its cards.

## Phase 3 behaviour

Routes: `/decks/:deckId/cards/new`, `/decks/:deckId/cards/:cardId/edit`. Deck detail lists cards with search, add, edit, duplicate, and delete. Tags are comma-separated on the form. Move-between-decks UI is deferred; the repository already supports `move`.

## Phases 4–5 behaviour

Routes: `/study`, `/study/:deckId`. A session loads due cards, reveals the answer, grades Again/Hard/Good/Easy, writes `ReviewResults`, updates SM-2 fields on the card, and shows a summary. Home offers “Study due cards” when anything is due; deck detail offers “Study deck”.
