# Fix: "Could not find the 'description_score' column" Error

## Problem

You're getting this error:
```
Error storing binary classifications: {code: 'PGRST204', details: null, hint: null, message: "Could not find the 'description_score' column of 'binary_classifications' in the schema cache"}
```

## Cause

The `binary_classifications` table exists but has the **old structure** with boolean columns:
- `is_description` (BOOLEAN)
- `is_explanation` (BOOLEAN)  
- `is_prediction` (BOOLEAN)

But the app code expects **numeric score columns**:
- `description_score` (NUMERIC)
- `explanation_score` (NUMERIC)
- `prediction_score` (NUMERIC)

The `CREATE TABLE IF NOT EXISTS` in the schema doesn't modify existing tables - it only creates them if they don't exist.

## Solution

Run the migration script to add the missing columns:

1. **Go to Supabase Dashboard → SQL Editor**
2. **Copy and paste `MIGRATE_BINARY_CLASSIFICATIONS.sql`**
3. **Click Run**

This will:
- ✅ Add `description_score` column (if missing)
- ✅ Add `explanation_score` column (if missing)
- ✅ Add `prediction_score` column (if missing)
- ✅ Add `window_id` column (if missing)
- ✅ Keep old boolean columns (for compatibility)

## Alternative: Drop and Recreate (If No Important Data)

If you don't have important data in `binary_classifications`, you can drop and recreate:

```sql
-- Drop the old table
DROP TABLE IF EXISTS binary_classifications CASCADE;

-- Then run the full SHARED_SUPABASE_SCHEMA.sql again
-- (it will create the table with correct structure)
```

## Verify It Worked

After running the migration, verify the columns exist:

```sql
SELECT 
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'binary_classifications'
  AND column_name IN ('description_score', 'explanation_score', 'prediction_score', 'window_id')
ORDER BY column_name;
```

You should see all 4 columns listed.

## Why This Happened

The table was created with the old schema (boolean columns), but the app code was updated to use numeric scores. The migration script bridges this gap by adding the new columns without losing existing data.
