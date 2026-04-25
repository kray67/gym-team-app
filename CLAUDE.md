# Gym Team App — CLAUDE.md

## Rules for Claude

- **After every successful implementation step**, update `CLAUDE.md` (schema, architecture notes, important conventions) and `ROADMAP.md` (mark tasks done, add SQL applied, record features implemented) without waiting to be asked. Do this as the final action of each session or completed feature.
- **File size check**: after each update to this file, assess whether it has grown unwieldy. Natural split candidates are: `Important Notes` (currently ~40+ bullets), the architecture sections (superset, active plan, PR). When the file feels hard to scan, suggest to the user splitting into `CLAUDE.md` + `docs/database.md` + `docs/architecture.md` + `docs/conventions.md` using `@file` imports. Do not split without asking first.

## Project Overview
A personal workout tracking Android app for ~5 users (sideloaded APK, no Play Store).

## Stack
| Layer | Technology |
|---|---|
| Mobile | Flutter (Android only) |
| Backend | Supabase (Auth + Postgres + Realtime + Storage) |
| State management | Riverpod (`flutter_riverpod` + `riverpod_generator`) |
| Navigation | `go_router` |
| Models | `freezed` + `json_serializable` + `build_runner` |
| Charts | `fl_chart` |
| Other packages | `supabase_flutter`, `cached_network_image`, `intl`, `uuid`, `flutter_dotenv`, `share_plus`, `path_provider` |

> Note: `image_picker` was initially planned for avatar upload but the feature was changed to Material Icons + background color/gradient selection (no file upload, no assets).

## User Background
- Strong Vue.js / frontend experience, no Flutter or native Android experience
- No backend experience
- Prior hybrid app experience with Cordova

## Project Structure (feature-first)
```
lib/
├── main.dart                         # Supabase.initialize() + runApp()
├── app.dart                          # MaterialApp + router setup
├── core/
│   ├── supabase/supabase_client.dart # Singleton Supabase client
│   ├── router/app_router.dart        # Route definitions + auth guard
│   ├── theme/app_theme.dart
│   └── utils/                        # date_utils, formatters
├── shared/
│   ├── widgets/                      # loading_indicator, error_display, avatar
│   └── models/exercise_type.dart
└── features/
    ├── auth/          # login, register screens + auth_provider
    ├── profile/       # my profile, edit profile, followers
    ├── workout/       # active workout, history, detail, exercise picker
    ├── plans/         # plan list, detail, editor, discover
    ├── feed/          # activity feed, user profile view
    └── reports/       # removed
```

## Database Schema (Supabase / Postgres)
```
profiles             -- extends auth.users: username, display_name, bio, avatar_url, avatar_id (int), avatar_color (text), active_plan_id (uuid → workout_plans)
follows              -- (follower_id, following_id) composite PK
exercises            -- catalog: name, category, muscle_group, is_custom, created_by
workout_plans        -- title, description, is_public, owner_id
plan_exercises       -- plan_id, exercise_id, position, goal_type, weight_type, week_number, session_number, superset_group_id
plan_exercise_sets   -- plan_exercise_id, set_number, target_reps, target_reps_max, target_weight (% 1RM), target_rpe, target_rpe_max, is_warmup, weight_increment
saved_plans          -- (user_id, plan_id) — users saving others' plans
user_plan_1rm        -- user_id, plan_id, exercise_id, one_rm_kg, updated_at; UNIQUE(user_id, plan_id, exercise_id)
user_plan_progress   -- user_id, plan_id, restarted_at; PK(user_id, plan_id); tracks when a plan was last reset
workout_sessions     -- user_id, plan_id?, started_at, ended_at, duration_secs
session_exercises    -- session_id, exercise_id, position, superset_group_id
session_sets         -- session_exercise_id, set_number, reps, weight_kg, duration_secs, distance_m, completed, is_warmup
activity_feed        -- actor_id, target_id uuid, type, payload (jsonb), created_at
feed_comments        -- feed_item_id, user_id, content, created_at
exercise_records     -- user_id, exercise_id, record_type (text), value (numeric), session_id, set_id (text), achieved_at; UNIQUE(user_id, exercise_id, record_type)
```
- RLS must be enabled on every table
- Supabase trigger: auto-insert into `profiles` on new `auth.users` row
- Storage: `avatars` bucket (public) — currently unused (avatar feature changed to hardcoded images + color)
- `plan_exercises.goal_type`: `'reps' | 'reps_range' | 'amrap'`
- `plan_exercises.weight_type`: `'percent_1rm' | 'rpe' | 'rpe_range' | 'prev_week_plus' | 'prev_session_plus'` (stored as text; `prev_week_plus` / `prev_session_plus` use `plan_exercise_sets.weight_increment` as the +X kg value)
- `plan_exercise_sets` has ON DELETE CASCADE from `plan_exercises`
- `plan_exercises.superset_group_id` and `session_exercises.superset_group_id` — UUID shared by all exercises in a superset group; `null` for standalone exercises
- `session_sets.is_warmup` and `plan_exercise_sets.is_warmup` — warm-up sets are excluded from stats (total weight + set count) and display as "W" in orange
- `activity_feed.type` values: `'workout_completed'` (feed), `'workout_commented'` (notification), `'workout_reacted'` (notification), `'plan_published'` (feed), `'record_set'` (feed — written by `_detectAndSavePrs()` in `ActiveWorkoutNotifier` when any new PR is achieved; payload: `{session_id, records: [{exercise_id, exercise_name, record_types: [...]}]}`)
- `activity_feed.target_id` — the user who should see the notification; `actor_id` — who performed the action
- Notification types (`workout_commented`, `workout_reacted`) must NOT show `ReactionBar` in feed; they route to `/workout/$sessionId` (own history), not `/feed/workout`
- Feed query uses Supabase `.or('actor_id.in.(...),target_id.eq.$userId')` to fetch both followed-users activity and own notifications in one query

