# Dalyria — Backend and Keys Setup

This guide sets up everything the app needs outside the code: a Supabase project, a Google Cloud project (Maps key + Google sign-in), and the local `.env` file. Follow it top to bottom. **Never paste real keys into any file that is committed to Git.**

Menu names in the Supabase and Google consoles change from time to time. If a button is not where this guide says, look for the same word nearby.

## What goes where

| Value | Where it comes from | Where it is stored |
| --- | --- | --- |
| `SUPABASE_URL` | Supabase: Project Settings, API / Data API | `.env` |
| `SUPABASE_PUBLISHABLE_KEY` (`sb_publishable_...`) | Supabase: Project Settings, API Keys | `.env` |
| `GOOGLE_MAPS_API_KEY` | Google Cloud: APIs and Services, Credentials | `.env` (Gradle copies it into the build) |
| `GOOGLE_WEB_CLIENT_ID` | Google Cloud: Google Auth Platform, Clients (type Web) | `.env` |
| Supabase database password | Chosen by you when creating the project | A password manager only |
| Google Web client **secret** | Google Cloud (same Web client) | Supabase dashboard only, never in the app |
| Supabase secret key (`sb_secret_...`) | Supabase | **Never in the app or the repo** |

`.env` values are compiled into the app, so they may only be public client keys. The Maps key is safe only because it is restricted (Part B).

---

## Part A — Supabase (Frankfurt)

1. Go to https://supabase.com/dashboard and sign in (GitHub login is fine).
2. Create an organization if asked (name: `dalyria`, type: Personal, plan: **Free**).
3. Click **New project** and fill in:
   - **Name:** `dalyria`
   - **Database password:** use the generator, then save it in a password manager. You cannot read it again later.
   - **Region:** **Central EU (Frankfurt)** (`eu-central-1`).
   - If you see an option such as **Enable automatic RLS** (Row Level Security on every new table), turn it on.
4. Wait about 2 minutes until the project is ready.
5. Open **Project Settings, API Keys**. If you only see legacy keys, click **Create new API keys**. Copy the **Publishable key** (`sb_publishable_...`). Do **not** copy the secret key.
6. Copy the **Project URL** (`https://<project-ref>.supabase.co`). It is shown on the project home page or under Project Settings, Data API.

Free plan facts to know: the database is 500 MB, there are no backups, and a project with no activity for 7 days is **paused**. Open the dashboard (or run the app) before any demo. A paused project can be restored from the dashboard.

## Part B — Google Cloud

### B1. Project and billing

1. Go to https://console.cloud.google.com and sign in.
2. Create a project named `dalyria` (top bar, project picker, **New project**).
3. Open **Billing** and link a billing account (a card is required to use Maps). The Maps SDK for Android on phones is currently listed as unlimited and free, but other Maps APIs cost money, so do the next step now.

### B2. Budget alert (do this before creating any key)

1. **Billing, Budgets and alerts, Create budget**.
2. Name: `dalyria-budget`. Scope: the `dalyria` project. Amount: a small monthly amount you are comfortable with (for example 10 USD).
3. Alert thresholds: 50%, 90%, 100%. Make sure email notifications reach you.

A budget **only sends alerts. It does not stop spending.** That is why the key restrictions in B4 matter.

### B3. Enable the Maps API

**APIs and Services, Library**, search **Maps SDK for Android**, click **Enable**. Enable nothing else for now.

### B4. Get the debug SHA-1 fingerprint

Google needs to know which app is allowed to use the key. In a terminal in the project folder:

```
cd android
.\gradlew signingReport
```

Find the `debug` variant and copy the **SHA1** line (looks like `AA:BB:CC:...`). The package name is `com.dalyria.dalyria`.

### B5. Create the restricted Maps key

1. **APIs and Services, Credentials, Create credentials, API key**. Name it `dalyria-maps-android`.
2. Open the key and set:
   - **Application restrictions:** Android apps. Add package name `com.dalyria.dalyria` and the SHA-1 from B4.
   - **API restrictions:** Restrict key, and select **only Maps SDK for Android**.
