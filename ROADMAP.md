# Gym Team App — Roadmap

## Current Status
**Phase 4 (Social) — ✅ Complete**
**Post-Phase 4 Workout UX — ✅ Complete** (multi-select picker, supersets, warm-ups, reordering)
**Post-5B Plan/Workout Improvements — ✅ Complete** (active plan, TARGET column, progressive weight types, plan editor enhancements)
**Phase 5C (Personal Records) — ✅ Complete** (PR detection on finish, live badge in active workout, New Records card in summary, PR badges in history detail)
**Phase 7 (Leaderboard) — ✅ Complete** (Attendance/Records/Lifts leaderboards as 3rd tab in Social; 3 Supabase RPCs)
**Phase 8 (Custom Exercises) — ✅ Complete** (create/edit/delete from picker + Settings; custom exercises tagged in picker)

### Done
- Flutter project scaffolded with all dependencies installed (`pubspec.yaml`)
- Supabase initialized via `flutter_dotenv` (credentials in `.env`)
- Full folder structure created: `core/`, `shared/`, `features/`
- `main.dart` — Supabase init + ProviderScope + runApp
- `app.dart` — MaterialApp.router + dark theme
- `core/router/app_router.dart` — go_router with auth guard + ShellRoute for bottom nav
- `core/theme/app_theme.dart` — Material 3 dark theme
- `core/supabase/supabase_client.dart` — global `supabase` getter
- `shared/widgets/main_scaffold.dart` — bottom NavigationBar (Feed | Workout | Plans | Reports | Profile)
- Auth screens: `LoginScreen` (username + password), `RegisterScreen`
- `AuthNotifier` provider (signIn via username lookup, signUp, signOut)
- Placeholder screens for all 5 bottom nav tabs
- `MyProfileScreen` with sign out button
- Deep link configured in `AndroidManifest.xml` (`io.supabase.gymteam://login-callback/`)
- Android emulator: Pixel 8 API 35 installed and working
- Codegen run successfully (`app_router.g.dart`, `auth_provider.g.dart` generated)
- Supabase database schema fully created (all tables + RLS + trigger + RPC)
- Register and login working end-to-end on emulator

---

## Phase 2 — Core Workout Tracking ✅
**Goal:** Users can log workouts, browse exercise catalog, view history

### Done
- `Exercise` freezed model + 95-exercise Supabase seed (`supabase/seed_exercises.sql`)
- `WorkoutSession` + `SessionExercise` + `SessionSet` freezed models
- `ActiveWorkoutState` / `ActiveExerciseEntry` / `ActiveSetEntry` in-memory models
- `ActiveWorkoutNotifier` (`keepAlive: true`) — start, add exercises, log sets, finish, discard
- `ActiveWorkoutScreen` — timer, per-exercise set rows (kg + reps + complete toggle), discard confirmation
- `ExercisePickerScreen` — search bar + category filter chips + grouped list
- `exercisesProvider` (`keepAlive: true`) — cached exercise catalog
- `WorkoutHistoryScreen` — list with date, duration, exercise count
- `WorkoutDetailScreen` — full session breakdown per exercise/set
- `workoutHistoryProvider` + `workoutDetailProvider` (family)
- Router: `/workout/active`, `/workout/pick-exercise`, `/workout/:id`

---

## Phase 3 — Plans ✅
**Goal:** Users can create, edit, save and start workout plans

### Done
- `WorkoutPlan` + `PlanExercise` freezed models
- `PlanEditorState` / `PlanEditorExercise` in-memory editor models
- `PlansListScreen` — My Plans + Saved tabs
- `PlanDetailScreen` — metadata chips, exercise list, Start Workout button, Save/Unsave for others' plans
- `PlanEditorScreen` — create/edit plan, add/reorder exercises with config sheet (sets, reps, AMRAP, kg / % 1RM)
- `DiscoverPlansScreen` — browse public plans, tap to view/save; shows creator name
- `PlanEditorNotifier` (`keepAlive: true`) — CRUD, reorder, save to Supabase
- `plansProvider` — myPlans, savedPlans, publicPlans, planDetail, isPlanSaved
- `startWorkoutFromPlan` in `ActiveWorkoutNotifier` — pre-populates sets with target weight/reps, 1RM dialog for % 1RM plans
- Router: `/plans`, `/plans/new`, `/plans/discover`, `/plans/:id`, `/plans/:id/edit`

### Post-phase improvements (this session)
- **Plan editor redesigned to card+table layout** — mirrors active workout screen; each exercise is a card with inline per-set rows
- **Per-set targets** — each set has its own reps/intensity values (enables pyramid/drop sets); new `plan_exercise_sets` Supabase table
- **New goal types** — Reps, Reps Range (min–max), AMRAP
- **New intensity types** — % 1RM, RPE, RPE Range (min–max); absolute kg removed from plans
- **Inline type selectors** — goal/intensity type changed directly on the exercise card, no bottom sheet
- `PlanExerciseSet` freezed model added; `PlanEditorSet` in-memory model added
- `startWorkoutFromPlan` updated to read per-set targets; rpe_range mapped to rpe during execution
- **Sign-out redirect fixed** — `GoRouter` now uses `refreshListenable` (`_AuthChangeNotifier`) listening to `supabase.auth.onAuthStateChange`
- **Discover tab shows creator** — `publicPlans` query joins `profiles!owner_id`; displays `display_name ?? username`
- **Plan card subtitles redesigned** — mode-aware format: `X weeks · Yx / week · by {name} · Public/Private`; Discover shows creator name, Saved shows "by You" + visibility if owner else creator name, My Plans always shows "by You" + visibility
- **Saved plans now fetch owner profile** — `savedPlans` query updated to join `profiles!owner_id(username, display_name)` so subtitle can show creator name
- **`@JsonKey` analyzer warnings suppressed** — added `invalid_annotation_target: ignore` to `analysis_options.yaml`; this is a known false-positive from the Dart analyzer when using `@JsonKey` on `@freezed` constructor parameters