## App Screens
**Auth:** Login, Register

**Bottom nav:** Social | Workout | Plans | Profile

| Feature | Screens |
|---|---|
| Social | SocialScreen (Feed + Users + Leaderboard tabs), FeedWorkoutDetailScreen, UserProfileScreen |
| Workout | ActiveWorkoutScreen ⭐, WorkoutSummaryScreen, WorkoutHistoryScreen, WorkoutDetailScreen, ExercisePickerScreen |
| Plans | PlansListScreen, PlanDetailScreen, PlanEditorScreen, DiscoverPlansScreen, PlanSessionBuilderScreen (session editor) |
| Profile | MyProfileScreen, EditProfileScreen, FollowersScreen, SettingsScreen, MyExercisesScreen |

## Build Phases
1. **Foundation** — Flutter project + Supabase init + auth flow + profiles
2. **Core Workout Tracking** — exercise catalog, active workout screen, history, basic reports
3. **Plans** — create/edit/save/start workout plans
4. **Social** — follows, activity feed, discover plans
5. **Polish** — settings, app icon, release APK

> See [ROADMAP.md](ROADMAP.md) for current status, pending tasks per phase, and known issues.

## Key Commands
```bash
# Run on connected device / emulator
flutter run

# Hot reload (in running session)
r       # hot reload (preserves state)
R       # hot restart (resets state)

# Codegen (run after changing any @freezed model)
dart run build_runner build --delete-conflicting-outputs

# Build release APK (arm64, ~22 MB) — run as one line
flutter build apk --release --target-platform android-arm64 --dart-define=SUPABASE_URL=https://dcyqgyhotqhyyzswdpzz.supabase.co --dart-define=SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRjeXFneWhvdHFoeXl6c3dkcHp6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzU3NzcwNzEsImV4cCI6MjA5MTM1MzA3MX0.Xf0F_i1fvOTVr5499ww4-5BLvsIxIKJK9P8vvphSMWI
# Output: build/app/outputs/flutter-apk/app-release.apk
# Credentials are baked into the APK at build time via --dart-define (no .env at runtime)
```

## Vue → Flutter Mental Model
| Vue | Flutter |
|---|---|
| `<template>` / HTML+CSS | Widget tree (`Column`, `Row`, `Padding`, `Stack`) |
| Pinia / Composables | Riverpod `AsyncNotifier` / `Notifier` |
| `computed` / `watchEffect` | `ref.watch(provider)` |
| Store action | `ref.read(provider.notifier).method()` |
| Vue Router | `go_router` with `GoRoute` definitions |
| TypeScript interfaces | `@freezed` classes |
| `v-if` loading states | `AsyncValue.when(data:, loading:, error:)` |

