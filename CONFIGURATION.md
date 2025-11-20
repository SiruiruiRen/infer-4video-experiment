# Configuration Guide - INFER 4-Video Experiment

## 🔧 Required Configuration

Before deploying, you MUST update these values in `app.js`:

---

## 1. Supabase Database Credentials

**Location:** Lines ~25-27 in `app.js`

```javascript
const SUPABASE_URL = 'YOUR_NEW_SUPABASE_PROJECT_URL';
const SUPABASE_KEY = 'YOUR_NEW_SUPABASE_ANON_KEY';
```

**How to get:**
1. Create new Supabase project
2. Go to Project Settings → API
3. Copy "Project URL" → `SUPABASE_URL`
4. Copy "anon public" key → `SUPABASE_KEY`

---

## 2. Qualtrics Survey Links

**Location:** Lines ~50-60 in `app.js`

```javascript
const QUALTRICS_SURVEYS = {
    pre: 'https://unc.az1.qualtrics.com/jfe/form/SV_XXXXXXXXX',  // Pre-survey
    post_video_1: 'https://unc.az1.qualtrics.com/jfe/form/SV_XXXXXXXXX',  // After video 1
    post_video_2: 'https://unc.az1.qualtrics.com/jfe/form/SV_XXXXXXXXX',  // After video 2
    post_video_3: 'https://unc.az1.qualtrics.com/jfe/form/SV_XXXXXXXXX',  // After video 3
    post_video_4: 'https://unc.az1.qualtrics.com/jfe/form/SV_XXXXXXXXX',  // After video 4
    post: 'https://unc.az1.qualtrics.com/jfe/form/SV_XXXXXXXXX'  // Final post-survey
};
```

**How to get:**
1. Create surveys in Qualtrics
2. Get "Anonymous Link" for each survey
3. Make sure surveys allow embedding (iframe)

---

## 3. Video Information

**Location:** Lines ~40-50 in `app.js`

```javascript
const VIDEOS = [
    { 
        id: 'video1', 
        name: 'Video 1: [Name]', 
        link: 'https://sharepoint.com/video1', 
        password: 'PASSWORD1' 
    },
    { 
        id: 'video2', 
        name: 'Video 2: [Name]', 
        link: 'https://sharepoint.com/video2', 
        password: 'PASSWORD2' 
    },
    { 
        id: 'video3', 
        name: 'Video 3: [Name]', 
        link: 'https://sharepoint.com/video3', 
        password: 'PASSWORD3' 
    },
    { 
        id: 'video4', 
        name: 'Video 4: [Name]', 
        link: 'https://sharepoint.com/video4', 
        password: 'PASSWORD4' 
    }
];
```

**Update:**
- `name`: Display name for each video
- `link`: Full URL to video (SharePoint, YouTube, etc.)
- `password`: Password if video is password-protected

---

## 4. Condition Assignment (Optional)

**Location:** Lines ~70-80 in `app.js`

By default, conditions are assigned randomly (50/50). To change:

```javascript
function assignCondition(participantName) {
    // Option 1: Random assignment (default)
    return Math.random() < 0.5 ? 'control' : 'experimental';
    
    // Option 2: Based on participant name
    // const hash = participantName.charCodeAt(0);
    // return hash % 2 === 0 ? 'control' : 'experimental';
    
    // Option 3: All experimental
    // return 'experimental';
}
```

---

## ✅ Verification Checklist

Before going live, verify:

- [ ] Supabase URL and key are correct
- [ ] Database schema has been run (`COMPLETE_DATABASE_SCHEMA.sql`)
- [ ] All 6 Qualtrics survey links are correct
- [ ] All 4 video links work and passwords are correct
- [ ] Test login with a pseudonym works
- [ ] Test completing one video task
- [ ] Check database for data collection
- [ ] Test resume functionality (login again with same pseudonym)

---

## 🚨 Important Notes

1. **Separate Database**: This version uses a NEW Supabase database (separate from main INFER)
2. **No Interference**: Won't affect the main version
3. **Clean Data**: All January 2025 experiment data is isolated
4. **Academic Ready**: All features are production-ready

---

## 📞 Support

If you encounter issues:
1. Check browser console for errors
2. Verify Supabase connection in Network tab
3. Check database tables exist
4. Verify RLS policies allow inserts