---

## Phase 4 — Social ✅
**Goal:** Follow other users, see their activity

### Done
- `follows` table RLS + follow/unfollow logic
- `FeedScreen` — activity feed from followed users (completed workouts)
- `FeedWorkoutDetailScreen` — full workout detail from feed item with reactions + comments
- `UserProfileScreen` — view another user's profile + follow button
- `FollowersScreen` — followers/following lists with tab switching
- `ReactionBar` widget — emoji reactions (❤️💪🔥👏😮) per feed item; writes to `activity_feed` notifications
- `feed_comments` table + `commentsNotifierProvider` — add/delete comments on workouts
- `activity_feed` extended with `target_id uuid` column for routing notifications to the owner
- Notification types: `workout_commented`, `workout_reacted` — appear on owner's feed, route to their own workout history detail
- Feed query uses `.or('actor_id.in.(...),target_id.eq.$userId')` — one query for both activity and notifications
- `workoutFeedItemIdProvider` — looks up feed item ID by `session_id` payload containment filter
- `WorkoutDetailScreen` — converted to `ConsumerStatefulWidget`; shows `ReactionBar` + comments + comment input when a feed item exists for the session
- `WorkoutSummaryScreen` (NEW) — post-workout summary shown after completing a workout; share as text or PNG image
- `ActiveWorkoutScreen._finish()` — navigates to `/workout/done/$sessionId` instead of popping
- `/workout/done/:id` top-level route added before `ShellRoute` to avoid path conflict
- Stat chips unified across all screens: duration · total weight (kg) · sets count
- Exercise table format unified: `N × exercise name | best set (weight × reps)`
- `share_plus` + `path_provider` packages added to `pubspec.yaml`

### Post-phase improvements (workout UX)
- **Multi-select exercise picker** — `ExercisePickerResult` with `exercises` list + `asSuperset` flag; selection order shown as numbered green circles; bottom bar with "Add Exercises" + "Add as Superset"
- **Superset support** — exercises share a `supersetGroupId` UUID; labeled 3A/3B style; each superset gets a unique color from a 7-color palette; wrapper card shows "Superset N" header with drag handle and options (Break Superset, Remove all)
- **Within-superset reordering** — inner `ReorderableListView` inside superset wrapper; nested drag handles work correctly via nearest-ancestor resolution
- **Slot-based outer reordering** — outer `ReorderableListView` works on slots (isolated exercises or whole superset groups); replacing old flat index reorder
- **"Remove from Superset"** — detaches one exercise from its group; if group reaches 1 member, label becomes plain number
- **Warm-up sets** — tap SET column to toggle Work/Warmup via dropdown; warmups sort to top of exercise, display "W" in orange, excluded from stat chips
- **Complete toggle disabled** when reps field is empty
- **Single-survivor supersets** — when only 1 member remains in a group, it displays as a plain number (not "1A")

---

## Phase 5 — Social Expansion
**Goal:** Richer social experience — Users tab, avatar customisation, personal records

### Done

#### 5A — Social tab rename + Users tab ✅
- `SocialScreen` with two sub-tabs: **Feed** + **Users** (`DefaultTabController`)
- `UsersScreen` — lists all users (excluding self) with follow/unfollow button; ordered by `created_at`
- Bottom nav tab renamed "Feed" → "Social", icon changed to `Icons.people`
- Router shell path changed `/feed` → `/social`; login/register redirect updated

#### 5B — Avatar customisation ✅
- Material Icons used as avatars (12 icons, no asset files) — `kAvatarIcons` list, index stored as `avatar_id int` in DB
- 16 solid background colors + 6 gradients — solids stored as `#RRGGBB`, gradients as `gradient:N` in `avatar_color text`
- `UserAvatar` shared widget uses `Container` + `BoxDecoration` (supports gradient); falls back to first letter when `avatar_id` is null; `buildAvatarDecoration(hex)` helper
- `EditProfileScreen`: icon picker in `ExpansionTile` with "Aa" initials option; swatch picker in `ExpansionTile` showing solid + gradient sections
- All `CircleAvatar` user-avatar usages replaced with `UserAvatar` across profile, feed, plans, workout screens
- `WorkoutPlanOwner` model updated with `avatarId`/`avatarColor`; all plan join queries updated to include `avatar_id, avatar_color`
- SQL applied:
  ```sql
  ALTER TABLE profiles ADD COLUMN IF NOT EXISTS avatar_id int;
  ALTER TABLE profiles ADD COLUMN IF NOT EXISTS avatar_color text;
  ```