**Never do async work inside `build()`** — use `FutureProvider` or `AsyncNotifier`.

## Important Notes
- `minSdkVersion`: Flutter auto-manages this via `flutter.minSdkVersion` (already ≥ 21) — do not hardcode
- Supabase credentials are passed at build time via `--dart-define` (see build command above) and read with `String.fromEnvironment()` in `main.dart` — no `.env` file at runtime
- `.env` file exists for reference only and must stay in `.gitignore`
- After restart: always run `flutter doctor` to verify toolchain is healthy
- Project path must not contain non-ASCII characters — keep at `C:\Users\joao.dias\Desktop\flutter_projects\gym-team-app\gym_team`
- `android/gradle.properties` has `android.overridePathCheck=true` — do not remove
- `android/gradle.properties` has `org.gradle.daemon=false`, `org.gradle.parallel=false`, `org.gradle.workers.max=1` — do not remove; required to work around Sophos AV file locking on this machine
- Deep link scheme: `io.supabase.gymteam://login-callback/` (configured in AndroidManifest + Supabase dashboard)
- Email confirmation is disabled in Supabase — not needed for this app
- Login is username + password (not email); `get_email_by_username` RPC in Supabase resolves the email
- Android emulator: Pixel 8 API 35 (id: `Pixel_8`)
- After any `@riverpod` or `@freezed` change, run codegen: `dart run build_runner build --delete-conflicting-outputs`
- `GoRouter` uses `refreshListenable: _AuthChangeNotifier()` (in `app_router.dart`) to re-run redirect on auth state changes — this is what triggers the login redirect on sign-out
- `analysis_options.yaml` sets `invalid_annotation_target: ignore` — suppresses false-positive Dart analyzer warnings for `@JsonKey` on `@freezed` constructor parameters; do not remove
- Supabase joined queries use `profiles!owner_id(username, display_name)` to resolve plan owner info — always use the FK hint (`!column_name`) when a table has multiple FK references to the same target table to avoid ambiguity
- APK signing: keystore at path defined in `android/key.properties`; `build.gradle.kts` uses `signingConfigs.getByName("release")` for release builds — `key.properties` must exist before building
- `android/app/src/main/AndroidManifest.xml` must declare `<uses-permission android:name="android.permission.INTERNET"/>` explicitly — without it, DNS resolution fails on Xiaomi HyperOS / Android 15 release builds even though Flutter's engine normally injects it via manifest merger
- `android/app/proguard-rules.pro` has rules for Flutter, Supabase/Ktor/OkHttp, Kotlin, and Play Core; `isMinifyEnabled = false` in `build.gradle.kts` so ProGuard is not active, but rules are in place if minification is ever enabled
- **Route ordering in `app_router.dart`**: `/workout/done/:id` (WorkoutSummaryScreen) must be declared as a top-level `GoRoute` BEFORE the `ShellRoute` to avoid path conflict with the shell's `/workout/:id` route
- **Post-workout flow**: `_tryFinish()` in `ActiveWorkoutScreen` checks for incomplete sets first; if any exist, shows a confirmation dialog ("X sets not yet completed. Finish anyway?"); on confirm calls `_finish()` which reads `sessionId` from state BEFORE calling `finishWorkout()` (which sets state to null), then navigates to `/workout/done/$sessionId`
- **Stat chips convention**: always show duration, total weight (kg, never tonnes, computed as `weight_kg × reps` summed across all completed non-warmup sets), and set count — consistent across `WorkoutDetailScreen`, `FeedWorkoutDetailScreen`, `WorkoutSummaryScreen`, and `WorkoutHistoryScreen`
- **Duration format**: always `MM:SS` or `HH:MM:SS` (e.g. `54:00`, `25:43`, `01:12:33`) — use `formatDuration(int? secs)` from `lib/core/utils/formatters.dart`; never use `Xmin` or `Xh Ymin`
- **Image sharing**: `WorkoutSummaryScreen` uses `RepaintBoundary` + `GlobalKey` → `RenderRepaintBoundary.toImage(pixelRatio: 3.0)` → PNG bytes → temp file via `path_provider` → `Share.shareXFiles()` from `share_plus`
- **`workoutFeedItemIdProvider`**: family provider that looks up `activity_feed` row for a session: `.eq('type', 'workout_completed').filter('payload', 'cs', '{"session_id":"$sessionId"}').maybeSingle()`
- **Avatar system**: `UserAvatar` widget in `shared/widgets/user_avatar.dart`; renders a `Container` (not `CircleAvatar`) so gradients work; 12 Material Icons (`kAvatarIcons`, index = `avatar_id`), 16 solid colors + 6 gradients (`kAvatarColors`/`kAvatarGradients`); solids stored as `#RRGGBB`, gradients as `gradient:N`; falls back to first letter of name when `avatar_id` is null; `buildAvatarDecoration(hex)` helper returns the correct `BoxDecoration`
- **Avatar picker UI** (`EditProfileScreen`): icon grid inside `ExpansionTile`; "Aa" initials option clears `avatar_id` to null; swatch picker shows solid colors + gradient swatches in separate labelled sections inside a second `ExpansionTile`
- **Feed card format** (`workout_completed`): two lines — line 1: bold "{name} completed a workout"; line 2 (small, dimmed): stats from payload exercises (already pre-filtered to completed non-warmup sets — no `completed`/`is_warmup` fields in payload)
- **Workout history card**: date title, plan name (primary color) or "Workout" (primary color) on second line, then icon-based stat row (timer · weight · repeat icons); history query joins `workout_plans(title)` and `session_sets(*)` for stats
- **`WorkoutSession` model**: has `plan` field (`WorkoutPlanRef?`, JSON key `workout_plans`) for the joined plan title; `WorkoutPlanRef` is a separate `@freezed` class with just `title`
- **Plan editor intensity selector**: `Wrap` of `ChoiceChip`s (5 options: `% 1RM`, `RPE`, `RPE Range`, `Last Week +`, `Last Session +`); progressive types (`prev_week_plus` / `prev_session_plus`) show a "+KG" input field per set (stored as `weightIncrement`)
- **Plan editor RPE clamp**: all RPE fields clamp to ≤ 10 on change
- **Plan editor add set**: copies all values from the last set (reps, intensity, weight increment); new sets are never warmups
- **`copyWeek(fromWeek, targetWeeks)`** in `PlanEditorNotifier` — copies all days of a source week to one or more target weeks
- **`WorkoutHistoryScreen` bottom bar**: always uses a bottom bar (never FAB); watches full `AsyncValue` from `activePlanProvider` — during loading nothing is shown (prevents flicker); when loaded with no plan: `_NoActivePlanBar` with single "Start New Empty Workout" `OutlinedButton`; when loaded with plan: `_ActivePlanBar` with two buttons ("[Plan]: Start Week X · Day Y" + "Start New Empty Workout"); use `context.go()` not `context.push()` when navigating to another tab from within the Workout tab
- **`WorkoutHistoryScreen` no-active-plan banner**: when loaded with no active plan, a tappable `Card` banner appears at the top of the body ("No active plan · Set a plan as active to track progress →"); tapping calls `context.go('/plans')` to switch tabs correctly
- **`PlanDetailScreen` active plan button**: "Set as Active" opens 1RM dialog for all `%1RM` exercises across all weeks; "Active Plan ✓" (green) with option to remove; "Edit 1RM" in AppBar overflow when plan is active; `activatePlan(context, ref, plan)` is a top-level helper (not a method) reused by both `_ActivePlanButton` and the inline session prompt
- **`PlanDetailScreen` session icons**: ALL status icons (check, play, empty circle) are gated on `isActivePlan` — non-active plans show no leading icons at all; `leading: null` on `ListTile`/`ExpansionTile` pulls the title to the left; same applies to week-level icons in `_WeekAccordion`
- **`PlanDetailScreen` inline activation prompt**: when `!isActivePlan && !isCompleted`, the expanded session card shows a small "Set as Active" `TextButton` row instead of nothing — calls `activatePlan()` directly
- **Personal Records (PRs) architecture**: `ExerciseRecord` is a plain Dart class (no @freezed — no codegen needed); `exercise_records` table has UNIQUE(user_id, exercise_id, record_type) — one row per user/exercise/type, upserted on improvement; 3 record types: `max_weight`, `max_volume` (weight×reps, label "Highest Volume Set"), `estimated_1rm` (Epley: weight×(1+reps/30)); `max_reps` was removed
- **PR detection in `finishWorkout()`**: `session_sets` inserts now use `.select('id').single()` to capture DB-assigned set IDs; `_detectAndSavePrs()` groups completed non-warmup sets by exercise, fetches existing records, batch-upserts improvements; wrapped in try/catch so a PR failure never blocks workout saving
- **PR providers** (`lib/features/workout/providers/exercise_records_provider.dart`): `userExerciseRecordsProvider` — auto-dispose, all user records as `Map<exerciseId, Map<recordType, double>>`; `sessionNewRecordsProvider(sessionId)` — records for a specific session (joins `exercises(name)`); `sessionPrSetIdsProvider(sessionId)` — derived `Set<String>` of set IDs from above
- **PR badge in `ActiveWorkoutScreen`**: `_ExerciseCard._computePrSetIds(sets, existing)` computes a `Set<String>` of set IDs that are current PRs for the exercise — only the single best set per record type gets a chip, and only if it beats the stored DB record; earlier sets in the same workout automatically lose their chip when a better set is logged; `isPr: prSetIds.contains(set.id)` passed to each `_SetRow`
- **PR badge in `WorkoutDetailScreen`**: `_ExerciseDetail` watches `sessionPrSetIdsProvider(sessionId)`; passes `isPr: prSetIds.contains(s.id)` to each `_SetRow`; badge is small amber `Container` with "PR" text, overlaid via `Stack + Positioned(right:4, top:-5)`
- **"New Records" card in `WorkoutSummaryScreen`**: `_NewRecordsSection` widget — amber-tinted card with trophy icon; exercise name left-aligned on its own line, records listed below it; dividers between exercises; shown between shareable card and share buttons when `sessionNewRecordsProvider` returns non-empty list
- **`SettingsScreen`** (`lib/features/profile/screens/settings_screen.dart`): "Sign out" (with confirm dialog) + "Delete account" (destructive confirm dialog, calls `delete_account` Supabase RPC then signs out); requires RPC: `CREATE OR REPLACE FUNCTION delete_account() RETURNS void LANGUAGE sql SECURITY DEFINER AS $$ DELETE FROM auth.users WHERE id = auth.uid(); $$;`; `AuthNotifier.deleteAccount()` calls the RPC then `signOut()`; `MyProfileScreen` AppBar now has edit + settings icons (sign-out removed from profile)
- **App icon + splash**: `flutter_launcher_icons` + `flutter_native_splash` packages in dev_dependencies; config at `flutter_launcher_icons.yaml` (adaptive icon: `#1C1B2E` background + `assets/icon/icon_foreground.png` foreground, legacy: `assets/icon/icon.png`) and `flutter_native_splash.yaml` (color `#1C1B2E`, image `assets/icon/icon.png`); SVG sources at `assets/icon/icon.svg` + `assets/icon/icon_foreground.svg`; splash generated (`dart run flutter_native_splash:create`); icons generated (`dart run flutter_launcher_icons`)
- **`addSet()` set numbering**: set number is based on work-set count only — `e.sets.where((s) => !s.isWarmup).length + 1`; prevents first work set being numbered 2 when a warmup is the only existing set
- **Theme color**: `ThemeColorNotifier` (`lib/core/theme/theme_color_notifier.dart`) — `keepAlive` AsyncNotifier; watches `authNotifierProvider` so it re-fetches on login/logout; `setColor(name)` updates state immediately + persists to `profiles.theme_color`; 4 options: `purple`/`blue`/`yellow`/`orange`; seed colors + labels in `AppTheme.seedColors`/`AppTheme.colorLabels`; `app.dart` watches it to rebuild `MaterialApp` with the correct seed; color picker in `SettingsScreen` shows animated swatches with checkmark; SQL: `ALTER TABLE profiles ADD COLUMN IF NOT EXISTS theme_color text;`
- **Leaderboard** (`features/leaderboard/`): 3rd tab in `SocialScreen`; `LeaderboardEntry` plain model; 3 `@riverpod` providers (`attendanceLeaderboardProvider(period)`, `prLeaderboardProvider(period)`, `exerciseLeaderboardProvider(exerciseId, recordType)`); backed by 3 Supabase RPCs (`get_attendance_leaderboard`, `get_pr_leaderboard`, `get_exercise_leaderboard`); `LeaderboardPeriod` enum (`week`/`month`/`allTime`); Lifts tab uses existing single-select exercise picker route; zero-count entries hidden
- **Custom exercises**: `exercises.is_custom = true`, `created_by = userId`; RLS must allow `is_custom = false OR created_by = auth.uid()`; exercise picker has a prominent in-list "Create custom exercise" banner (always visible above the exercise list); custom category supported via "Other (custom)…" dropdown option that reveals a free-text field; `MyExercisesScreen` has a "New Exercise" FAB; `CustomExercisesNotifier` (`lib/features/workout/providers/custom_exercises_notifier.dart`) has `create`, `update`, `delete` — each invalidates `exercisesProvider` so the picker and My Exercises screen reflect changes immediately; custom exercises show "Custom · {muscleGroup}" in purple in the picker; `ExercisePickerScreen` AppBar has an `+` button (`showExerciseFormSheet`) to create inline; `MyExercisesScreen` (`/profile/my-exercises`) lists only user's own custom exercises with edit/delete; accessible from Settings → "My Custom Exercises"
- **`exercise_form_sheet.dart`** (`lib/features/workout/widgets/exercise_form_sheet.dart`): shared bottom sheet for create/edit; uses `UncontrolledProviderScope` to propagate the provider container into the modal; category dropdown populated from catalog (non-custom) exercise categories

