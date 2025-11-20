# INFER - 4-Video Experiment Version

## 🎯 Complete Production-Ready Version

This is a **fully functional, academic-ready** version of INFER designed for a **4-video longitudinal experiment** over **2.5 weeks**.

---

## ✅ Features Implemented

### **Core Functionality:**
- ✅ **Login/Resume System** - Pseudonym-based entry with progress tracking
- ✅ **Dashboard** - Shows 4 videos with completion status
- ✅ **Progress Tracking** - Saves progress after each video
- ✅ **4 Video Tasks** - Complete reflection and feedback for each video
- ✅ **6 Qualtrics Surveys** - Pre-survey + 4 post-video + final post-survey
- ✅ **Percentage Explanation** - Explains why scores can exceed 100%
- ✅ **Tab-Switching Detection** - AI usage detection and logging
- ✅ **Complete Data Collection** - All reflections, binary classifications, events stored

### **Data Collection:**
- ✅ **Reflections Table** - Full reflection text, analysis percentages, feedback
- ✅ **Binary Classifications Table** - Window-level LLM scores (D, E, P)
- ✅ **User Events Table** - All interactions, tab switches, AI usage responses
- ✅ **Participant Progress Table** - Video completion, survey status, condition

---

## 📁 Files

### **Application Files:**
- `index.html` - Complete HTML structure (login, dashboard, tasks, surveys)
- `app.js` - Complete JavaScript logic (1900+ lines, all functionality)
- `styles.css` - Styling (copied from main version)

### **Database & Configuration:**
- `COMPLETE_DATABASE_SCHEMA.sql` - All 4 tables with indexes and RLS
- `CONFIGURATION.md` - Step-by-step configuration guide
- `DEPLOYMENT_GUIDE.md` - Complete deployment instructions

### **Documentation:**
- `README.md` - This file
- `START_HERE.md` - Quick start guide

---

## 🚀 Quick Start

### **1. Create New Supabase Database**
1. Go to [supabase.com](https://supabase.com)
2. Create a **NEW project** (separate from main INFER)
3. Copy Project URL and Anon Key

### **2. Run Database Schema**
1. Open Supabase SQL Editor
2. Copy/paste `COMPLETE_DATABASE_SCHEMA.sql`
3. Click "Run"
4. Verify 4 tables created

### **3. Configure Application**
1. Open `app.js`
2. Update `SUPABASE_URL` and `SUPABASE_KEY` (lines ~25-27)
3. Update `VIDEOS` array with your 4 videos (lines ~40-50)
4. Update `QUALTRICS_SURVEYS` with your 6 survey links (lines ~50-60)

### **4. Deploy**
- **Render**: Deploy static site, set publish directory to `infer-4video-version`
- **Netlify**: Drag/drop folder or connect GitHub

### **5. Test**
1. Enter test pseudonym (e.g., A0895)
2. Complete pre-survey
3. Complete one video task
4. Check database for data

---

## 📊 Study Flow

```
Login → Pre-Survey → Dashboard → Video 1 → Post-Video 1 Survey → Dashboard
                                 → Video 2 → Post-Video 2 Survey → Dashboard
                                 → Video 3 → Post-Video 3 Survey → Dashboard
                                 → Video 4 → Post-Video 4 Survey → Dashboard
                                 → Post-Survey → Thank You
```

**Resume Capability:**
- Participants can log in with same pseudonym anytime
- System loads previous progress
- Can continue from where they left off

---

## 🗄️ Database Schema

### **Tables:**
1. **`participant_progress`** - Tracks video completion, surveys, condition
2. **`reflections`** - Stores all reflection data and feedback
3. **`binary_classifications`** - Window-level LLM scores
4. **`user_events`** - All interaction logs

See `COMPLETE_DATABASE_SCHEMA.sql` for full schema.

---

## 🔧 Configuration Required

**Before deploying, you MUST update:**

1. **Supabase Credentials** (`app.js` lines ~25-27)
2. **Video Information** (`app.js` lines ~40-50)
3. **Qualtrics Survey Links** (`app.js` lines ~50-60)

See `CONFIGURATION.md` for detailed instructions.

---

## 📝 Key Differences from Main Version

1. **New Flow**: Login → Dashboard → 4 Videos → Surveys
2. **Progress Tracking**: Saves after each video completion
3. **Resume System**: Participants can return and continue
4. **6 Surveys**: Pre + 4 post-video + final post
5. **Separate Database**: Completely isolated data collection

---

## ✅ Ready for Academic Use

Once configured and deployed:
- ✅ Ready for participant recruitment
- ✅ All data collection features active
- ✅ Progress monitoring available
- ✅ Clean data export for analysis

---

## 📞 Support

- **Configuration Issues**: See `CONFIGURATION.md`
- **Deployment Issues**: See `DEPLOYMENT_GUIDE.md`
- **Database Issues**: Check browser console and Supabase logs

---

## 🎓 Academic Citation

Fütterer, T., Nguyen, H., Ren, S., & Stürmer, K. (2025). INFER - An intelligent feedback system for classroom observation [Computer software]. University of Tübingen & University of North Carolina, Chapel Hill.