### Post-5B UI improvements ✅
- **Feed card (`workout_completed`)**: two-line format — bold "{name} completed a workout" + small dimmed stats line (duration · weight · sets) computed from payload exercises
- **Workout history card**: plan name or "Workout" in primary color, then icon-based stat row; history query now joins `workout_plans(title)` and `session_sets(*)` to compute stats
- **`WorkoutSession` model**: added `WorkoutPlanRef` (title only) and `plan` field for the joined plan name
- **Reaction buttons**: smaller padding/font across the app
- **Duration format**: unified to `MM:SS` / `HH:MM:SS` everywhere via `formatDuration()` in `lib/core/utils/formatters.dart`

### Post-5B Plan/Workout Improvements ✅

### SQL applied ✅
```sql
-- Active plan on profile
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS active_plan_id uuid REFERENCES workout_plans(id) ON DELETE SET NULL;

-- 1RM persistence per user per plan
CREATE TABLE IF NOT EXISTS user_plan_1rm (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  plan_id uuid REFERENCES workout_plans(id) ON DELETE CASCADE NOT NULL,
  exercise_id uuid REFERENCES exercises(id) ON DELETE CASCADE NOT NULL,
  one_rm_kg numeric NOT NULL,
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE(user_id, plan_id, exercise_id)
);
ALTER TABLE user_plan_1rm ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own 1RM" ON user_plan_1rm
  USING (user_id = auth.uid()) WITH CHECK (user_id = auth.uid());

-- Progressive weight type: weight increment per set
ALTER TABLE plan_exercise_sets ADD COLUMN IF NOT EXISTS weight_increment numeric;
```

#### Features implemented
- **Active plan ("Set as Active")** — `PlanDetailScreen` has "Set as Active" / "Active Plan ✓" button; on activation collects 1RM for all `%1RM` exercises across all weeks/sessions; 1RMs stored in `user_plan_1rm` table; "Edit 1RM" option in AppBar overflow when plan is active
- **Workout screen active plan buttons** — `WorkoutHistoryScreen` shows two-button bottom bar when active plan set: "[Plan Name]: Start Week X · Day Y" (picks first incomplete session) + "Start New Empty Workout"; FAB shown only when no active plan
- **1RM auto-fill** — `startWorkoutFromPlan` reads stored 1RM from `userPlan1rmProvider` instead of requiring caller to pass map; pre-populates dialog; values persist across sessions
- **New progressive weight types** — `prev_week_plus` ("Last Week +") and `prev_session_plus` ("Last Session +"); plan editor shows "+KG" input per set; at workout start, queries previous session data from DB and adds increment; falls back to empty if no prior data
- **TARGET column in active workout** — plan-based sessions show SET · PREV · TARGET · KG · REPS columns; TARGET shows 2-line pre-computed target text (goal × intensity format); free workouts keep original layout
- **Confirm button in session editor** — AppBar action; active when at least one set has any target configured; pops the screen on press
- **Duplicate day enhancements** — "Copy to same day in all other weeks" quick-select added to copy dialog
- **Duplicate whole week** — new "Duplicate week" menu option; dialog shows checkbox list of target weeks; calls `copyWeek()` in provider
- **Copy from last set** — adding a new set in plan editor copies all field values from the previous set (reps, intensity, weight increment, etc.)
- **RPE clamp to 10** — all RPE input fields in plan editor validate/clamp to ≤ 10 on change

### Post-5B UX / Bug Fixes ✅

#### SQL applied ✅
```sql
-- Plan progress reset tracking (used by clearActivePlan + planCompletedSessionsProvider)
CREATE TABLE IF NOT EXISTS public.user_plan_progress (
  user_id      uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  plan_id      uuid NOT NULL REFERENCES public.workout_plans(id) ON DELETE CASCADE,
  restarted_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, plan_id)
);
ALTER TABLE public.user_plan_progress ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own progress" ON public.user_plan_progress
  FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
```

#### Features / fixes implemented
- **WorkoutHistoryScreen — no FAB flicker**: watches full `AsyncValue` from `activePlanProvider`; nothing shown during loading; after load always uses a bottom bar (never FAB) — single button when no active plan, two buttons when active
- **WorkoutHistoryScreen — no-active-plan banner**: tappable card at top of screen when no active plan; navigates to Plans tab via `context.go('/plans')` (not `push`, which would leave Workout tab highlighted)
- **PlanDetailScreen — icons gated on active plan**: ALL status icons (check ✓, play ▶, empty circle) only shown when the plan is active; non-active plans show no leading icons, title pulls left
- **PlanDetailScreen — inline "Set as Active" prompt**: when plan is not active and session is not completed, expanded session cards show a small inline "Set as Active" `TextButton`; extracted shared `activatePlan(context, ref, plan)` top-level helper used by both this prompt and `_ActivePlanButton`
- **clearActivePlan resets progress**: `clearActivePlan(planId)` now upserts `restarted_at` into `user_plan_progress` so `planCompletedSessionsProvider` ignores old sessions; invalidates both `activePlanProvider` and `planCompletedSessionsProvider`; confirmation dialog text updated to "…all progress will be reset"
- **Remove Set in active workout**: `removeSet(exerciseId, setId)` added to `ActiveWorkoutNotifier`; "Remove Set" (red, `delete_outline`) added as third option in the SET-column `showMenu` (same menu as warm-up toggle) for both plan-mode and free-mode set rows
- **Finish workout confirmation**: `_tryFinish()` counts incomplete sets before saving; shows "X sets not yet completed. Finish anyway?" dialog if any exist
- **Friendly error messages**: `WorkoutDetailScreen` and `FeedWorkoutDetailScreen` show "This workout could not be loaded." (with subtitle) instead of raw `PostgrestException` text; comments sections show "Comments could not be loaded." instead of raw error

