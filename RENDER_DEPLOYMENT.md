# 🚀 Deploy to Render - Quick Guide

## ✅ Prerequisites (Already Done!)

- ✅ GitHub repository: https://github.com/SiruiruiRen/infer-4video-experiment.git
- ✅ Supabase credentials configured in `app.js`
- ✅ All files pushed to GitHub

---

## 📋 Step-by-Step: Deploy to Render

### Step 1: Go to Render Dashboard

1. Visit: https://dashboard.render.com
2. Sign in (or create account if needed)

### Step 2: Create New Static Site

1. Click **"New +"** button (top right)
2. Select **"Static Site"**

### Step 3: Connect GitHub Repository

1. Click **"Connect account"** if not already connected
2. Authorize Render to access your GitHub
3. Select repository: **`SiruiruiRen/infer-4video-experiment`**

### Step 4: Configure Settings

Fill in these settings:

```
Name: infer-4video-experiment
Branch: main
Root Directory: infer-4video-version
Build Command: (leave empty - no build needed)
Publish Directory: .
```

**Important Settings:**
- **Root Directory**: `infer-4video-version` ⚠️ This is critical!
- **Build Command**: Leave empty (static site, no build)
- **Publish Directory**: `.` (current directory)

### Step 5: Deploy

1. Click **"Create Static Site"**
2. Wait 2-3 minutes for deployment
3. Render will show: **"Live"** when ready

### Step 6: Get Your Live URL

Once deployed, Render will show your live URL:
- Example: `https://infer-4video-experiment.onrender.com`
- **Save this URL!**

---

## ✅ Verify Deployment

### Test 1: Site Loads
1. Open your live URL
2. Should see login page with INFER header

### Test 2: Database Connection
1. Open browser console (F12)
2. Enter pseudonym: `TEST001`
3. Click "Continue"
4. Check console for:
   - ✅ `Supabase client initialized successfully`
   - ✅ `Supabase connection verified`

### Test 3: Database Check
1. Go to Supabase dashboard
2. Table Editor → `participant_progress`
3. Should see new row with `TEST001`

---

## 🔧 Troubleshooting

### Problem: Site shows 404 or blank page

**Solution:**
1. Check Render → Settings → Root Directory is `infer-4video-version`
2. Verify `index.html` exists in that folder
3. Check Render → Logs for errors

### Problem: Database not connecting

**Solution:**
1. Verify Supabase credentials in `app.js` (lines 21-22)
2. Check Supabase project is active
3. Verify database schema was run (`COMPLETE_DATABASE_SCHEMA.sql`)
4. Check browser console (F12) for errors

### Problem: Changes not showing

**Solution:**
1. Make sure changes are committed and pushed to GitHub
2. Render should auto-deploy (or click "Manual Deploy")
3. Clear browser cache
4. Check Render → Deploys for latest deployment

---

## 📝 Next Steps After Deployment

1. **Test Complete Flow**:
   - Login → Pre-survey → Dashboard → Video task → Submit → Post-survey

2. **Verify Data Collection**:
   - Check Supabase tables for data
   - Verify all events are logged

3. **Update Video Links** (when ready):
   - Edit `app.js` lines 26-30
   - Commit and push → Auto-deploys

4. **Update Survey Links** (when ready):
   - Edit `app.js` lines 34-40
   - Commit and push → Auto-deploys

---

## 🎉 Success!

Your site is now live at: `https://infer-4video-experiment.onrender.com`

**Ready for:**
- ✅ Testing with participants
- ✅ Data collection
- ✅ Academic research

---

## 🔗 Important Links

- **GitHub Repo**: https://github.com/SiruiruiRen/infer-4video-experiment
- **Render Dashboard**: https://dashboard.render.com
- **Supabase Dashboard**: https://supabase.com/dashboard/project/cvmzsljalmkrehfkqjtc

---

Good luck with your experiment! 🚀


