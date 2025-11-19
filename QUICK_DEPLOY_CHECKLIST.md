# Quick Deployment Checklist

## ⚡ Quick Reference

### 1️⃣ Supabase (5 minutes)

- [ ] Go to [supabase.com](https://supabase.com) → New Project
- [ ] Name: `infer-4video-experiment`
- [ ] Copy **Project URL** and **anon key** from Settings → API
- [ ] SQL Editor → Paste `COMPLETE_DATABASE_SCHEMA.sql` → Run
- [ ] Verify 4 tables created in Table Editor

### 2️⃣ Update app.js (2 minutes)

- [ ] Line 25: `SUPABASE_URL = 'https://xxxxx.supabase.co'`
- [ ] Line 26: `SUPABASE_KEY = 'eyJhbGci...'`
- [ ] (Optional) Update VIDEOS array (lines 26-30)
- [ ] (Optional) Update QUALTRICS_SURVEYS (lines 32-38)

### 3️⃣ Render (5 minutes)

- [ ] Go to [render.com](https://render.com) → New Static Site
- [ ] Connect GitHub repo (or manual deploy)
- [ ] Root Directory: `infer-4video-version`
- [ ] Publish Directory: `.`
- [ ] Build Command: (leave empty)
- [ ] Deploy!

### 4️⃣ Test (5 minutes)

- [ ] Open live URL
- [ ] Enter pseudonym: `TEST001`
- [ ] Check browser console for ✅ messages
- [ ] Check Supabase `participant_progress` table for new row
- [ ] Complete one video task
- [ ] Verify data in `reflections` table

---

## 🔗 Important Links

- **Supabase Dashboard**: https://supabase.com/dashboard
- **Render Dashboard**: https://dashboard.render.com
- **Your Live Site**: `https://your-site.onrender.com`

---

## 📝 Credentials to Save

```
Supabase Project URL: https://xxxxx.supabase.co
Supabase Anon Key: eyJhbGci...
Render Site URL: https://your-site.onrender.com
```

---

## ✅ Done!

Once all checked, your site is live and ready for testing! 🚀