#### 5C — Personal records (PRs) ✅

### SQL applied ✅
```sql
CREATE TABLE IF NOT EXISTS exercise_records (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  exercise_id uuid REFERENCES exercises(id) ON DELETE CASCADE,
  record_type text NOT NULL, -- 'max_weight' | 'max_reps' | 'max_volume' | 'estimated_1rm'
  value numeric NOT NULL,
  session_id uuid REFERENCES workout_sessions(id),
  set_id text, -- session_sets.id (text, no FK needed)
  achieved_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE(user_id, exercise_id, record_type)
);
ALTER TABLE exercise_records ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own records" ON exercise_records
  USING (user_id = auth.uid()) WITH CHECK (user_id = auth.uid());
```

##### Features implemented
- **`ExerciseRecord` model** — `lib/features/workout/models/exercise_record.dart`; plain class with `typeLabel` / `valueLabel` helpers; no codegen needed
- **`exercise_records_provider.dart`** — three providers:
  - `userExerciseRecordsProvider` — all user records as `Map<exerciseId, Map<recordType, value>>`; auto-dispose; used for live PR detection
  - `sessionNewRecordsProvider(sessionId)` — records set during a specific session (joins `exercises(name)`); used in summary + detail screens
  - `sessionPrSetIdsProvider(sessionId)` — derives `Set<String>` of set IDs from above; used to badge detail-screen rows
- **`finishWorkout()` PR detection** — after inserting all `session_sets` (now using `.select('id').single()` to capture set IDs), calls `_detectAndSavePrs()` which: groups completed non-warmup sets by exercise; fetches existing records; computes max_weight / max_reps / max_volume / estimated_1rm; batch-upserts improvements; writes `record_set` feed entry if any PRs achieved; errors are non-fatal (wrapped in try/catch)
- **Live "PR" badge in `ActiveWorkoutScreen`** — `_ExerciseCard` watches `userExerciseRecordsProvider`; `_ExerciseCard._isPr()` compares current set values against stored records; completed non-warmup sets that beat any record type show a small amber "PR" chip overlaid in the top-right of the row via `Stack + Positioned`
- **"New Records" section in `WorkoutSummaryScreen`** — watches `sessionNewRecordsProvider`; when non-empty, shows an amber-tinted `_NewRecordsSection` card (trophy icon + grouped by exercise rows) between the shareable card and share buttons
- **PR badges in `WorkoutDetailScreen`** — `_ExerciseDetail` converted to `ConsumerWidget`; watches `sessionPrSetIdsProvider(sessionId)`; passes `isPr: prSetIds.contains(set.id)` to each `_SetRow`; same amber "PR" badge overlay as active workout screen

---

## Phase 6 — Polish
**Goal:** Settings, app icon, release

### Done
- [x] `EditProfileScreen` — update display name, bio, avatar (fully implemented in Phase 5B)
- [x] `SettingsScreen` — sign out + account deletion; `delete_account` Supabase RPC required (SECURITY DEFINER, deletes `auth.users` row which cascades); sign-out moved out of `MyProfileScreen` AppBar
- [x] Splash screen — `flutter_native_splash` package; `#1C1B2E` background + `icon.png` centered; generated via `dart run flutter_native_splash:create`
- [x] App icon — `flutter_launcher_icons` package; adaptive icon (`#1C1B2E` background + `icon_foreground.png`), legacy fallback (`icon.png`); generated via `dart run flutter_launcher_icons`
- [x] Release APK build + sideload to users (working as of Phase 3)

> Reports screen removed — not needed for this app.

### Post-5C PR & UX fixes ✅

### SQL applied ✅
```sql
-- Remove max_reps records (record type was removed from the app)
DELETE FROM exercise_records WHERE record_type = 'max_reps';
```

#### Fixes implemented
- **PR chip logic (active workout)**: replaced per-set `_isPr()` with `_computePrSetIds()` — computes the single best set per record type across all completed non-warmup sets in the exercise; only that set shows the PR chip; earlier sets automatically lose the chip when a better set is logged
- **`max_reps` record type removed**: no longer detected in `_detectAndSavePrs()`, removed from `ExerciseRecord` labels; `max_volume` renamed to "Highest Volume Set", value displayed as `kg` (no "reps")
- **"New Records" card layout**: exercise name left-aligned on its own line, records listed below it, dividers between exercise groups
- **Warmup sets in share card**: fixed `completedCount` in `_ShareCard` to exclude warmup sets (`!s.isWarmup`)
- **Set renumbering bug**: `addSet()` now counts work sets only when assigning the new set number — prevents first work set being numbered 2 when only a warmup exists

