# Flashhh — world-class product roadmap

Flashhh is a **local-first study engine**, not a chat wrapper. ChatGPT can quiz you once; Flashhh owns the loop: capture material → turn it into durable cards → schedule review → quiz under exam pressure → show what stuck.

This document extends [architecture.md](architecture.md). Phase 1 (foundation) is done. Everything below is the product plan we execute against.

---

## Product north star

> Feed Flashhh what you need to learn. It helps you **understand**, **memorize**, and **prove** you know it — offline-first, privacy-respecting, and tuned for exams and interviews.

**Differentiation vs ChatGPT / generic AI chat**

| ChatGPT | Flashhh |
| --- | --- |
| Ephemeral Q&A in a thread | Persistent decks, tags, and history |
| No real spaced repetition | SM-2 (then optional FSRS) scheduling |
| No ownership of results | Session + quiz results stored on device |
| You re-prompt every time | One import → editable cards → lifelong review |
| Model holds the knowledge | **You** hold the knowledge; AI only drafts |

---

## Personas & jobs

1. **Exam prep** — lecture PDFs, past papers, dense notes → cards + timed quizzes + weak-topic heatmaps.
2. **Interview prep** — system design / behavioral / coding concepts → factual + conceptual cards, “explain out loud” mode, mock quiz sets.
3. **Course / certification** — chapter PDFs → chapter decks, tags by topic, progress per deck.
4. **Lifelong learner** — paste notes or upload a short PDF → review on the commute, offline.

---

## Current state (Phase 1)

| Layer | Status |
| --- | --- |
| Flutter app shell (Riverpod, go_router, M3 theme) | Done |
| Drift SQLite: users, decks, cards, tags, sessions, reviews, imports, usage | Done |
| Guest account, onboarding, dashboard stats, theme settings | Done |
| Deck / card **repositories** (CRUD) | Done (no UI) |
| AI / PDF **contracts** + draft validator + import policy | Done (no client, no backend) |
| Study session writer, SM-2 scheduler | Not built |
| Deck / card / study / import UI | Not built |
| Quizzes, results analytics, multi-format import | Not in Phase 1 schema |

---

## Experience principles (Google-bar bar)

- **One primary action per screen.** Home → study what’s due. Deck → manage cards. Import → review drafts.
- **Never pretend a feature works.** No dead buttons that open empty stubs without a clear “coming next” path — prefer ship a thin vertical slice.
- **Offline is the default.** Generation is the only cloud-dependent path; everything else reads/writes SQLite.
- **AI drafts, humans approve.** Generated cards are never auto-saved into a deck.
- **Privacy by design.** No PDF bytes retained after the job. No provider keys on device. Analytics never carry question/answer/file text.
- **Accessibility & performance.** 48dp targets, labeled progress, semantic labels, no jank on large decks (paginated queries already exist).
- **Honest empty states** with one clear CTA.

---

## Capability map (what “perfect” looks like)

### A. Capture

- Manual card editor (front/back, difficulty, tags).
- **PDF import** (size-capped, validated) → backend extract / OCR → chunk → structured cards.
- Paste / plain-text import (notes, markdown) without a PDF.
- Optional later: images of whiteboard notes (OCR), Anki/CSV import.

### B. Organize

- Decks with rename / soft-delete.
- Tags, search, filter (difficulty, source, tag).
- Move / duplicate cards across decks.
- “Class” or course grouping (folder of decks) — Phase 9+.

### C. Memorize

- Classic flip study: reveal → grade Again / Hard / Good / Easy.
- **SM-2** scheduling (schema ready); later FSRS if we outgrow SM-2.
- Due queue on the home dashboard.
- Cram mode (ignore schedule) for night-before exams.
- Optional: cloze deletion, reverse cards, typed-answer check.

### D. Understand & quiz

- **Quiz mode** distinct from spaced review: multiple choice, short answer, true/false generated from cards or source material.
- Timed exam simulations (N questions, countdown, score).
- AI “explain this card” side panel (optional, networked) that never replaces the card text.
- Weak-card and weak-tag surfacing after quizzes.

### E. Prove & store results

- Persist every study session and quiz attempt (already have `StudySessions` / `ReviewResults`).
- Add `QuizAttempts` + `QuizAnswers` tables when quiz ships.
- History: accuracy over time, streak, time spent, grade distribution.
- Export results / deck as CSV or Anki-friendly package (later).

