-- Run in Supabase SQL Editor

-- Plan-level metadata
ALTER TABLE workout_plans
  ADD COLUMN IF NOT EXISTS weeks integer,
  ADD COLUMN IF NOT EXISTS sessions_per_week integer,
  ADD COLUMN IF NOT EXISTS avg_duration_mins integer,
  ADD COLUMN IF NOT EXISTS difficulty text,
  ADD COLUMN IF NOT EXISTS equipment text;

-- Exercise-level goal type and weight type
ALTER TABLE plan_exercises
  ADD COLUMN IF NOT EXISTS goal_type text NOT NULL DEFAULT 'reps',
  ADD COLUMN IF NOT EXISTS weight_type text NOT NULL DEFAULT 'kg';
