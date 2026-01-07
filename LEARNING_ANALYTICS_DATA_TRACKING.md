# Learning Analytics Data Tracking - Complete Checklist

## ✅ Data That IS Being Tracked

### 1. Treatment Group Assignment
- ✅ **Automatic based on link**: Alpha → `treatment_1`, Beta → `treatment_2`, Gamma → `control`
- ✅ Stored in: `participant_progress.treatment_group`
- ✅ Set automatically when participant first logs in

### 2. Reflection Texts
- ✅ **Every revision stored**: Each time user submits/revises reflection
- ✅ Stored in: `reflections.reflection_text`
- ✅ Linked by: `parent_reflection_id` (revision chains)
- ✅ Tracked: `revision_number` (1, 2, 3, etc.)

### 3. PV Scores (Analysis Percentages)
- ✅ **Stored each time**: Every time feedback is generated
- ✅ Stored in: `reflections.analysis_percentages` (JSONB)
  - `raw`: Raw percentages (D/E/P/Other)
  - `priority`: Weighted percentages
  - `displayed_to_student`: What student sees
- ✅ Overall PV score: `analysis_percentages.priority.professional_vision`

### 4. DEP Scores (Binary Classifications)
- ✅ **Window-level scores**: Each text window gets D/E/P scores
- ✅ Stored in: `binary_classifications` table
  - `description_score`: NUMERIC (0-100+)
  - `explanation_score`: NUMERIC (0-100+)
  - `prediction_score`: NUMERIC (0-100+)
  - **Can add up to over 100%** (as requested)
- ✅ Linked to reflection via: `reflection_id`

### 5. Feedback Reading Times
- ✅ **Tracked via events**: `view_feedback_start` and `view_feedback_end`
- ✅ Stored in: `user_events` table
- ✅ Event data includes:
  - `style`: 'extended' or 'short'
  - `duration_seconds`: Time spent reading
- ✅ Query example:
  ```sql
  SELECT 
    event_data->>'style' as feedback_style,
    AVG((event_data->>'duration_seconds')::NUMERIC) as avg_reading_time
  FROM user_events
  WHERE event_type IN ('view_feedback_end')
  GROUP BY event_data->>'style';
  ```

### 6. Feedback Text (Extended & Short)
- ✅ **Both versions stored**: Every time feedback is generated
- ✅ Stored in: `reflections.feedback_extended` and `reflections.feedback_short`

## ⚠️ Data That NEEDS TO BE ADDED

### 1. Raw LLM Feedback
- ⚠️ **Status**: Schema has `feedback_raw` column, but code needs to store it
- ⚠️ **Action needed**: Update `saveFeedbackToDatabase()` to store raw LLM response
- ⚠️ **Location**: `reflections.feedback_raw`

### 2. Revision Time
- ⚠️ **Status**: Schema has `revision_time_seconds` column, but code needs to calculate it
- ⚠️ **Action needed**: Calculate time between revisions and store it
- ⚠️ **Location**: `reflections.revision_time_seconds`
- ⚠️ **Logic**: Time between `parent_reflection_id.created_at` and current `created_at`

### 3. Concept Clicks
- ⚠️ **Status**: Event type exists (`concept_explanation_clicked`), but need to verify it's being logged
- ⚠️ **Action needed**: Ensure concept click handlers log events
- ⚠️ **Location**: `user_events` with `event_type = 'concept_explanation_clicked'`
- ⚠️ **Event data should include**: `{concept_name: TEXT, concept_type: TEXT}`

## 📊 Database Schema Summary

### `participant_progress`
- `treatment_group`: Auto-set based on link ✅
- `videos_completed`: Array of completed videos ✅
- `tutorial_watched`: For Alpha only ✅

### `reflections`
- `reflection_text`: Every revision ✅
- `analysis_percentages`: PV scores (JSONB) ✅
- `feedback_extended`: Formatted extended feedback ✅
- `feedback_short`: Formatted short feedback ✅
- `feedback_raw`: **NEEDS CODE UPDATE** ⚠️
- `revision_number`: Revision count ✅
- `revision_time_seconds`: **NEEDS CODE UPDATE** ⚠️
- `parent_reflection_id`: Links revisions ✅

### `binary_classifications`
- `description_score`: NUMERIC (0-100+) ✅
- `explanation_score`: NUMERIC (0-100+) ✅
- `prediction_score`: NUMERIC (0-100+) ✅
- `window_text`: Text window analyzed ✅
- `reflection_id`: Links to reflection ✅

### `user_events`
- `event_type`: Type of event ✅
- `event_data`: JSONB with event details ✅
- Tracks: feedback viewing, concept clicks, revisions, etc. ✅

## 🔍 How to Query the Data

### Get all reflections with scores:
```sql
SELECT 
    r.participant_name,
    r.video_id,
    r.revision_number,
    r.reflection_text,
    r.analysis_percentages->'priority'->>'professional_vision' as pv_score,
    r.revision_time_seconds,
    r.feedback_raw,
    r.feedback_extended,
    r.feedback_short
FROM reflections r
ORDER BY r.participant_name, r.video_id, r.revision_number;
```

### Get DEP scores for a reflection:
```sql
SELECT 
    window_text,
    description_score,
    explanation_score,
    prediction_score,
    (description_score + explanation_score + prediction_score) as total_score
FROM binary_classifications
WHERE reflection_id = 'YOUR_REFLECTION_ID'
ORDER BY window_index;
```

### Get reading times:
```sql
SELECT 
    participant_name,
    video_id,
    event_data->>'style' as feedback_style,
    AVG((event_data->>'duration_seconds')::NUMERIC) as avg_reading_time_seconds
FROM user_events
WHERE event_type = 'view_feedback_end'
GROUP BY participant_name, video_id, event_data->>'style';
```

### Get concept clicks:
```sql
SELECT 
    participant_name,
    video_id,
    event_data->>'concept_name' as concept,
    COUNT(*) as click_count
FROM user_events
WHERE event_type = 'concept_explanation_clicked'
GROUP BY participant_name, video_id, event_data->>'concept_name';
```

## ✅ Next Steps

1. **Update app.js** to:
   - Store raw LLM response in `feedback_raw`
   - Calculate and store `revision_time_seconds`
   - Ensure concept clicks are logged

2. **Verify tracking** by:
   - Testing each feature
   - Checking database after actions
   - Running verification queries

3. **Test with real participants** to ensure all data is captured
