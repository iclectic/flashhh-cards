# Store listing checklist (Phase 10)

Use this before submitting Flashhh to the App Store / Play Store.

## Required copy

- [ ] Short description (≤80 chars Play / subtitle iOS)
- [ ] Full description highlighting offline-first study, not chat
- [ ] Privacy policy URL pointing at a hosted version of `privacy-policy.md`
- [ ] Support URL / email

## Assets

- [ ] Branded launcher icons (replace Flutter defaults)
- [ ] Branded splash / launch screen
- [ ] Phone screenshots: home due queue, study grade, draft review, insights
- [ ] Tablet screenshots optional

## Build / compliance

- [ ] `version` / build number bumped in `pubspec.yaml` and `AppInfo`
- [ ] Release crash sink wired (Sentry/Crashlytics) using `CrashReporter`
- [ ] No provider API keys in the mobile binary
- [ ] Staging/production `API_BASE_URL` is HTTPS
- [ ] Accessibility pass with TalkBack / VoiceOver on study + quiz

## Not yet product features

- Google / Apple sign-in UI
- Cloud sync transport
- Web / WASM runtime
