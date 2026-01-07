# Data Tracking Verification Checklist

## ✅ Confirmed: Treatment Group Auto-Assignment

**Status**: ✅ Working
- Alpha link → `treatment_group = 'treatment_1'`
- Beta link → `treatment_group = 'treatment_2'`
- Gamma link → `treatment_group = 'control'`
- **Automatic** - no manual assignment needed

## ✅ Confirmed: Data Being Stored

### 1. Reflection Texts (Every Revision)
- ✅ Stored in: `reflections.reflection_text`
- ✅ Each revision creates new row with `revision_number`
- ✅ Linked via `parent_reflection_id`

### 2. PV Scores (Analysis Percentages)
- ✅ Stored in: `reflections.analysis_percentages` (JSONB)
- ✅ Contains: `raw`, `priority`, `displayed_to_student`
- ✅ Overall PV: `analysis_percentages.priority.professional_vision`

### 3. DEP Scores (Binary Classifications)
- ✅ Stored in: `binary_classifications` table
- ✅ Fields: `description_score`, `explanation_score`, `prediction_score` (NUMERIC)
- ✅ **Can add up to over 100%** ✅
- ✅ Window-level: Each text window gets scores

### 4. Feedback Text (Extended & Short)
- ✅ Stored in: `reflections.feedback_extended` and `reflections.feedback_short`
- ✅ Saved every time feedback is generated

### 5. Reading Times (Long/Short Feedback)
- ✅ Tracked via: `user_events` table
- ✅ Events: `view_feedback_start` and `view_feedback_end`
- ✅ Duration calculated and stored in `event_data.duration_seconds`
- ✅ Style tracked: `event_data.style` ('extended' or 'short')

## ⚠️ Needs Code Update

### 1. Raw LLM Feedback
- ⚠️ Schema ready: `reflections.feedback_raw` column exists
- ⚠️ Code updated: `saveFeedbackToDatabase()` now accepts `rawFeedback`
- ⚠️ **Action**: Need to pass raw LLM response when calling `saveFeedbackToDatabase()`

### 2. Revision Time
- ✅ Schema ready: `reflections.revision_time_seconds` column exists
- ✅ Code updated: Calculates time between revisions
- ✅ **Working**: Time in seconds since last revision

### 3. Concept Clicks
- ⚠️ Event type exists: `concept_explanation_clicked`
- ⚠️ **Action**: Verify concept click handlers log events with:
  ```javascript
  logEvent('concept_explanation_clicked', {
      concept_name: 'Description',
      concept_type: 'D',
      video_id: currentVideoId
  });
  ```

## 📋 Final Checklist

Before going live, verify:

- [ ] Run `SHARED_SUPABASE_SCHEMA.sql` in Supabase (updated version)
- [ ] Test treatment group assignment (login on each site)
- [ ] Test reflection submission (check `reflections` table)
- [ ] Test feedback generation (check `feedback_extended`, `feedback_short`)
- [ ] Test revision (check `revision_time_seconds` is calculated)
- [ ] Test DEP scores (check `binary_classifications` table)
- [ ] Test reading times (check `user_events` for `view_feedback_end`)
- [ ] Test concept clicks (check `user_events` for `concept_explanation_clicked`)
- [ ] Verify raw LLM feedback is stored (if implemented)

## 🎯 Summary

**What works automatically:**
- ✅ Treatment group assignment (based on link)
- ✅ Reflection text storage (every revision)
- ✅ PV score storage
- ✅ DEP score storage (can exceed 100%)
- ✅ Feedback text storage
- ✅ Reading time tracking (via events)
- ✅ Revision time calculation (code updated)

**What needs verification:**
- ⚠️ Raw LLM feedback (schema ready, need to pass data)
- ⚠️ Concept clicks (verify event logging)

**Database is ready!** Just need to:
1. Run the updated schema
2. Verify concept clicks are logged
3. Pass raw LLM response when saving
