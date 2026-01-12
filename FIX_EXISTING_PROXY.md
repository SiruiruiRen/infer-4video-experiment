# How to Fix the Existing CORS Proxy

## Current Situation

- **Existing Proxy URL:** `https://tubingen-feedback-cors-proxy.onrender.com`
- **Problem:** Not allowing CORS requests from study sites
- **Solution:** Fix the existing proxy (don't create a new one)

## Steps to Fix

### 1. Access Render Dashboard

1. Go to https://dashboard.render.com/
2. Log in to your account
3. Find the service: `tubingen-feedback-cors-proxy` (or check all your services)

### 2. Check Current Code

Click on the service → Go to "Settings" or "Source" tab to see:
- What repository it's connected to (if any)
- The current code/deployment

### 3. Update CORS Configuration

The proxy needs to allow requests from these origins:

```javascript
const allowedOrigins = [
    'https://infer-study-alpha.onrender.com',
    'https://infer-study-beta.onrender.com',
    'https://infer-study-gamma.onrender.com',
    'https://infer-study-assignment.onrender.com'
];
```

### 4. Use the Reference Code

I've created a working proxy server code in `/cors-proxy-server/server.js` that you can use as a reference or replace your existing code with.

**Key parts that need to be in your proxy:**

```javascript
const express = require('express');
const cors = require('cors');
const fetch = require('node-fetch');

const app = express();

// CORS Configuration - CRITICAL PART
app.use(cors({
    origin: [
        'https://infer-study-alpha.onrender.com',
        'https://infer-study-beta.onrender.com',
        'https://infer-study-gamma.onrender.com',
        'https://infer-study-assignment.onrender.com'
    ],
    credentials: true,
    methods: ['GET', 'POST', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization']
}));

// Handle preflight requests
app.options('*', cors());

// Your OpenAI proxy endpoint
app.post('/api/openai/v1/chat/completions', async (req, res) => {
    // ... forward to OpenAI API
});
```

### 5. Update Methods

**If proxy code is in GitHub:**
1. Update the code in your repository
2. Push changes
3. Render will auto-deploy

**If you need to update directly:**
1. Use Render's "Manual Deploy" option
2. Or connect to a GitHub repo with the updated code

### 6. Verify Environment Variables

Make sure `OPENAI_API_KEY` is set in Render dashboard:
- Go to service → "Environment" tab
- Verify `OPENAI_API_KEY` exists and is correct

### 7. Test After Deployment

1. Wait for deployment to complete (usually 1-2 minutes)
2. Test from your study site:
   - Go to https://infer-study-alpha.onrender.com
   - Try generating feedback
   - Check browser console - CORS errors should be gone

## Quick Test

Test the proxy health endpoint:
```bash
curl https://tubingen-feedback-cors-proxy.onrender.com/health
```

If it returns `{"status":"ok",...}`, the proxy is running.

## Still Having Issues?

If you can't access the existing proxy or it's not working after fixing:
- Use the new proxy code I created in `/cors-proxy-server/`
- Deploy it as a new service
- Update `CORS_PROXY_URL` in your study sites to point to the new URL

But **first, try to fix the existing one** - it's simpler and keeps everything consistent!
