-- Exercise Catalog Seed
-- Run this in the Supabase SQL Editor
-- All rows are global exercises (is_custom = false, created_by = null)

INSERT INTO exercises (name, category, muscle_group, is_custom, created_by) VALUES

-- ── CHEST ──────────────────────────────────────────────────────────────────
('Barbell Bench Press',         'Chest', 'Chest',           false, null),
('Dumbbell Bench Press',        'Chest', 'Chest',           false, null),
('Incline Barbell Bench Press', 'Chest', 'Upper Chest',     false, null),
('Incline Dumbbell Press',      'Chest', 'Upper Chest',     false, null),
('Decline Bench Press',         'Chest', 'Lower Chest',     false, null),
('Cable Chest Fly',             'Chest', 'Chest',           false, null),
('Dumbbell Chest Fly',          'Chest', 'Chest',           false, null),
('Pec Deck Machine',            'Chest', 'Chest',           false, null),
('Push-Up',                     'Chest', 'Chest',           false, null),
('Chest Dip',                   'Chest', 'Lower Chest',     false, null),
('Landmine Press',              'Chest', 'Upper Chest',     false, null),

-- ── BACK ───────────────────────────────────────────────────────────────────
('Pull-Up',                     'Back',  'Lats',            false, null),
('Chin-Up',                     'Back',  'Lats',            false, null),
('Barbell Row',                 'Back',  'Mid Back',        false, null),
('Dumbbell Row',                'Back',  'Mid Back',        false, null),
('Seated Cable Row',            'Back',  'Mid Back',        false, null),
('Lat Pulldown',                'Back',  'Lats',            false, null),
('T-Bar Row',                   'Back',  'Mid Back',        false, null),
('Deadlift',                    'Back',  'Lower Back',      false, null),
('Romanian Deadlift',           'Back',  'Lower Back',      false, null),
('Back Extension',              'Back',  'Lower Back',      false, null),
('Straight-Arm Pulldown',       'Back',  'Lats',            false, null),
('Face Pull',                   'Back',  'Rear Delts',      false, null),
('Pendlay Row',                 'Back',  'Mid Back',        false, null),

-- ── SHOULDERS ──────────────────────────────────────────────────────────────
('Overhead Press (Barbell)',    'Shoulders', 'Front Delts',  false, null),
('Dumbbell Shoulder Press',    'Shoulders', 'Front Delts',  false, null),
('Arnold Press',               'Shoulders', 'Front Delts',  false, null),
('Lateral Raise',              'Shoulders', 'Side Delts',   false, null),
('Cable Lateral Raise',        'Shoulders', 'Side Delts',   false, null),
('Front Raise',                'Shoulders', 'Front Delts',  false, null),
('Reverse Pec Deck',           'Shoulders', 'Rear Delts',   false, null),
('Dumbbell Rear Delt Fly',     'Shoulders', 'Rear Delts',   false, null),
('Upright Row',                'Shoulders', 'Side Delts',   false, null),
('Shrug (Barbell)',            'Shoulders', 'Traps',        false, null),
('Shrug (Dumbbell)',           'Shoulders', 'Traps',        false, null),

-- ── BICEPS ─────────────────────────────────────────────────────────────────
('Barbell Curl',               'Arms', 'Biceps',            false, null),
('Dumbbell Curl',              'Arms', 'Biceps',            false, null),
('Hammer Curl',                'Arms', 'Biceps',            false, null),
('Incline Dumbbell Curl',      'Arms', 'Biceps',            false, null),
('Preacher Curl',              'Arms', 'Biceps',            false, null),
('Cable Curl',                 'Arms', 'Biceps',            false, null),
('Concentration Curl',         'Arms', 'Biceps',            false, null),
('EZ-Bar Curl',                'Arms', 'Biceps',            false, null),

