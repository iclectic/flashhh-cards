# Flashhh API

Node Express service for PDF text extraction and flashcard draft generation.
Provider keys stay here — never in the Flutter app.

## Endpoints

| Method | Path | Purpose |
| --- | --- | --- |
| `GET` | `/health` | Liveness + whether OpenAI is configured |
| `POST` | `/v1/documents/extract` | Multipart PDF upload → text sections |
| `POST` | `/v1/flashcards/generate` | Sections → structured draft cards |
| `POST` | `/v1/diagnostics/crash` | Scrubbed client crash / log ingest |

Without `OPENAI_API_KEY`, generation uses the local heuristic so development still works.

## Run

```bash
cd backend
npm install
npm start
```

Optional:

```bash
export PORT=8080
export MAX_UPLOAD_BYTES=20971520
export OPENAI_API_KEY=sk-...
npm start
```

Point the Flutter app at it:

```bash
flutter run \
  --dart-define=APP_ENV=development \
  --dart-define=API_BASE_URL=http://127.0.0.1:8080
```

## Tests

```bash
npm test
```