---

## Phase 7 — Leaderboard ✅

**Goal:** Show all-users rankings across different timeframes and categories

### SQL applied ✅
```sql
-- Attendance leaderboard
CREATE OR REPLACE FUNCTION get_attendance_leaderboard(period text)
RETURNS TABLE(user_id uuid, username text, display_name text, avatar_id int, avatar_color text, workout_count bigint)
LANGUAGE sql SECURITY DEFINER AS $$
  SELECT p.id, p.username, p.display_name, p.avatar_id, p.avatar_color,
    COUNT(ws.id) AS workout_count
  FROM profiles p
  LEFT JOIN workout_sessions ws ON ws.user_id = p.id
    AND (period = 'all_time'
      OR (period = 'week'  AND ws.started_at >= NOW() - INTERVAL '7 days')
      OR (period = 'month' AND ws.started_at >= NOW() - INTERVAL '30 days'))
  GROUP BY p.id, p.username, p.display_name, p.avatar_id, p.avatar_color
  ORDER BY workout_count DESC, p.username ASC;
$$;

-- PR leaderboard (counts exercise_records rows by achieved_at)
CREATE OR REPLACE FUNCTION get_pr_leaderboard(period text)
RETURNS TABLE(user_id uuid, username text, display_name text, avatar_id int, avatar_color text, pr_count bigint)
LANGUAGE sql SECURITY DEFINER AS $$
  SELECT p.id, p.username, p.display_name, p.avatar_id, p.avatar_color,
    COUNT(er.id) AS pr_count
  FROM profiles p
  LEFT JOIN exercise_records er ON er.user_id = p.id
    AND (period = 'all_time'
      OR (period = 'week'  AND er.achieved_at >= NOW() - INTERVAL '7 days')
      OR (period = 'month' AND er.achieved_at >= NOW() - INTERVAL '30 days'))
  GROUP BY p.id, p.username, p.display_name, p.avatar_id, p.avatar_color
  ORDER BY pr_count DESC, p.username ASC;
$$;

-- Exercise (lifts) leaderboard
CREATE OR REPLACE FUNCTION get_exercise_leaderboard(p_exercise_id uuid, p_record_type text)
RETURNS TABLE(user_id uuid, username text, display_name text, avatar_id int, avatar_color text, value numeric)
LANGUAGE sql SECURITY DEFINER AS $$
  SELECT p.id, p.username, p.display_name, p.avatar_id, p.avatar_color, er.value
  FROM exercise_records er
  JOIN profiles p ON p.id = er.user_id
  WHERE er.exercise_id = p_exercise_id AND er.record_type = p_record_type
  ORDER BY er.value DESC;
$$;
```

### Done
- [x] **Leaderboard tab** added to `SocialScreen` (Feed | Users | Leaderboard — 3 tabs)
- [x] **Attendance** (Week/Month/All Time): workout count per user via `get_attendance_leaderboard` RPC
- [x] **Records** (Week/Month/All Time): PR count per user via `get_pr_leaderboard` RPC (uses `exercise_records.achieved_at`)
- [x] **Lifts** (all-time): pick any exercise + Max Weight / Est. 1RM toggle → ranked list via `get_exercise_leaderboard` RPC
- [x] Medal emojis 🥇🥈🥉 for top 3; value highlighted in gold/silver/bronze
- [x] Zero-count entries hidden (only users with at least 1 result shown)
- [x] Exercise picker uses existing single-select `/workout/pick-exercise?mode=swap` route
- [x] `LeaderboardEntry` model, `leaderboard_provider.dart` (3 `@riverpod` providers + `LeaderboardPeriod` enum), `leaderboard_tab.dart` UI

---

## Phase 8 — Custom Exercises ✅

**Goal:** Users can add their own exercises during workout/plan creation

### SQL applied ✅
```sql
-- Allow users to insert/update/delete their own custom exercises
-- (SELECT policy already covers is_custom=false OR created_by=auth.uid() if default read-all exists)
-- Add insert/update/delete policies for custom exercises:
CREATE POLICY "Users manage own custom exercises" ON exercises
  FOR ALL
  USING (is_custom = false OR created_by = auth.uid())
  WITH CHECK (is_custom = true AND created_by = auth.uid());
```
> If the table already has a permissive read-all policy, split into separate SELECT / INSERT / UPDATE / DELETE policies as needed.

### Done
- [x] `CustomExercisesNotifier` — `create`, `update`, `delete`; each invalidates `exercisesProvider`
- [x] `ExercisePickerScreen` — AppBar `+` button opens `showExerciseFormSheet`; custom exercises shown with "Custom · {muscleGroup}" label in purple
- [x] `exercise_form_sheet.dart` — shared bottom sheet (create/edit); uses `UncontrolledProviderScope`; category dropdown from catalog
- [x] `MyExercisesScreen` — lists user's own custom exercises with edit/delete (confirm dialog)
- [x] `SettingsScreen` — "My Custom Exercises" tile navigates to `/profile/my-exercises`
- [x] Router — `/profile/my-exercises` route added inside profile shell routes

---

