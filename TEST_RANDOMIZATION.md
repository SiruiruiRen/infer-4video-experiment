# Testing Randomization Logic

## Overview

The randomization system assigns students to one of three groups based **ONLY on their `student_id`**:
- `treatment_1` → Alpha site (INFER + Tutorial)
- `treatment_2` → Beta site (INFER Only)  
- `control` → Gamma site (Simple Feedback)

## Key Points

1. **Assignment is based ONLY on `student_id`** - not `anonymous_id`
2. **Case-insensitive matching** - "ABC123" and "abc123" are treated as the same
3. **Persistent assignment** - Once assigned, the same student always gets the same group
4. **Balanced assignment** - New students are assigned to the group with the **fewest members** to ensure even distribution
   - If multiple groups have the same minimum count, randomly chooses among them
   - Falls back to pure random if database query fails

## How to Test

### 1. Test Case-Insensitive Matching

```sql
-- Insert a test assignment
INSERT INTO student_assignments (student_id, anonymous_id, treatment_group)
VALUES ('TEST123', 'ANON001', 'treatment_1');

-- Try to query with different cases (should all return the same assignment)
SELECT * FROM student_assignments WHERE UPPER(student_id) = 'TEST123';
SELECT * FROM student_assignments WHERE student_id = 'test123';
SELECT * FROM student_assignments WHERE student_id = 'TEST123';
```

### 2. Test Balanced Distribution

```sql
-- Check distribution of assignments (should be relatively balanced)
SELECT 
    treatment_group,
    COUNT(*) as count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) as percentage
FROM student_assignments
GROUP BY treatment_group
ORDER BY treatment_group;

-- Check distribution balance (difference between max and min)
WITH group_counts AS (
    SELECT 
        treatment_group,
        COUNT(*) as count
    FROM student_assignments
    GROUP BY treatment_group
)
SELECT 
    MAX(count) as max_count,
    MIN(count) as min_count,
    MAX(count) - MIN(count) as difference,
    ROUND(100.0 * (MAX(count) - MIN(count)) / MAX(count), 2) as imbalance_percentage
FROM group_counts;
```

### 3. Test Assignment Persistence

1. Enter student ID "TEST001" on assignment site
2. Note which group is assigned
3. Clear browser data / use incognito
4. Enter same student ID "TEST001" again
5. Should get the **same group** as before

### 4. Test Unique Constraint

```sql
-- Try to insert duplicate (should fail)
INSERT INTO student_assignments (student_id, anonymous_id, treatment_group)
VALUES ('TEST123', 'DIFFERENT_ANON', 'treatment_2');
-- Should fail with unique constraint violation
```

### 5. Test Consent Choice Storage

```sql
-- Update consent choice
UPDATE student_assignments 
SET consent_choice = 'agree' 
WHERE student_id = 'TEST123';

-- Verify it's stored
SELECT student_id, consent_choice, treatment_group 
FROM student_assignments 
WHERE student_id = 'TEST123';
```

## Expected Behavior

1. **First visit**: Student enters ID → Gets randomly assigned → Shows consent page → Redirects to study site
2. **Returning visit**: Student enters ID → Shows existing assignment → Shows consent page with pre-filled choice → Redirects to study site
3. **Same student ID, different anonymous ID**: Should get same group (assignment based on student_id only)

## Verification Queries

```sql
-- Check all assignments
SELECT 
    student_id,
    anonymous_id,
    treatment_group,
    consent_choice,
    assigned_at,
    created_at
FROM student_assignments
ORDER BY created_at DESC;

-- Check for any duplicates (should return 0 rows)
SELECT student_id, COUNT(*) 
FROM student_assignments 
GROUP BY student_id 
HAVING COUNT(*) > 1;

-- Check randomization balance
SELECT 
    treatment_group,
    COUNT(*) as total,
    COUNT(CASE WHEN consent_choice = 'agree' THEN 1 END) as agreed,
    COUNT(CASE WHEN consent_choice = 'disagree' THEN 1 END) as disagreed,
    COUNT(CASE WHEN consent_choice IS NULL THEN 1 END) as no_consent
FROM student_assignments
GROUP BY treatment_group;
```
