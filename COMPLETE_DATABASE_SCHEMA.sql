-- =====================================================
-- COMPLETE DATABASE SCHEMA FOR 4-VIDEO EXPERIMENT
-- =====================================================
-- Run this in Supabase SQL Editor to create ALL tables
-- =====================================================

-- Table 1: Participant Progress Tracking
CREATE TABLE IF NOT EXISTS participant_progress (
    id BIGSERIAL PRIMARY KEY,
    participant_name TEXT UNIQUE NOT NULL,
    assigned_condition TEXT CHECK (assigned_condition IN ('control', 'experimental')),
    videos_completed TEXT[] DEFAULT '{}',
    pre_survey_completed BOOLEAN DEFAULT FALSE,
    post_survey_completed BOOLEAN DEFAULT FALSE,
    video_surveys JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    last_active_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table 2: Reflections (stores all reflection data)
CREATE TABLE IF NOT EXISTS reflections (
    id BIGSERIAL PRIMARY KEY,
    session_id TEXT NOT NULL,
    participant_name TEXT NOT NULL,
    video_id TEXT NOT NULL,
    language TEXT DEFAULT 'en',
    task_id TEXT,
    reflection_text TEXT NOT NULL,
    analysis_percentages JSONB NOT NULL,
    weakest_component TEXT,
    feedback_extended TEXT,
    feedback_short TEXT,
    revision_number INTEGER DEFAULT 1,
    parent_reflection_id BIGINT REFERENCES reflections(id),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table 3: Binary Classifications (window-level scores from LLM)
CREATE TABLE IF NOT EXISTS binary_classifications (
    id BIGSERIAL PRIMARY KEY,
    session_id TEXT NOT NULL,
    reflection_id BIGINT REFERENCES reflections(id),
    task_id TEXT,
    participant_name TEXT,
    video_id TEXT,
    language TEXT,
    window_id TEXT NOT NULL,
    window_text TEXT,
    description_score INTEGER CHECK (description_score IN (0, 1)),
    explanation_score INTEGER CHECK (explanation_score IN (0, 1)),
    prediction_score INTEGER CHECK (prediction_score IN (0, 1)),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table 4: User Events (all interaction logs)
CREATE TABLE IF NOT EXISTS user_events (
    id BIGSERIAL PRIMARY KEY,
    session_id TEXT NOT NULL,
    reflection_id BIGINT REFERENCES reflections(id),
    event_type TEXT NOT NULL,
    event_data JSONB,
    user_agent TEXT,
    language TEXT,
    timestamp_utc TIMESTAMPTZ DEFAULT NOW()
);

-- =====================================================
-- INDEXES FOR PERFORMANCE
-- =====================================================

-- Participant Progress Indexes
CREATE INDEX IF NOT EXISTS idx_progress_participant ON participant_progress(participant_name);
CREATE INDEX IF NOT EXISTS idx_progress_condition ON participant_progress(assigned_condition);
CREATE INDEX IF NOT EXISTS idx_progress_last_active ON participant_progress(last_active_at);

-- Reflections Indexes
CREATE INDEX IF NOT EXISTS idx_reflections_session ON reflections(session_id);
CREATE INDEX IF NOT EXISTS idx_reflections_task ON reflections(task_id);
CREATE INDEX IF NOT EXISTS idx_reflections_participant ON reflections(participant_name);
CREATE INDEX IF NOT EXISTS idx_reflections_video ON reflections(video_id);
CREATE INDEX IF NOT EXISTS idx_reflections_created ON reflections(created_at);

-- Binary Classifications Indexes
CREATE INDEX IF NOT EXISTS idx_classifications_reflection ON binary_classifications(reflection_id);
CREATE INDEX IF NOT EXISTS idx_classifications_session ON binary_classifications(session_id);
CREATE INDEX IF NOT EXISTS idx_classifications_task ON binary_classifications(task_id);
CREATE INDEX IF NOT EXISTS idx_classifications_participant ON binary_classifications(participant_name);
CREATE INDEX IF NOT EXISTS idx_classifications_video ON binary_classifications(video_id);

-- User Events Indexes
CREATE INDEX IF NOT EXISTS idx_events_session ON user_events(session_id);
CREATE INDEX IF NOT EXISTS idx_events_type ON user_events(event_type);
CREATE INDEX IF NOT EXISTS idx_events_reflection ON user_events(reflection_id);
CREATE INDEX IF NOT EXISTS idx_events_timestamp ON user_events(timestamp_utc);

-- =====================================================
-- ROW LEVEL SECURITY (RLS)
-- =====================================================

ALTER TABLE participant_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE reflections ENABLE ROW LEVEL SECURITY;
ALTER TABLE binary_classifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_events ENABLE ROW LEVEL SECURITY;

-- Create policies to allow all operations (for research data collection)
CREATE POLICY "Allow all operations on participant_progress" 
ON participant_progress FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations on reflections" 
ON reflections FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations on binary_classifications" 
ON binary_classifications FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations on user_events" 
ON user_events FOR ALL USING (true) WITH CHECK (true);

-- =====================================================
-- VERIFICATION QUERIES
-- =====================================================

-- Check all tables exist
SELECT 
    'participant_progress' as table_name, COUNT(*) as row_count FROM participant_progress
UNION ALL
SELECT 'reflections', COUNT(*) FROM reflections
UNION ALL
SELECT 'binary_classifications', COUNT(*) FROM binary_classifications
UNION ALL
SELECT 'user_events', COUNT(*) FROM user_events;

-- Check a participant's progress
SELECT * FROM participant_progress WHERE participant_name = 'A0895';

-- Get all participants with their progress
SELECT 
    participant_name,
    assigned_condition,
    array_length(videos_completed, 1) as videos_done,
    pre_survey_completed,
    post_survey_completed,
    last_active_at
FROM participant_progress
ORDER BY last_active_at DESC;

-- =====================================================
-- COMPLETE!
-- =====================================================
SELECT '✅ Database schema ready for 4-video experiment!' as status;