## Post-Phase Polish ✅

### SQL applied ✅
```sql
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS theme_color text;
```

### Done
- **Color scheme**: 4 accent colors (Purple/Blue/Yellow/Orange) in Settings → Appearance; `ThemeColorNotifier` persists choice to `profiles.theme_color`; `app.dart` rebuilds `MaterialApp` immediately on change; splash screen color is build-time only (edit `flutter_native_splash.yaml` background color + rebuild to match)
- **Custom exercises UX**: replaced AppBar icon with prominent in-list "Create custom exercise" banner; added "Other (custom)…" category option with free-text input; "New Exercise" FAB on My Exercises screen
- **Leaderboard selector redesign**: replaced `FilterChip` rows with `SegmentedButton` for category (Attendance/Records/Lifts) and period (Week/Month/All Time)
- **Active plan switch confirmation**: `activatePlan()` now checks for an existing active plan and shows "You currently have '{name}' as your active plan. Switching will reset all your progress." dialog before proceeding
- **Active chip on plan cards**: `PlansListScreen` plan cards show a green "Active" badge next to the plan title when `activePlanProvider` returns that plan's ID
- **Warm color tinting fix**: `AppTheme.darkWithSeed()` overrides all Material 3 surface/container colors to neutral dark values + `surfaceTint: Colors.transparent` — prevents yellow/orange seeds from tinting surfaces
- **SVG icon variants**: `assets/icon/icon_blue.svg`, `icon_yellow.svg`, `icon_orange.svg` — source files for per-color app icons; export to PNG + update `flutter_native_splash.yaml` background color + rebuild to apply

---

## Phase 9 — UX Improvements ✅

### SQL applied ✅
```sql
-- Exercise note persisted per session exercise
ALTER TABLE session_exercises ADD COLUMN IF NOT EXISTS note text;
```

### Done
- **Edit/delete custom exercises in exercise picker** — own custom exercises show a `⋮` trailing button with Edit/Delete; Edit opens the existing `showExerciseFormSheet`; Delete shows confirm dialog then calls `CustomExercisesNotifier.delete()`
- **Filter dropdowns in exercise picker** — replaced two scrollable chip rows with two compact inline `DropdownButtonFormField`s (Muscle / Equipment) side by side below the search bar
- **Exercise list sorted alphabetically** — `_filtered()` applies `.sort((a,b) => a.name.compareTo(b.name))`; muscle group section headers removed entirely
- **Exercise note in active workout** — "Add note" / "Edit note" in exercise `⋯` menu; note saved to `session_exercises.note` on finish; displayed in italic below muscle group label
- **Create superset from within workout** — "Add to superset…" in isolated exercise options menu; opens `_SupersetPickerSheet` showing all isolated exercises with the initiating exercise pre-selected; requires ≥ 2 total selected; calls `ActiveWorkoutNotifier.formSuperset()`
- **Add exercise to existing superset** — "Add exercise…" in superset header options menu; opens `_SupersetPickerSheet` for isolated exercises; calls `ActiveWorkoutNotifier.addExercisesToSuperset()`
- **3-dot set options button** — replaced tappable set number column with explicit `⋮` icon (dots) + set number side by side; dots open the Work Set / Warm-up Set / Remove Set menu; set number is now plain text

---

## Phase 10 — Time-Based Exercise Tracking ✅

**Goal:** Support exercises tracked by time and/or distance, not just weight × reps

### SQL applied ✅
```sql
-- Add tracking type to exercise catalog
ALTER TABLE exercises ADD COLUMN IF NOT EXISTS tracking_type text NOT NULL DEFAULT 'weight_reps';

-- Add duration target to plan sets
ALTER TABLE plan_exercise_sets ADD COLUMN IF NOT EXISTS target_duration_secs int;

-- Tag existing exercises by type (see seed_exercises.sql comments for full list)
UPDATE exercises SET tracking_type = 'time' WHERE name IN ('Plank', 'Side Plank', 'Wall Sit', 'Dead Hang', ...);
UPDATE exercises SET tracking_type = 'distance_time' WHERE name IN ('Run', '500m Row', 'Cycling', ...);
UPDATE exercises SET tracking_type = 'weight_time' WHERE name IN ('Farmer''s Walk (Weighted)', 'Suitcase Carry', ...);
UPDATE exercises SET tracking_type = 'reps_only' WHERE name IN ('Push Up', 'Burpee', 'Box Jump', ...);
-- Full UPDATE SQL generated in session — apply from the message in chat history
```

### Done
- [x] `Exercise.trackingType` field added (`@Default('weight_reps')`); codegen run
- [x] `ActiveSetEntry.durationSecs` and `ActiveSetEntry.distanceM` fields added; codegen run
- [x] `ActiveWorkoutNotifier`: `updateSet`/`addSet`/`finishWorkout` handle new fields; `_buildTargetText()` handles `time` goal type
- [x] `ActiveWorkoutScreen` `_SetRow` renders per-tracking-type input columns (KG+Reps, Reps, KG+Time, Time, Km+Time); `_canComplete()` generalized; `_TimeField` widget added
- [x] `PlanEditorSet.targetDurationSecs` + `PlanExerciseSet.targetDurationSecs` added; codegen run
- [x] `PlanEditorNotifier`: `updatePlanSet`/`addSet`/`savePlan` handle `targetDurationSecs`
- [x] Plan session builder: `time` goal type button; MM:SS input per set; intensity selector hidden when goal is `time`; `_PlanTimeField` widget added
- [x] `exercise_form_sheet.dart`: tracking type dropdown added
- [x] `CustomExercisesNotifier`: `create`/`updateExercise` accept + persist `trackingType`
- [x] Exercise picker UX: ⋮/⊕ button order fixed (add always rightmost); label "Muscle" → "Muscle Group"; custom exercises sort before catalog entries
- [x] Web build rebuilt + pushed to Vercel

