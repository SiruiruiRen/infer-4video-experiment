# Step-by-Step Deployment Guide - INFER 4-Video Experiment

## 🎯 Overview

This guide will walk you through deploying the 4-video experiment version to:
1. **Supabase** - Database (new project)
2. **Render** - Website hosting (static site)

---

## 📋 Part 1: Supabase Setup (Database)

### Step 1.1: Create New Supabase Project

1. Go to [https://supabase.com](https://supabase.com)
2. Sign in (or create account)
3. Click **"New Project"**
4. Fill in:
   - **Name**: `infer-4video-experiment` (or your choice)
   - **Database Password**: Create a strong password (save it!)
   - **Region**: Choose closest to your users
   - **Pricing Plan**: Free tier is fine
5. Click **"Create new project"**
6. Wait 2-3 minutes for project to initialize

### Step 1.2: Get Supabase Credentials

1. In your new project, go to **Settings** (gear icon) → **API**
2. Copy these two values:
   - **Project URL** (looks like: `https://xxxxx.supabase.co`)
   - **anon public** key (starts with `eyJhbGci...`)
3. **Save these** - you'll need them in Step 2

### Step 1.3: Run Database Schema

1. In Supabase dashboard, click **SQL Editor** (left sidebar)
2. Click **"New query"**
3. Open `COMPLETE_DATABASE_SCHEMA.sql` from this folder
4. Copy **ALL** contents
5. Paste into Supabase SQL Editor
6. Click **"Run"** (or press Ctrl+Enter)
7. You should see: `✅ Database schema ready for 4-video experiment!`
8. Verify tables created:
   - Go to **Table Editor** (left sidebar)
   - You should see 4 tables:
     - `participant_progress`
     - `reflections`
     - `binary_classifications`
     - `user_events`

✅ **Supabase Setup Complete!**

---

## 📋 Part 2: Configure Application

### Step 2.1: Update Supabase Credentials

1. Open `app.js` in this folder
2. Find lines **~25-27**:
```javascript
const SUPABASE_URL = 'YOUR_NEW_SUPABASE_URL_HERE';
const SUPABASE_KEY = 'YOUR_NEW_SUPABASE_KEY_HERE';
```
3. Replace with your actual values:
```javascript
const SUPABASE_URL = 'https://xxxxx.supabase.co';  // Your Project URL
const SUPABASE_KEY = 'eyJhbGci...';  // Your anon public key
```

### Step 2.2: Update Video Information (Optional for Testing)

For now, you can use placeholder values. Update later with real videos:

1. Find lines **~40-50** in `app.js`:
```javascript
const VIDEOS = [
    { id: 'video1', name: 'Video 1: [Name]', link: 'VIDEO_LINK_1', password: 'PASSWORD_1' },
    { id: 'video2', name: 'Video 2: [Name]', link: 'VIDEO_LINK_2', password: 'PASSWORD_2' },
    { id: 'video3', name: 'Video 3: [Name]', link: 'VIDEO_LINK_3', password: 'PASSWORD_3' },
    { id: 'video4', name: 'Video 4: [Name]', link: 'VIDEO_LINK_4', password: 'PASSWORD_4' }
];
```

2. For testing, you can use:
```javascript
const VIDEOS = [
    { id: 'video1', name: 'Video 1: Test Video', link: 'https://example.com/video1', password: 'test123' },
    { id: 'video2', name: 'Video 2: Test Video', link: 'https://example.com/video2', password: 'test123' },
    { id: 'video3', name: 'Video 3: Test Video', link: 'https://example.com/video3', password: 'test123' },
    { id: 'video4', name: 'Video 4: Test Video', link: 'https://example.com/video4', password: 'test123' }
];
```

### Step 2.3: Update Qualtrics Survey Links (Optional for Testing)

For testing, you can use placeholder links. Update later with real surveys:

1. Find lines **~50-60** in `app.js`:
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

2. For testing, you can use:
```javascript
const QUALTRICS_SURVEYS = {
    pre: 'https://unc.az1.qualtrics.com/jfe/form/SV_XXXXXXXXX',  // Replace with your pre-survey
    post_video_1: 'https://unc.az1.qualtrics.com/jfe/form/SV_XXXXXXXXX',
    post_video_2: 'https://unc.az1.qualtrics.com/jfe/form/SV_XXXXXXXXX',
    post_video_3: 'https://unc.az1.qualtrics.com/jfe/form/SV_XXXXXXXXX',
    post_video_4: 'https://unc.az1.qualtrics.com/jfe/form/SV_XXXXXXXXX',
    post: 'https://unc.az1.qualtrics.com/jfe/form/SV_XXXXXXXXX'
};
```

**Note**: For testing, you can skip surveys by clicking "Continue" buttons even if surveys aren't set up yet.

✅ **Configuration Complete!**

---

## 📋 Part 3: Deploy to Render

### Step 3.1: Prepare Files for Deployment

1. Make sure all files are in `infer-4video-version` folder:
   - `index.html`
   - `app.js` (with updated credentials)
   - `styles.css`
   - `University-of-Tubingen-01.png`
   - `UNC_logo.avif`

2. **Commit to Git** (if using GitHub):
```bash
cd /Users/sirui/Desktop/tubigen
git add infer-4video-version/
git commit -m "Add 4-video experiment version"
git push origin main
```

### Step 3.2: Create Render Static Site

1. Go to [https://render.com](https://render.com)
2. Sign in (or create account)
3. Click **"New +"** → **"Static Site"**
4. Connect your GitHub repository (or use manual deploy)
5. Fill in:
   - **Name**: `infer-4video-experiment` (or your choice)
   - **Branch**: `main` (or your branch)
   - **Root Directory**: `infer-4video-version`
   - **Build Command**: (leave empty - no build needed)
   - **Publish Directory**: `.` (current directory)
6. Click **"Create Static Site"**
7. Wait 2-3 minutes for deployment

### Step 3.3: Get Your Live URL

1. Once deployed, Render will show your live URL
2. It will look like: `https://infer-4video-experiment.onrender.com`
3. **Save this URL** - this is your live site!

✅ **Render Deployment Complete!**

---

## 📋 Part 4: Testing

### Step 4.1: Test Database Connection

1. Open your live site URL
2. Open browser **Developer Console** (F12 or Right-click → Inspect → Console)
3. Enter a test pseudonym (e.g., `TEST001`)
4. Click "Continue"
5. Check console for:
   - ✅ `Supabase client initialized successfully`
   - ✅ `Supabase connection verified`
   - ✅ `Event logged: participant_registered`

### Step 4.2: Test Progress Tracking

1. In Supabase dashboard, go to **Table Editor**
2. Click `participant_progress` table
3. You should see a new row with:
   - `participant_name`: `TEST001`
   - `assigned_condition`: `control` or `experimental`
   - `videos_completed`: `[]`
   - `pre_survey_completed`: `false`

### Step 4.3: Test Complete Flow

1. **Login**: Enter `TEST001` again
   - Should show "Welcome back! You have completed 0/4 videos"
2. **Pre-Survey**: Click through (or skip if not configured)
3. **Dashboard**: Should show 4 video cards
4. **Start Video**: Click "Start Video" on Video 1
5. **Task Page**: 
   - Enter test reflection text
   - Click "Generate Feedback"
   - Should generate feedback (may take 30-60 seconds)
6. **Submit**: Click "Submit Final Reflection"
7. **Post-Video Survey**: Click through
8. **Return to Dashboard**: Should show Video 1 as completed (✓)

### Step 4.4: Verify Data Collection

1. In Supabase, check `reflections` table:
   - Should see reflection data with analysis percentages
2. Check `binary_classifications` table:
   - Should see multiple rows (one per window analyzed)
3. Check `user_events` table:
   - Should see many events (page views, clicks, etc.)

### Step 4.5: Test Resume Functionality

1. Close browser tab
2. Open site again in new tab
3. Enter same pseudonym (`TEST001`)
4. Should load previous progress
5. Dashboard should show Video 1 as completed

✅ **Testing Complete!**

---

## 🔧 Troubleshooting

### Database Connection Issues

**Problem**: Console shows "Supabase credentials not set"
- **Solution**: Check `app.js` lines 25-27 have correct URL and key

**Problem**: Console shows "Database connection failed"
- **Solution**: 
  1. Verify Supabase project is active
  2. Check RLS policies allow inserts
  3. Verify anon key is correct

### Render Deployment Issues

**Problem**: Site shows 404 or blank page
- **Solution**: 
  1. Check Root Directory is `infer-4video-version`
  2. Verify `index.html` exists in that folder
  3. Check Render build logs

**Problem**: Changes not showing
- **Solution**: 
  1. Re-deploy on Render (click "Manual Deploy")
  2. Clear browser cache
  3. Check if files were committed to Git

### Survey Links Not Loading

**Problem**: Survey iframes show blank
- **Solution**: 
  1. Verify Qualtrics links are correct
  2. Check if surveys allow embedding (iframe)
  3. Test links directly in browser

---

## ✅ Success Checklist

- [ ] Supabase project created
- [ ] Database schema run successfully
- [ ] 4 tables visible in Table Editor
- [ ] `app.js` updated with Supabase credentials
- [ ] Site deployed to Render
- [ ] Live URL works
- [ ] Can login with pseudonym
- [ ] Progress saves to database
- [ ] Can complete video task
- [ ] Feedback generates correctly
- [ ] Resume functionality works

---

## 🎉 You're Ready!

Once all tests pass, your site is ready for:
- ✅ Participant recruitment
- ✅ Data collection
- ✅ Progress monitoring
- ✅ Academic research

**Next Steps:**
1. Update with real video links
2. Update with real Qualtrics survey links
3. Test with a few real participants
4. Monitor data collection in Supabase

---

## 📞 Need Help?

- **Supabase Issues**: Check Supabase dashboard → Logs
- **Render Issues**: Check Render dashboard → Logs
- **Code Issues**: Check browser console (F12)
- **Database Issues**: Check Supabase Table Editor

Good luck with your experiment! 🚀