## Superset & Warm-up Architecture

### Superset rendering (slot-based)
Both `ActiveWorkoutScreen` and `SessionEditorScreen` use a slot-based list model:
- A **slot** is either a single isolated `ActiveExerciseEntry`/`PlanEditorExercise`, or a `List<...>` representing a superset group
- The outer `ReorderableListView.builder` iterates over slots — superset groups move as one unit
- Isolated exercises render as `_ExerciseCard` / `_ExercisePlanCard` directly
- Superset groups render as `_SupersetWrapper` / `_PlanSupersetWrapper` which contains:
  - A colored header ("Superset N") with a slot-level drag handle (`ReorderableDragStartListener(index: slotIndex)`) and options menu ("Break Superset", "Remove all")
  - An inner `ReorderableListView(shrinkWrap: true, physics: NeverScrollableScrollPhysics())` for within-superset reordering
  - `ReorderableDragStartListener` inside the inner list finds the inner `ReorderableListView` as its nearest ancestor — no conflicts with the outer one

### Provider methods (both `ActiveWorkoutNotifier` and `PlanEditorNotifier`)
- `reorderSlot(oldSlot, newSlot)` — outer slot-level reorder (replaces old flat `reorderExercise`)
- `reorderSessionSlots(week, day, oldSlot, newSlot)` — plan editor equivalent
- `reorderWithinSuperset(groupId, oldIndex, newIndex)` — reorder within a superset group
- `removeSuperset(groupId)` — remove all exercises in the group
- `breakSuperset(groupId)` — set `supersetGroupId = null` on all; they become isolated
- `removeFromSuperset(exerciseId)` — detach one exercise from its group (becomes isolated)
- Helper `_buildSlots()` / `_buildPlanSlots()` — converts flat exercise list to slot list
- Helper `_flattenSlots()` / `_flattenPlanSlots()` — converts slot list back to flat list

