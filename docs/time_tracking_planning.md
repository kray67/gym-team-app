# Time-Based Exercise Tracking — Planning Notes

This document captures open questions and design decisions before implementation.
Start here at the beginning of the next session.

---

## What we want to build

Some exercises are tracked by time (plank, L-sit), distance + time (running, rowing),
or distance only. Currently every exercise uses weight + reps. We need to support
these tracking modes in both the active workout screen and the plan builder.

---

## Open questions

### 1. How should exercises be marked as time-based?

**Option A — Per-exercise flag in the DB (`tracking_type` column on `exercises`)**
- Most flexible. Each exercise row has an explicit tracking type.
- Requires deciding the type for all 602 catalog exercises (most will be `weight_reps`).
- Custom exercises can also get a tracking type when created.

**Option B — Inferred from `category` (equipment type)**
- Simplest. All `Cardio` exercises → `distance_time`; everything else → `weight_reps`.
- Loses precision (e.g. plank is `Bodyweight` but should be `time` not `weight_reps`).

**Recommended: Option A** — add `tracking_type text NOT NULL DEFAULT 'weight_reps'` to `exercises`.

---

### 2. What tracking type values are needed?

| Value | Inputs in active workout | Example exercises |
|---|---|---|
| `weight_reps` | KG + Reps | Squat, Bench, Curl |
| `reps_only` | Reps only | Pull-ups (bodyweight), Push-ups |
| `time` | Duration only (MM:SS) | Plank, L-sit, Rest pause |
| `distance_time` | Distance (km/m) + Duration | Running, Rowing, Cycling |

**Do you need `weight_time`?** (e.g. Farmer's carry for 30 seconds with 40kg)  
**Do you need `distance_only`?** (not tracking time, just distance)

---

### 3. What does a "Time" goal look like in the plan builder?

- Current goal types: `reps` | `reps_range` | `amrap`
- Proposed addition: `time`
  - Plan specifies a target duration per set (e.g. 3 × 60 seconds)
  - Should there be a time range (e.g. 45–60 sec)? Probably not needed initially.
  - For `distance_time`: target is distance (e.g. 3 × 400m) with optional pace target?

---

### 4. Active workout input for timed sets

Two approaches:
- **A) Numeric input field** — user types seconds or min:sec manually after the set.
  - Simple, no extra state management.
  - User must remember to note the time.

- **B) Built-in stopwatch** — a timer the user starts/stops per set; auto-fills duration.
  - Better UX but significantly more complex.
  - Need: running timer state per set, start/stop button in the set row, display.

**Which do you prefer?** Recommendation: start with A (numeric input) for the first version,
add the stopwatch as an enhancement later.

---

### 5. Distance units

- Show km or metres? Most users think in km for runs, metres for rowing.
- Suggestion: always store as metres in DB (`distance_m` already exists on `session_sets`),
  display as km with 2 decimal places when ≥ 1000m.
- Or: let the exercise define its unit preference (another column).

---

### 6. Which existing exercises need their tracking_type updated?

After adding the column (default `weight_reps`), you would need to run UPDATE statements
for exercises that should be time-based. Examples:

```sql
-- Mark cardio exercises as distance_time
UPDATE exercises SET tracking_type = 'distance_time'
WHERE category = 'Cardio';

-- Mark specific time-only exercises
UPDATE exercises SET tracking_type = 'time'
WHERE name ILIKE '%plank%' OR name ILIKE '%hold%' OR name ILIKE '%carry%';
```

A full review of the 602 catalog exercises may be needed.

---

## Proposed DB changes (when ready)

```sql
-- New tracking type column on exercises
ALTER TABLE exercises
  ADD COLUMN IF NOT EXISTS tracking_type text NOT NULL DEFAULT 'weight_reps';
-- Values: 'weight_reps' | 'reps_only' | 'time' | 'distance_time'

-- New target columns on plan_exercise_sets (for time-based plan goals)
ALTER TABLE plan_exercise_sets
  ADD COLUMN IF NOT EXISTS target_duration_secs int;
ALTER TABLE plan_exercise_sets
  ADD COLUMN IF NOT EXISTS target_distance_m numeric;

-- session_sets already has duration_secs and distance_m — no changes needed there
```

---

## Implementation scope (rough)

1. DB migration (above)
2. Update `Exercise` model: add `trackingType` field
3. Update `exercise_form_sheet.dart`: add tracking type dropdown when creating custom exercises
4. Update `ActiveSetEntry`: the `reps` and `weightKg` fields stay; add nothing (use existing `durationSecs` from session_sets? or keep it only in the save path). Actually need to add `durationSecs` and `distanceM` to `ActiveSetEntry`.
5. Update `ActiveWorkoutScreen._SetRow`: render different input fields based on exercise `trackingType`
6. Update `active_workout_provider.dart → finishWorkout()`: pass `duration_secs` / `distance_m` to session_sets insert
7. Plan builder: add `time` as a new goal type option; show duration input instead of reps fields
8. Update `PlanEditorSet` model: add `targetDurationSecs` and `targetDistanceM`
9. Update `startWorkoutFromPlan`: populate `durationSecs` target text for time-based sets