3. Save, copy the key into `.env` as `GOOGLE_MAPS_API_KEY`. Restrictions can take a few minutes to apply.

### B6. Google sign-in

1. Open **Google Auth Platform** (search for it in the top bar) and click **Get started** if shown.
2. **Branding:** app name `Dalyria`, support email, developer contact email.
3. **Audience:** User type **External**. Keep the status **Testing** for now and add your own Google account under **Test users**. In Testing mode only listed test users can sign in.
4. **Data access (Scopes):** make sure `openid`, `.../auth/userinfo.email` and `.../auth/userinfo.profile` are present. Do not add other scopes (extra scopes trigger Google's slow verification).
5. **Clients, Create client**, create two clients:
   - Type **Android**: name `dalyria-android-debug`, package name `com.dalyria.dalyria`, SHA-1 from B4.
   - Type **Web application**: name `dalyria-web` (used by Supabase). No redirect URI is needed for the native flow, but you can add `https://<project-ref>.supabase.co/auth/v1/callback`.
6. Copy the **Web client ID** into `.env` as `GOOGLE_WEB_CLIENT_ID`. Keep the Web client **secret** for the next step.

### B7. Connect Google to Supabase

1. In Supabase: **Authentication, Sign In / Providers, Google**. Turn it on.
2. Paste the **Web client ID**, and the Web client **secret** (it stays in the Supabase dashboard only).
3. Save.

---

## Part C — Connect the Flutter project

1. In the project folder, copy `.env.example` to `.env` and fill in the four values. No quotes, no spaces around `=`:

   ```
   SUPABASE_URL=https://xxxxxxxx.supabase.co
   SUPABASE_PUBLISHABLE_KEY=sb_publishable_...
   GOOGLE_MAPS_API_KEY=AIza...
   GOOGLE_WEB_CLIENT_ID=1234567890-xxxx.apps.googleusercontent.com
   ```

   The `.env` file is read in two ways: by Flutter at build time (`--dart-define-from-file=.env`) and by Gradle (for the Maps key). It is not packed into the app as a file.
2. Install packages and run on the emulator (use a **Google Play** image, so Google sign-in works):

   ```
   flutter pub get
   flutter run --dart-define-from-file=.env
   ```

   In VS Code, pressing F5 uses `.vscode/launch.json`, which already contains this flag.

3. The temporary **setup check** screen shows four checks: `.env` loaded, Supabase connected, Google sign-in, and a map of Damascus.
4. After changing `.env`, fully stop and restart the app. Hot reload does not re-read it.

## Check that no secret is committed

Before every commit:

```
git status
git check-ignore -v .env
```

`.env` must **not** appear in `git status`, and the second command must print a rule from `.gitignore`.

## Later (before a public launch)

- Add the **release** signing SHA-1 (and the Google Play app-signing SHA-1) to the Android OAuth client and to the Maps key restriction.
- Change the Google consent screen from **Testing** to **In production** (needs a privacy policy link and a home page).
- Consider the Supabase **Pro** plan (no pausing, daily backups).
- Rotate any key that was ever shown on screen, committed or shared.

## Troubleshooting (Windows)

- **"An Application Control policy has blocked this file" when running `flutter run`:** Smart App Control blocked a Dart SDK file. This worked for us: `Get-ChildItem C:\flutter\flutter\bin\cache -Recurse | Unblock-File`, then run again. Check Event Viewer, CodeIntegrity, Operational (events 3077 and 3033) to see which file was blocked.
- **"Could not close incremental caches ... Storage is already registered" (Kotlin build error):** `android/gradle.properties` contains `kotlin.incremental=false` as a workaround. Keep it.
- **"Configuration problem" screen:** the app was started without `--dart-define-from-file=.env`, or a value in `.env` is empty. Stop the app and run it again with the flag. A `.env` file cannot be loaded as an app asset on Android (hidden files are dropped when the app is packaged), which is why this approach is used.
