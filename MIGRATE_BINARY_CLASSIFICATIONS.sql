-- ============================================================================
-- MIGRATION: Add numeric score columns to binary_classifications table
-- ============================================================================
-- This adds the description_score, explanation_score, prediction_score columns
-- that the app code expects. The old boolean columns are kept for compatibility.
-- ============================================================================

-- Add description_score column if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'binary_classifications' 
        AND column_name = 'description_score'
    ) THEN
        ALTER TABLE binary_classifications 
        ADD COLUMN description_score NUMERIC;
        
        RAISE NOTICE 'Added description_score column to binary_classifications';
    ELSE
        RAISE NOTICE 'description_score column already exists';
    END IF;
END $$;

-- Add explanation_score column if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'binary_classifications' 
        AND column_name = 'explanation_score'
    ) THEN
        ALTER TABLE binary_classifications 
        ADD COLUMN explanation_score NUMERIC;
        
        RAISE NOTICE 'Added explanation_score column to binary_classifications';
    ELSE
        RAISE NOTICE 'explanation_score column already exists';
    END IF;
END $$;

-- Add prediction_score column if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'binary_classifications' 
        AND column_name = 'prediction_score'
    ) THEN
        ALTER TABLE binary_classifications 
        ADD COLUMN prediction_score NUMERIC;
        
        RAISE NOTICE 'Added prediction_score column to binary_classifications';
    ELSE
        RAISE NOTICE 'prediction_score column already exists';
    END IF;
END $$;

-- Add window_id column if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'binary_classifications' 
        AND column_name = 'window_id'
    ) THEN
        ALTER TABLE binary_classifications 
        ADD COLUMN window_id TEXT;
        
        RAISE NOTICE 'Added window_id column to binary_classifications';
    ELSE
        RAISE NOTICE 'window_id column already exists';
    END IF;
END $$;

-- Verify the columns exist
SELECT 
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'binary_classifications'
  AND column_name IN ('description_score', 'explanation_score', 'prediction_score', 'window_id')
ORDER BY column_name;
