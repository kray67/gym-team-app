-- Add week_number and session_number to plan_exercises
ALTER TABLE plan_exercises
  ADD COLUMN IF NOT EXISTS week_number integer NOT NULL DEFAULT 1,
  ADD COLUMN IF NOT EXISTS session_number integer NOT NULL DEFAULT 1;
