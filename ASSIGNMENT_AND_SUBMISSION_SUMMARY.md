# Assignment and Submission System Summary

## Overview

This document summarizes the changes made to the assignment system, consent handling, and submission behavior across all three study sites.

## 1. Supabase Structure Changes

### New Column: `consent_choice`
- **Table**: `student_assignments`
- **Type**: `TEXT`
- **Values**: `'agree'` or `'disagree'` or `NULL`
- **Purpose**: Stores the user's consent choice for data use

**Migration File**: `SHARED_SUPABASE_MIGRATION_ADD_CONSENT_CHOICE.sql`

Run this SQL in your Supabase SQL editor to add the column.

## 2. Assignment Site Flow (NEW ORDER)

### Previous Flow:
1. Consent page (read data protection, select consent)
2. ID page (enter student ID and anonymous ID)
3. Redirect to study site

### New Flow:
1. **ID page first** (enter student ID and anonymous ID)
2. **Consent page second** (read data protection, select consent)
3. Redirect to study site

### Key Changes:
- Pages reordered in `index.html`
- After ID submission, shows consent page
- Consent choice is stored in `student_assignments.consent_choice`
- If returning user with existing consent, choice is pre-filled

## 3. Randomization Logic

### How It Works:
1. **Assignment is based ONLY on `student_id`** (not `anonymous_id`)
2. Case-insensitive matching (uppercase stored)
3. If student ID exists in database → use existing assignment
4. If new student ID → randomly assign to one of three groups:
   - `treatment_1` → Alpha (INFER + Tutorial)
   - `treatment_2` → Beta (INFER Only)
   - `control` → Gamma (Simple Feedback)

### Testing:
See `TEST_RANDOMIZATION.md` for detailed testing queries and procedures.

## 4. Consent Choice Storage

### When Stored:
- When user clicks "Continue to Study" on consent page
- Stored in `student_assignments.consent_choice` column

### When Retrieved:
- When returning user visits assignment site
- Pre-fills consent radio buttons if choice exists
- Data protection checkbox is also checked

## 5. Submitted Reflections - Read-Only

### Detection:
- Checks if video is in `participant_progress.videos_completed` array
- If completed, reflection is made read-only

### Behavior:
- **Reflection text**: Read-only, grayed out, cursor disabled
- **Generate button**: Disabled
- **Clear button**: Disabled
- **Revise button**: Hidden
- **Submit button**: Hidden
- **Feedback**: Still visible (read-only)

### Implementation:
- Applied in `loadPreviousReflectionAndFeedbackForVideo()` function
- Checks `currentParticipantProgress?.videos_completed?.includes(videoId)`
- Applied to: Alpha, Beta, Gamma

## 6. Previous Reflection and Feedback Display

### What's Shown:
- **Reflection text**: Previous reflection text is loaded
- **Feedback**: Both extended and short feedback are displayed
- **Analysis distribution**: PV scores are shown (if available)
- **Feedback tabs**: Visible for switching between extended/short

### When Loaded:
- Automatically when user navigates to video task page
- Loads most recent reflection for that video and participant
- Uses `loadPreviousReflectionAndFeedbackForVideo()` function

## 7. Database Queries for Testing

### Check Randomization Distribution:
```sql
SELECT 
    treatment_group,
    COUNT(*) as count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) as percentage
FROM student_assignments
GROUP BY treatment_group
ORDER BY treatment_group;
```

### Check Consent Choices:
```sql
SELECT 
    treatment_group,
    COUNT(*) as total,
    COUNT(CASE WHEN consent_choice = 'agree' THEN 1 END) as agreed,
    COUNT(CASE WHEN consent_choice = 'disagree' THEN 1 END) as disagreed,
    COUNT(CASE WHEN consent_choice IS NULL THEN 1 END) as no_consent
FROM student_assignments
GROUP BY treatment_group;
```

### Check Completed Videos:
```sql
SELECT 
    participant_name,
    videos_completed,
    array_length(videos_completed, 1) as videos_count
FROM participant_progress
WHERE array_length(videos_completed, 1) > 0;
```

## 8. Files Modified

### Assignment Site:
- `infer-study-assignment/index.html` - Reordered pages
- `infer-study-assignment/app.js` - Updated flow, consent storage

### Study Sites (Alpha, Beta, Gamma):
- `app.js` - Added read-only logic for submitted reflections
- `app.js` - Enhanced previous reflection/feedback loading

### Database:
- `SHARED_SUPABASE_MIGRATION_ADD_CONSENT_CHOICE.sql` - New migration

## 9. Next Steps

1. **Run SQL Migration**: Execute `SHARED_SUPABASE_MIGRATION_ADD_CONSENT_CHOICE.sql` in Supabase
2. **Test Randomization**: Use queries in `TEST_RANDOMIZATION.md`
3. **Test Flow**: 
   - Enter ID → Should show consent page
   - Select consent → Should redirect to study site
   - Return with same ID → Should show pre-filled consent
4. **Test Read-Only**: 
   - Submit a reflection
   - Return to video page
   - Verify reflection is read-only and buttons are disabled