### Superset label computation (`_computeLabels` / `_computePlanLabels`)
- Walks exercises sequentially, grouping consecutive exercises with the same `supersetGroupId`
- Each slot increments a counter once; groups get letter suffixes (A, B, C…)
- A lone survivor (group of 1 after other members removed) renders as a plain number, not "1A"

### Superset colors (`_computeSupersetColors` / `_computePlanSupersetColors`)
- 7-color palette cycling: green → amber → blue → pink → purple → deep orange → cyan
- Only groups with ≥ 2 members get a color; lone survivors are neutral (`Colors.white38`)
- Color keyed by `supersetGroupId`, assigned in order of first appearance in the list

### Warm-up sets and set removal
- Tapping the SET column (set number or "W") opens a `showMenu` with three options: "Work Set" / "Warm-up Set" / "Remove Set" (red)
- Toggling work/warmup moves the set to top (warmup) or bottom (work); work sets renumber 1, 2, 3…
- "Remove Set" calls `removeSet(exerciseId, setId)` on `ActiveWorkoutNotifier` — removes the set and renumbers remaining work sets
- Warmup sets display "W" in `Colors.orange.shade300`; excluded from stat chips (weight + set count)
- `isWarmup` persisted in both `session_sets` and `plan_exercise_sets`

### Exercise picker (`ExercisePickerResult`)
- `ExercisePickerScreen(singleSelect: false)` — multi-select; bottom bar with "Add as Superset" + "Add Exercises"
- `ExercisePickerScreen(singleSelect: true)` — single-select (used for swap); no bottom bar
- Router: `/workout/pick-exercise` (multi) vs `/workout/pick-exercise?mode=swap` (single)
- Returns `ExercisePickerResult(exercises: [...], asSuperset: bool)`
- Selection order shown as green CircleAvatar with index number on each selected exercise

