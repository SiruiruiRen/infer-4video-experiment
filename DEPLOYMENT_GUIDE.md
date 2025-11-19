# Deployment Guide - INFER 4-Video Experiment

## 🎯 Overview

This is a complete, production-ready 4-video experiment version of INFER with:
- ✅ Login/Resume system with pseudonym
- ✅ Dashboard showing 4 videos with progress
- ✅ Pre-survey + 4 post-video questionnaires + final post-survey
- ✅ Complete data collection (reflections, binary classifications, events)
- ✅ Tab-switching detection (cheating detection)
- ✅ Percentage explanation (>100% due to multiple codes)

---

## 📋 Prerequisites

1. **New Supabase Project** (separate from main version)
2. **Qualtrics Survey Links** (pre-survey, 4 post-video surveys, final post-survey)
3. **Video Links** (4 teaching videos)
4. **CORS Proxy** (same as main version)

---

## 🗄️ Step 1: Create New Supabase Database

1. Go to [supabase.com](https://supabase.com)
2. Create a **NEW project** (separate from main INFER project)
3. Note down:
   - Project URL (e.g., `https://xxxxx.supabase.co`)
   - Anon/Public Key (starts with `eyJhbGci...`)

---

## 🗄️ Step 2: Run Database Schema

1. Open Supabase SQL Editor
2. Copy and paste contents of `COMPLETE_DATABASE_SCHEMA.sql`
3. Click "Run"
4. Verify all 4 tables created:
   - `participant_progress`
   - `reflections`
   - `binary_classifications`
   - `user_events`

---

## ⚙️ Step 3: Configure Application

### Update `app.js`:

1. **Supabase Credentials** (lines ~25-27):
```javascript
const SUPABASE_URL = 'YOUR_NEW_SUPABASE_URL';
const SUPABASE_KEY = 'YOUR_NEW_SUPABASE_KEY';
```

2. **Qualtrics Survey Links** (lines ~50-60):
```javascript
const QUALTRICS_SURVEYS = {
    pre: 'YOUR_PRE_SURVEY_LINK',
    post_video_1: 'YOUR_POST_VIDEO_1_LINK',
    post_video_2: 'YOUR_POST_VIDEO_2_LINK',
    post_video_3: 'YOUR_POST_VIDEO_3_LINK',
    post_video_4: 'YOUR_POST_VIDEO_4_LINK',
    post: 'YOUR_FINAL_POST_SURVEY_LINK'
};
```

3. **Video Information** (lines ~40-50):
```javascript
const VIDEOS = [
    { id: 'video1', name: 'Video 1 Name', link: 'VIDEO_LINK_1', password: 'PASSWORD_1' },
    { id: 'video2', name: 'Video 2 Name', link: 'VIDEO_LINK_2', password: 'PASSWORD_2' },
    { id: 'video3', name: 'Video 3 Name', link: 'VIDEO_LINK_3', password: 'PASSWORD_3' },
    { id: 'video4', name: 'Video 4 Name', link: 'VIDEO_LINK_4', password: 'PASSWORD_4' }
];
```

---

## 🚀 Step 4: Deploy to Render/Netlify

### Option A: Render (Static Site)

1. Create new Static Site on Render
2. Connect GitHub repository
3. Build command: (leave empty)
4. Publish directory: `infer-4video-version`
5. Deploy!

### Option B: Netlify

1. Drag and drop `infer-4video-version` folder
2. Or connect GitHub and set publish directory to `infer-4video-version`

---

## ✅ Step 5: Verify Deployment

1. **Test Login**: Enter a test pseudonym (e.g., A0895)
2. **Check Database**: Verify `participant_progress` table gets a new row
3. **Test Video Task**: Complete one video task
4. **Check Data**: Verify data appears in `reflections`, `binary_classifications`, `user_events`

---

## 📊 Step 6: Monitor Data Collection

### Check Progress:
```sql
SELECT 
    participant_name,
    assigned_condition,
    array_length(videos_completed, 1) as videos_done,
    pre_survey_completed,
    post_survey_completed
FROM participant_progress
ORDER BY last_active_at DESC;
```

### Check Reflections:
```sql
SELECT 
    participant_name,
    video_id,
    COUNT(*) as reflection_count,
    MAX(revision_number) as max_revisions
FROM reflections
GROUP BY participant_name, video_id;
```

---

## 🔧 Troubleshooting

### Database Connection Issues:
- Check Supabase URL and key are correct
- Verify RLS policies allow inserts
- Check browser console for errors

### Survey Links Not Loading:
- Verify Qualtrics links are correct
- Check if surveys allow embedding (iframe)
- Test links in browser directly

### Progress Not Saving:
- Check `participant_progress` table exists
- Verify participant_name is unique
- Check browser console for errors

---

## 📝 Notes

- **Separate Database**: This version uses a completely separate Supabase database
- **No Interference**: Won't affect the main INFER version
- **Clean Data**: All data for January 2025 experiment is isolated
- **Academic Ready**: All data collection features are production-ready

---

## 🎓 Ready for Academic Use!

Once deployed and tested, the site is ready for:
- ✅ Participant recruitment
- ✅ Data collection
- ✅ Progress monitoring
- ✅ Export for analysis

