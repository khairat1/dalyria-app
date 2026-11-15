# Dalyria — Project Context

Read this first in every new session. Keep it updated when decisions change.

## What this is

**Dalyria (دليريا)** — "دليريا، دليلك في سوريا" (Dalyria, your guide to Syria). Formerly named وين (Wain).
A bilingual (Arabic default / English) Android app for discovering food places in Damascus, with verified, up-to-date information. Core promise: **every place is real, open, and up to date.**

It is also the developer's Software Engineering graduation project at Altınbaş University (2026–2027).

- **V1 (Semester 1, due ~30 Dec 2026):** food places in Damascus city, Android only, fully functioning app.
- **V2 (Semester 2):** business owner accounts, iOS, more cities and categories, re-check schedule.

## Links

- GitHub: https://github.com/khairat1/dalyria-app
- Requirements doc (tabs: Requirements, Tech stack, Data model, Screens and flows): https://claude.ai/artifact/PFwR17ggd6Rz7Jh6mj7Xxg
- Concept doc (English + Arabic): https://claude.ai/artifact/As7ddTPiT5zpvi7jL9Ytar
- User flows whiteboard: https://claude.ai/artifact/962s7epZcCkK8dU7XAKZeo
- Project folder on the developer's PC: `G:\Work\dalyria`

## Key decisions

- App ID: `com.dalyria.dalyria`. Dart package name: `dalyria`.
- Stack: Flutter (Dart), Supabase (PostgreSQL, Auth, Storage; region Frankfurt), Google sign-in only in V1 (Apple sign-in and phone SMS later), Google Maps (`google_maps_flutter`), `geolocator`, Riverpod, `go_router`, Flutter `intl` localization, `share_plus`, `url_launcher`, `image_picker`, `flutter_image_compress`, `cached_network_image`.
- 13 database tables designed for the full vision (cities, areas, categories with sub-categories, places, opening_hours, place_photos, profiles, saved_places, ratings, reports, collections, collection_places, banners). See the Data model tab.
- Admin screens live inside the same app, shown only to `role = admin`. Real protection is Row Level Security in the database.
- V1 includes: home sections (New, Trending, Collections, Near you), rotating banner, onboarding (max 3 slides), search and filters, map with area-picker fallback, place details, ratings and reviews (1–5 stars + optional text, one per user per place), saved places, problem reports, share (text + Google Maps link), directions via Google Maps.
- V1 data: 50 places, collected online for the graduation demo (replace photos with original or permitted ones before any public launch). First 50 places bulk-imported from a CSV.
- Not in V1: business owner accounts, re-check schedule, offline mode, iOS, other cities and categories.

## Rules for the code

- Never commit secrets. Real keys go in `.env` (git-ignored). `.env.example` lists the keys with empty values. The Supabase service role key never goes in the app or the repo.
- Every screen must work in Arabic (RTL) and English (LTR).
- Feature-based folder structure under `lib/`. Small, clear commits using `feat:`, `fix:`, `docs:`, `chore:`, `test:`, `refactor:`.
- Store Arabic and English text in the database as `_ar` / `_en` columns.

## How to work with the developer

- Explain new concepts briefly before giving code, in simple English. Technical terms stay in English; Arabic text in code stays Arabic.
- Give complete, ready-to-use files, never "change line X" instructions. When editing, make the edit and give the full updated file.
- Debug step by step, never by guessing. Be honest about risks; flag security, cost, and compliance decisions.
- Ask at most one question at a time.
- Claude can read and edit files in `G:\Work\dalyria` (once folder access is granted for the session) but cannot run commands. The developer runs git, flutter, and other commands and pastes the output.

## Graduation project requirements (university 9-week program)

Weekly report sections, GitHub evidence, at least 5 documented development stages (date, objective, functionality, technical decision, screenshot, problem, solution, commit, next step), testing evidence table, reproducibility (install and run instructions), final README, architecture diagrams, CV entry, LinkedIn post, 60–120 second pitch. Weeks 1–5 are to be submitted together.

## Status

- [x] Concept, requirements, tech stack, data model, screens and flows planned
- [x] Flutter project created and running on Android emulator (Pixel 8, Google Play image)
- [x] GitHub repo with README, references, `.gitignore` for `.env`, `.env.example`
- [ ] Week 1 report sections (intro, problem, motivation, objectives, scope) — written by the developer
- [ ] Supabase project setup (Frankfurt) and database tables
- [ ] Google Cloud project: Maps API key (restricted, budget alert), Google sign-in
- [ ] App foundation: folder structure, localization, theme, navigation
- [ ] Features, admin screens, testing, report completion

## Next step

Set up Supabase and Google Cloud, then build the app foundation.