-- ── TRICEPS ────────────────────────────────────────────────────────────────
('Tricep Pushdown (Cable)',    'Arms', 'Triceps',            false, null),
('Overhead Tricep Extension',  'Arms', 'Triceps',            false, null),
('Skullcrusher',               'Arms', 'Triceps',            false, null),
('Close-Grip Bench Press',     'Arms', 'Triceps',            false, null),
('Tricep Dip',                 'Arms', 'Triceps',            false, null),
('Diamond Push-Up',            'Arms', 'Triceps',            false, null),
('Kickback (Dumbbell)',        'Arms', 'Triceps',            false, null),

-- ── LEGS ───────────────────────────────────────────────────────────────────
('Barbell Back Squat',         'Legs', 'Quadriceps',        false, null),
('Front Squat',                'Legs', 'Quadriceps',        false, null),
('Goblet Squat',               'Legs', 'Quadriceps',        false, null),
('Hack Squat',                 'Legs', 'Quadriceps',        false, null),
('Leg Press',                  'Legs', 'Quadriceps',        false, null),
('Leg Extension',              'Legs', 'Quadriceps',        false, null),
('Bulgarian Split Squat',      'Legs', 'Quadriceps',        false, null),
('Lunge (Barbell)',            'Legs', 'Quadriceps',        false, null),
('Lunge (Dumbbell)',           'Legs', 'Quadriceps',        false, null),
('Romanian Deadlift (Legs)',   'Legs', 'Hamstrings',        false, null),
('Lying Leg Curl',             'Legs', 'Hamstrings',        false, null),
('Seated Leg Curl',            'Legs', 'Hamstrings',        false, null),
('Nordic Hamstring Curl',      'Legs', 'Hamstrings',        false, null),
('Hip Thrust',                 'Legs', 'Glutes',            false, null),
('Glute Bridge',               'Legs', 'Glutes',            false, null),
('Cable Kickback',             'Legs', 'Glutes',            false, null),
('Standing Calf Raise',        'Legs', 'Calves',            false, null),
('Seated Calf Raise',          'Legs', 'Calves',            false, null),
('Donkey Calf Raise',          'Legs', 'Calves',            false, null),
('Step-Up',                    'Legs', 'Quadriceps',        false, null),

-- ── CORE ───────────────────────────────────────────────────────────────────
('Plank',                      'Core', 'Core',              false, null),
('Side Plank',                 'Core', 'Obliques',          false, null),
('Crunch',                     'Core', 'Abs',               false, null),
('Cable Crunch',               'Core', 'Abs',               false, null),
('Hanging Leg Raise',          'Core', 'Abs',               false, null),
('Decline Sit-Up',             'Core', 'Abs',               false, null),
('Ab Wheel Rollout',           'Core', 'Abs',               false, null),
('Russian Twist',              'Core', 'Obliques',          false, null),
('Bicycle Crunch',             'Core', 'Obliques',          false, null),
('Dead Bug',                   'Core', 'Core',              false, null),
('Hollow Hold',                'Core', 'Core',              false, null),
('Dragon Flag',                'Core', 'Abs',               false, null),

-- ── CARDIO ─────────────────────────────────────────────────────────────────
('Treadmill Run',              'Cardio', 'Cardio',          false, null),
('Cycling (Stationary)',       'Cardio', 'Cardio',          false, null),
('Rowing Machine',             'Cardio', 'Cardio',          false, null),
('Jump Rope',                  'Cardio', 'Cardio',          false, null),
('Stair Climber',              'Cardio', 'Cardio',          false, null),
('Elliptical',                 'Cardio', 'Cardio',          false, null),
('Burpee',                     'Cardio', 'Full Body',       false, null),
('Box Jump',                   'Cardio', 'Full Body',       false, null),

-- ── FULL BODY / COMPOUND ───────────────────────────────────────────────────
('Barbell Clean',              'Full Body', 'Full Body',    false, null),
('Barbell Snatch',             'Full Body', 'Full Body',    false, null),
('Kettlebell Swing',           'Full Body', 'Full Body',    false, null),
('Thruster',                   'Full Body', 'Full Body',    false, null),
('Farmer Carry',               'Full Body', 'Full Body',    false, null),
('Turkish Get-Up',             'Full Body', 'Full Body',    false, null)

ON CONFLICT DO NOTHING;
