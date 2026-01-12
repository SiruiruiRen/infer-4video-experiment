-- ============================================================================
-- SHARED SUPABASE MIGRATION: Add consent_choice column to student_assignments
-- ============================================================================
-- This adds a column to store the user's consent choice (agree/disagree)
-- ============================================================================

-- Add consent_choice column if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'student_assignments' 
        AND column_name = 'consent_choice'
    ) THEN
        ALTER TABLE student_assignments 
        ADD COLUMN consent_choice TEXT;  -- 'agree' or 'disagree'
        
        RAISE NOTICE 'Added consent_choice column to student_assignments';
    ELSE
        RAISE NOTICE 'consent_choice column already exists';
    END IF;
END $$;

-- Verify the column exists
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'student_assignments' 
AND column_name = 'consent_choice';

-- ============================================================================
-- NOTES:
-- - consent_choice: Stores 'agree' or 'disagree' based on user's choice
-- - NULL if consent hasn't been recorded yet
-- ============================================================================