### Post-Phase 10 UX Fixes ✅
- [x] **Plan editor Difficulty/Equipment**: replaced `SegmentedButton`/`ChoiceChip` with `InputDecorator` + `DropdownButton` (reactive, no `value:` deprecation)
- [x] **Plan session builder Goal/Intensity**: replaced `SegmentedButton`/`ChoiceChip` with `InputDecorator` + `DropdownButton` (reactive); Intensity hidden when Goal = Time
- [x] **Plan editor Avg Duration**: replaced `ChoiceChip` row with `TextField` accepting a number (minutes); labeled "Avg Duration (minutes)"
- [x] **Duplicate drag handle on web**: `buildDefaultDragHandles: false` added to all 4 `ReorderableListView`s (active workout + plan session builder, both outer and inner/superset lists)
- [x] **Workout summary AMRAP/time bug**: `_bestSet()` picks by correct field per tracking type; `_bestSetStr()` renders per-type string
- [x] **Workout detail wrong columns**: `_ExerciseDetail` reads `trackingType`; headers + `_SetRow._valueCols()` render correct columns per type
- [x] **Time input improvements**: HH:MM:SS support; auto-reformat on blur; tappable ℹ icon tooltip on TIME label explaining accepted formats
- [x] **Plan session builder Confirm button**: fixed for time-based exercises (`hasConfiguredSet` now checks `targetDurationSecs != null`)
- [x] **Time-based exercise duration inputs empty on edit**: `startEdit()` in `PlanEditorNotifier` now maps `targetDurationSecs` from DB sets; root cause was missing field mapping
- [x] **Exercise order scrambling (all screens)**: Supabase embedded relations return rows in arbitrary DB order; fixed by sorting after fetch — `startEdit()` sorts exercises by `position` + sets by `setNumber`; `startWorkoutFromPlan()` sorts exercises by `position` + sets by `setNumber`; `plan_detail_screen.dart` session exercise list sorted by `position` + `_setTargetDescription` sets sorted by `setNumber`
- [x] **Set number scrambling in active workout**: `startWorkoutFromPlan()` was iterating over unsorted `pe.sets` — fixed by sorting before `asMap().entries.map()`
- [x] **Superset header number**: decoupled from slot position index; pre-computed `ssNumbers` map counts only superset slots; applied to both `ActiveWorkoutScreen` and `PlanSessionBuilderScreen`
- [x] **Default intensity changed to RPE**: `addExerciseToSession()` + `addSupersetToSession()` in `PlanEditorNotifier` now default `weightType: 'rpe'` instead of `percent_1rm`
- [x] **Plan session builder exercise ⋯ menu**: added Swap Exercise, Add Note, Add to Superset, Remove from Superset options — matches active workout parity; `swapExerciseInSession`, `setNoteOnExercise`, `formSupersetInSession` added to `PlanEditorNotifier`
- [x] **Exercise note in plan session builder**: `note` field added to `PlanEditorExercise` model + `PlanExercise` DB model; persisted in `savePlan()`; loaded in `startEdit()`; displayed as italic text below muscle group label in session builder

### SQL applied ✅
```sql
-- Exercise note on plan exercises
ALTER TABLE plan_exercises ADD COLUMN IF NOT EXISTS note text;

-- Drop vestigial columns (never used, always NULL)
ALTER TABLE plan_exercises
  DROP COLUMN IF EXISTS target_sets,
  DROP COLUMN IF EXISTS target_reps,
  DROP COLUMN IF EXISTS target_weight,
  DROP COLUMN IF EXISTS target_duration;
```

- [x] Web build rebuilt + pushed to Vercel

---

## Phase 11 — Plans System Redesign ✅

**Goal:** Copy-on-activation, unified plan list with filters, Favorites, GymTeam App user, Workout tab split.

### SQL applied ✅
```sql
-- Copy-tracking + soft-delete on workout_plans
ALTER TABLE workout_plans
  ADD COLUMN IF NOT EXISTS source_plan_id uuid REFERENCES workout_plans(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS is_deleted boolean NOT NULL DEFAULT false;

-- Official GymTeam App account marker
ALTER TABLE profiles
  ADD COLUMN IF NOT EXISTS is_official boolean NOT NULL DEFAULT false;

-- Rename saved_plans → plan_favorites
ALTER TABLE saved_plans RENAME TO plan_favorites;

-- RLS: update SELECT policy on workout_plans to cover copies + soft-deleted (owner-readable)
--   Allow: (is_public = true AND source_plan_id IS NULL AND is_deleted = false) OR owner_id = auth.uid()

-- GymTeam App official user (run in Supabase SQL editor):
-- INSERT INTO auth.users (...) — see plan for full SQL
-- UPDATE profiles SET username='gymteam', display_name='GymTeam App', is_official=true WHERE id='<uuid>';
```

