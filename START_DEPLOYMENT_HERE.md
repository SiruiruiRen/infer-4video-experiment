# 🚀 START HERE - Deploy Your 4-Video Experiment

## 📍 You Are Here

You have a complete, production-ready 4-video experiment version ready to deploy.

---

## 🎯 What You Need (5 minutes each)

### ✅ Step 1: Supabase Database Setup

**Goal**: Create database and run schema

1. **Create Project**
   - Visit: https://supabase.com
   - Click "New Project"
   - Name: `infer-4video-experiment`
   - Choose region, set password
   - Wait 2-3 minutes

2. **Get Credentials**
   - Go to: Settings → API
   - Copy **Project URL** (e.g., `https://xxxxx.supabase.co`)
   https://cvmzsljalmkrehfkqjtc.supabase.co
   - Copy **anon public** key (starts with `eyJhbGci...`)
   eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN2bXpzbGphbG1rcmVoZmtxanRjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM1OTM5MzIsImV4cCI6MjA3OTE2OTkzMn0.0IxG1T574aCCH6pxfn8tgGrzw3XUuDKFPE8YQQkV9T4

3. **Run Schema**
   - Go to: SQL Editor → New Query
   - Open `COMPLETE_DATABASE_SCHEMA.sql`
   - Copy ALL content → Paste → Run
   - Verify: Table Editor shows 4 tables

**✅ Done! Save your credentials for Step 2**

---

### ✅ Step 2: Configure app.js

**Goal**: Connect app to your database

1. **Open** `app.js` in this folder

2. **Find lines 25-27** and replace:
```javascript
// BEFORE:
const SUPABASE_URL = 'YOUR_NEW_SUPABASE_URL_HERE';
const SUPABASE_KEY = 'YOUR_NEW_SUPABASE_KEY_HERE';

// AFTER (use YOUR values from Step 1):
const SUPABASE_URL = 'https://xxxxx.supabase.co';  // Your Project URL
const SUPABASE_KEY = 'eyJhbGci...';  // Your anon key
```

3. **Save** `app.js`

**✅ Done! App is now connected to database**

---

### ✅ Step 3: Deploy to Render

**Goal**: Make website live

**Option A: GitHub (Recommended)**
1. Commit files to Git:
```bash
cd /Users/sirui/Desktop/tubigen
git add infer-4video-version/
git commit -m "Add 4-video experiment version"
git push origin main
```

2. **Deploy on Render**:
   - Visit: https://render.com
   - Click "New +" → "Static Site"
   - Connect GitHub → Select your repo
   - Settings:
     - **Name**: `infer-4video-experiment`
     - **Branch**: `main`
     - **Root Directory**: `infer-4video-version`
     - **Build Command**: (leave empty)
     - **Publish Directory**: `.`
   - Click "Create Static Site"
   - Wait 2-3 minutes

**Option B: Manual Deploy**
1. Visit: https://render.com
2. Click "New +" → "Static Site"
3. Choose "Upload files"
4. Upload entire `infer-4video-version` folder
5. Click "Create Static Site"

**✅ Done! You'll get a live URL like `https://infer-4video-experiment.onrender.com`**

---

### ✅ Step 4: Test It!

**Goal**: Verify everything works

1. **Open your live URL** from Render

2. **Test Login**:
   - Enter pseudonym: `TEST001`
   - Click "Continue"
   - Check browser console (F12) for ✅ messages

3. **Check Database**:
   - Go to Supabase → Table Editor → `participant_progress`
   - Should see new row with `TEST001`

4. **Test Video Task**:
   - Click through pre-survey (or skip)
   - Click "Start Video" on Video 1
   - Enter test reflection text
   - Click "Generate Feedback"
   - Wait 30-60 seconds for feedback
   - Click "Submit Final Reflection"

5. **Verify Data**:
   - Supabase → `reflections` table → Should see reflection data
   - Supabase → `binary_classifications` table → Should see classification rows
   - Supabase → `user_events` table → Should see many events

**✅ Done! Everything works!**

---

## 🎉 Success!

Your site is now:
- ✅ Live on Render
- ✅ Connected to Supabase
- ✅ Collecting data
- ✅ Ready for testing

---

## 📚 Detailed Guides

- **Full Step-by-Step**: See `DEPLOYMENT_STEPS.md`
- **Quick Checklist**: See `QUICK_DEPLOY_CHECKLIST.md`
- **Configuration Details**: See `CONFIGURATION.md`

---

## 🔧 Troubleshooting

**Database not connecting?**
- Check `app.js` lines 25-27 have correct values
- Verify Supabase project is active
- Check browser console (F12) for errors

**Site not loading?**
- Check Render deployment logs
- Verify Root Directory is `infer-4video-version`
- Check `index.html` exists

**Need help?**
- Check browser console (F12) for error messages
- Check Supabase → Logs
- Check Render → Logs

---

## 🚀 Ready to Deploy!

Follow the steps above and you'll be live in ~15 minutes!

Good luck! 🎓


