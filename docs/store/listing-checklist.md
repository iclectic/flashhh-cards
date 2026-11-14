# Store listing checklist

Use this before submitting Flashhh to the App Store / Play Store.

## Required copy

- [x] Short description (≤80 chars Play / subtitle iOS) — see `listing-copy.md`
- [x] Full description highlighting offline-first study, not chat — see `listing-copy.md`
- [ ] Privacy policy URL pointing at a hosted version of `privacy-policy.md`
- [ ] Support URL / email (draft contact: `privacy@flashhh.app`)

## Assets

- [x] Branded launcher icons (Android / iOS / macOS / web) — teal flashcard mark
- [x] Branded splash / launch screen (`launch_background` + LaunchImage)
- [x] Master icon at `docs/store/assets/app-icon-1024.png`
- [ ] Phone screenshots: home due queue, study grade, draft review, insights
- [ ] Tablet screenshots optional

## Build / compliance

- [ ] `version` / build number bumped in `pubspec.yaml` and `AppInfo`
- [x] Release crash sink wired via `CrashReporter` + optional `CRASH_INGEST_URL`
- [x] No provider API keys in the mobile binary
- [x] Staging/production `API_BASE_URL` is HTTPS
- [ ] Accessibility pass with TalkBack / VoiceOver on study + quiz

## Crash ingest

Point release builds at the Flashhh API (or Sentry/Crashlytics adapter later):

```bash
flutter run \
  --dart-define=APP_ENV=production \
  --dart-define=API_BASE_URL=https://api.flashhh.app \
  --dart-define=CRASH_INGEST_URL=https://api.flashhh.app/v1/diagnostics/crash
```

Payloads are scrubbed (no emails / bearer tokens; truncated message + stack).

## Not yet product features

- Google / Apple sign-in UI
- Cloud sync transport
- Web / WASM runtime