### F. Trust & polish

- Sign-in (email / Google / Apple) and optional encrypted sync.
- Crash reporting, store listing assets, offline indicators.
- Rate limits and cost caps on generation (backend).

---

## Execution phases

Phases 1–10 match architecture.md. Phases 11–14 are the product expansion this roadmap adds.

| Phase | Outcome | Ship criteria |
| --- | --- | --- |
| **1 Foundation** | App shell, DB, contracts | Analyze + tests green |
| **2 Decks UI** | Create / rename / delete decks from the app | Can manage decks end-to-end offline |
| **3 Cards UI** | Create / edit / delete / move / duplicate / search / tags | Full manual deck building |
| **4 Study UI** | Flip, grade, session summary | A sitting can be finished and counted on the dashboard |
| **5 Spaced repetition** | SM-2 writes intervals / ease / nextReviewAt | Due queue shrinks correctly after grades |
| **6 PDF pick + validate** | File picker, policy checks, upload handshake | Reject bad files; accept good PDFs |
| **7 AI backend** | Extract, OCR fallback, structured generation | HTTPS service; no keys on device |
| **8 Draft review** | Progress, edit/drop drafts, save into deck | Human-in-the-loop generation complete |
| **9 Auth + sync** | Email link + outbox; guest remains | Optional account on device; Google/Apple + cloud transport later |
| **10 Hardening** | A11y, performance, security, store | Release candidate |
| **11 Quizzes** | Quiz from deck or import; MCQ / short answer; timed mode | Results stored and reviewable |
| **12 Insights** | Weak tags, retention curves, study calendar | Actionable “what to study next” |
| **13 Text & note import** | Paste notes → same draft pipeline as PDF | No PDF required for AI drafts |
| **14 Advanced study** | Cloze, reverse cards, cram, typed answers | Power-user parity with Anki-class tools |

---

## PDF → cards → quiz loop (target UX)

```
[Pick PDF ≤ max bytes]
        ↓
  Validate name/type/size (client)
        ↓
  Upload to backend (temp only)
        ↓
  Extract text → OCR if thin → chunk
        ↓
  Structured generation (count, difficulty, style)
        ↓
  Client validates drafts (drop junk)
        ↓
  Review screen: edit / discard / regenerate
        ↓
  Save into deck (source = pdf | ai_generated)
        ↓
  Study (SM-2)  ⊕  Quiz (exam mode)
        ↓
  Results + weak spots → next session
```

Paste/notes join the same pipeline at “chunk → generate”.

---

## Data gaps to add when we reach them

| Need | Approach |
| --- | --- |
| Quiz attempts | New Drift tables `quiz_attempts`, `quiz_answers` |
| Course / class folders | `collections` table + `deck.collectionId` |
| Cloze cards | Done in Phase 14 (`cardType` + `{{c1::…}}` in question) |
| Source citations | Keep `sourceReference` on drafts; store on card as optional field |
| Sync | Outbox table + soft-delete tombstones (already have `deletedAt`) |

---

## What we are executing now

**Phases 2–6** (done): decks, cards, study + SM-2, PDF pick/validate.

**Phases 7–8** (done on prior branch): AI backend, notes import, draft review.

**Phase 9** (prior branch): email link + sync outbox foundations.

**Phase 11** (prior branch): offline quizzes with stored results.

**Phase 12** (prior branch): insights — weak spots, calendar, next actions.

**Phase 14** (prior branch): cloze, reverse, cram, typed answers.

**Phase 10** (prior branch): a11y, load-more, offline banner, privacy checklist.

**Store polish** (this branch):

1. Branded launcher icons + splash (Android / iOS / macOS / web).
2. Optional remote crash ingest (`CRASH_INGEST_URL` → `POST /v1/diagnostics/crash`).
3. GitHub Actions CI for Flutter + backend.
4. Store listing copy draft + checklist updates.

**Next up:** host privacy URL + screenshots, or Google–Apple auth / sync transport.

---

## Non-goals (for now)

- Full ebook / book-length ingestion as a first-class product (page caps + chunking only).
- Embedding provider API keys in the mobile app.
- Web as a supported runtime before SQLite WASM.
- Auto-saving AI output without a human review step.
