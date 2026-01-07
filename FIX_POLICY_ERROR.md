# Fix: "policy already exists" Error

## Problem

You're getting this error:
```
ERROR: 42710: policy "Allow anonymous insert" for table "participant_progress" already exists
```

This happens because the policies were already created (maybe from a previous run or migration).

## Solution

I've updated `SHARED_SUPABASE_SCHEMA.sql` to:
1. **Drop existing policies first** (using `DROP POLICY IF EXISTS`)
2. **Then create them fresh**

This makes the schema **idempotent** - safe to run multiple times.

## What to Do

1. **Use the updated schema**: The `SHARED_SUPABASE_SCHEMA.sql` file now includes `DROP POLICY IF EXISTS` statements before creating policies.

2. **Run it again**: Copy the updated `SHARED_SUPABASE_SCHEMA.sql` and run it in Supabase SQL Editor.

3. **It should work now**: The schema will drop old policies and create new ones without errors.

## Alternative: Quick Fix Script

If you just want to fix the policies without running the full schema:

```sql
-- Drop and recreate policies
DROP POLICY IF EXISTS "Allow anonymous insert" ON participant_progress;
DROP POLICY IF EXISTS "Allow anonymous select" ON participant_progress;
DROP POLICY IF EXISTS "Allow anonymous update" ON participant_progress;

DROP POLICY IF EXISTS "Allow anonymous insert" ON reflections;
DROP POLICY IF EXISTS "Allow anonymous select" ON reflections;
DROP POLICY IF EXISTS "Allow anonymous update" ON reflections;

DROP POLICY IF EXISTS "Allow anonymous insert" ON binary_classifications;
DROP POLICY IF EXISTS "Allow anonymous select" ON binary_classifications;

DROP POLICY IF EXISTS "Allow anonymous insert" ON user_events;
DROP POLICY IF EXISTS "Allow anonymous select" ON user_events;

-- Recreate them
CREATE POLICY "Allow anonymous insert" ON participant_progress FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow anonymous select" ON participant_progress FOR SELECT USING (true);
CREATE POLICY "Allow anonymous update" ON participant_progress FOR UPDATE USING (true);

CREATE POLICY "Allow anonymous insert" ON reflections FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow anonymous select" ON reflections FOR SELECT USING (true);
CREATE POLICY "Allow anonymous update" ON reflections FOR UPDATE USING (true);

CREATE POLICY "Allow anonymous insert" ON binary_classifications FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow anonymous select" ON binary_classifications FOR SELECT USING (true);

CREATE POLICY "Allow anonymous insert" ON user_events FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow anonymous select" ON user_events FOR SELECT USING (true);
```

Then continue with the rest of the schema (tables, indexes, etc.).