### Active plan & 1RM architecture
- `profiles.active_plan_id` — single column storing which plan is currently "active" for the user (null if none); `ON DELETE SET NULL`
- `user_plan_1rm` table — persists 1RM values per (user, plan, exercise); upserted via `PlanActiveNotifier.setActivePlan()` and `update1rm()`; RLS: users manage own rows only
- `activePlanProvider` (in `plan_active_notifier.dart`) — `AsyncNotifier` that reads `profiles.active_plan_id` then fetches the full plan; `keepAlive: true`
- `userPlan1rmProvider(planId)` — family provider returning `Map<exerciseId, double>` from `user_plan_1rm`
- `PlanActiveNotifier` — `setActivePlan(planId, oneRMs)`, `clearActivePlan(planId)`, `update1rm(planId, exerciseId, kg)`, `restartPlan(planId, oneRMs)`
- `clearActivePlan(planId)` — clears `profiles.active_plan_id`, upserts a `restarted_at` timestamp into `user_plan_progress` (resets completed-session counts), invalidates `activePlanProvider` + `planCompletedSessionsProvider(planId)`
- `planCompletedSessionsProvider(planId)` — queries `workout_sessions` filtered by `plan_id`/`user_id`; checks `user_plan_progress.restarted_at` and only counts sessions after that timestamp; gracefully ignores if table query fails
- `startWorkoutFromPlan` in `ActiveWorkoutNotifier` — reads 1RM from `userPlan1rmProvider` directly (no caller-supplied map); handles `prev_week_plus` / `prev_session_plus` by querying past `workout_sessions`