### Done
- [x] `WorkoutPlan` model: `sourcePlanId`, `isDeleted` added; `WorkoutPlanOwner.isOfficial` added; codegen run
- [x] `PlanEditorState` model: `isCopy` flag added; codegen run
- [x] `plan_active_notifier.dart` rewritten: `_getOrCreateCopy()` (restore archived copy or deep-copy source); `setActivePlan()` archives current copy then creates/restores copy; `clearActivePlan()` soft-deletes copy; `restartPlan()` upserts `restarted_at` only
- [x] `plans_provider.dart` rewritten: `allPlansProvider` (public + own, non-copy, non-deleted); `userFavoritePlanIdsProvider`; `isPlanFavoritedProvider`; `gymTeamUserIdProvider`; removed `myPlansProvider`, `savedPlansProvider`, `publicPlansProvider`, `isPlanSavedProvider`
- [x] `WorkoutScreen` (new): tabbed wrapper — "Workout" tab (active plan section + options menu: Update 1RM / Restart Plan / Archive Plan / Edit Next Session; next session card; Start Empty Workout button) + "History" tab (existing history list)
- [x] `WorkoutHistoryScreen`: extracted `WorkoutHistoryList` widget (no Scaffold) for use as History tab
- [x] `PlansListScreen` redesigned: single unified list (no tabs); compact filter panel (search + Sessions/wk + Difficulty + Equipment dropdowns + Favorites / GymTeam App / My Plans chips); `_PlanCard` active badge checks `activePlan?.sourcePlanId == plan.id`
- [x] `PlanDetailScreen` updated: source vs copy detection (`isCopy`, `isActivePlan`, `progressPlanId`); edit warning dialog for source plans with copies; "Based on" row for copies; `_FavoriteButton` (plan_favorites) replaces `_SaveButton`; `_ActivePlanButton` → "Active · View Copy →" for active sources; inline activation prompt hidden for copies; `_SaveButton` / `_restartPlan` removed
- [x] `plan_editor_provider.dart`: `startEdit()` sets `isCopy`; `savePlan()` forces `is_public=false` for copies; feed event only fires for new public source plans
- [x] `plan_editor_screen.dart`: `isPublic` toggle hidden when `state.isCopy`
- [x] Router: `/workout` → `WorkoutScreen` (was `WorkoutHistoryScreen`)
- [x] `plan_session_builder_screen.dart`: `myPlansProvider` → `allPlansProvider`
- [x] `discover_plans_screen.dart` deleted

---

## Known Issues / Decisions
- Project moved to `C:\Users\joao.dias\Desktop\flutter_projects\gym-team-app\gym_team` to avoid non-ASCII path (`João`) causing Gradle errors on Windows
- `android/gradle.properties` has `android.overridePathCheck=true` — keep it in place
- `android/gradle.properties` has `org.gradle.daemon=false`, `org.gradle.parallel=false`, `org.gradle.workers.max=1` — required due to corporate Sophos AV holding file locks during Gradle transforms on Windows; builds are slower on first run but cached after
- Flutter auto-upgrades `build.gradle.kts` on each run and reverts `minSdk` to `flutter.minSdkVersion` — this is fine since Flutter's default is already ≥ 21
- Email confirmation is **disabled** in Supabase (unnecessary for a 5-user sideloaded app)
- Login uses **username + password**, not email — `get_email_by_username` RPC looks up email from `profiles` table before calling Supabase auth
- **Discover tab requires two RLS policies in Supabase** — `workout_plans` needs `"public plans are readable" USING (is_public = true)`, and `plan_exercise_sets` needs its own owner + public policies (SQL in plan file)
- **Discover tab only shows other users' plans** — `.neq('owner_id', userId)` is intentional; your own public plans appear in My Plans tab. Need a second account to test the discover flow end-to-end
- **Release APK DNS fix** — `android/app/src/main/AndroidManifest.xml` must declare `<uses-permission android:name="android.permission.INTERNET"/>` explicitly. Without it, DNS resolution silently fails on Xiaomi HyperOS / Android 15 release builds (`errno = 7`). Debug builds work because Flutter's debug engine injects this permission via manifest merger, but the release engine does not on this device.
- **Credentials in release APK** — switched from `flutter_dotenv` to `--dart-define` / `String.fromEnvironment()`. Credentials are baked into the APK at compile time; the `.env` file is only kept for reference.
- **APK size** — `--target-platform android-arm64` produces ~22 MB (arm64 only). Fat APK (no flag) is ~52 MB. arm64 covers all modern Android phones.
- **APK signing** — keystore configured in `android/key.properties`; `build.gradle.kts` uses the release signing config. `isMinifyEnabled = false` / `isShrinkResources = false` — no minification needed for a 5-user sideloaded app.
- **Release APK confirmed working** on Xiaomi Redmi (tanzanite, HyperOS 2.0 / Android 15): login, Supabase connection, all Phase 1–3 features functional.