### TARGET column in ActiveWorkoutScreen
- Only shown for plan-based workouts (`state.planId != null`)
- Layout plan-mode: SET(32) · PREV(52) · TARGET(flex) · KG(56) · REPS(52) · CHECK(36)
- Layout free-mode: SET(32) · PREV(90) · spacer · KG(62) · REPS(62) · [RPE(62)] · CHECK(36)
- `ActiveSetEntry.targetText` — pre-computed 2-line string (lines separated by `\n`) built at `startWorkoutFromPlan` time by `_buildTargetText()`; null for free workouts
- `_ExerciseCard` watches `activeWorkoutNotifierProvider` for `state.planId` to compute `showTarget`; passes it to `_TableHeader` and `_SetRow`

## Color Scheme & Icon Variants
- **Theme color persistence**: requires `ALTER TABLE profiles ADD COLUMN IF NOT EXISTS theme_color text;` in Supabase; `ThemeColorNotifier.build()` queries this column on launch; `setColor()` updates state immediately then persists to DB — without the column the DB write fails silently and restarts default to purple
- **Active chip on plan cards**: `_PlanCard` in `plans_list_screen.dart` watches `activePlanProvider`; when `activePlanId == plan.id`, a green pill badge ("Active") is inserted into the `title` `Row` alongside the plan name
- **SVG icon variants**: `assets/icon/icon_blue.svg` / `icon_yellow.svg` / `icon_orange.svg` — source SVGs matching each accent color scheme; splash is build-time only — to change: export SVG to 1024×1024 PNG → replace `assets/icon/icon.png` → update `flutter_native_splash.yaml` `color` → `dart run flutter_native_splash:create` → rebuild APK
