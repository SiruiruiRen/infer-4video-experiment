# CORS Proxy Fix - Quick Solution

## Problem

The **existing** CORS proxy at `https://tubingen-feedback-cors-proxy.onrender.com` is not allowing requests from the study sites, causing CORS errors.

## Solution: Fix the EXISTING Proxy (Recommended)

**You should fix the existing proxy** - no need to create a new one!

### Step 1: Access Render Dashboard

1. Go to [Render Dashboard](https://dashboard.render.com/)
2. Find the service named `tubingen-feedback-cors-proxy` (or similar)
3. Click on it to view details

### Step 2: Check/Update the Proxy Code

The proxy needs to allow CORS from your study sites. The code should include:

```javascript
// Allow requests from study sites
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
```

### Step 3: Update and Redeploy

1. If you have the code in a GitHub repo, update it and push
2. If you need to update directly in Render, use the code I created in `/cors-proxy-server/server.js` as a reference
3. Redeploy the service on Render

### Step 4: Verify

After redeploying, test from your study site - the CORS errors should be gone.

---

## Alternative: If You Can't Access the Existing Proxy

### Option 2: Deploy New Proxy (Only if you can't fix the existing one)

I've created a new proxy server code in `/cors-proxy-server/` directory.

**Steps:**

1. **Deploy to Render:**
   - Create new Web Service on Render
   - Connect GitHub repo (or upload the `cors-proxy-server` folder)
   - Set environment variable: `OPENAI_API_KEY=your_key`
   - Deploy

2. **Update Study Sites:**
   - Update `CORS_PROXY_URL` in all three sites (alpha, beta, gamma)
   - Change from `https://tubingen-feedback-cors-proxy.onrender.com` to your new URL
   - Commit and push changes

3. **Test:**
   - Try generating feedback on alpha site
   - Check browser console for errors
   - Verify feedback is generated successfully

### Option 3: Use Public CORS Proxy (Temporary)

As a temporary workaround, you could use a public CORS proxy, but this is **NOT recommended** for production:

```javascript
const CORS_PROXY_URL = isProduction 
    ? 'https://corsproxy.io/?'  // Public proxy (not secure)
    : 'http://localhost:3000';
```

**Warning:** Public proxies are not secure and may expose your API keys. Use only for testing.

## Files Created

- `/cors-proxy-server/server.js` - Express server with CORS configuration
- `/cors-proxy-server/package.json` - Node.js dependencies
- `/cors-proxy-server/README.md` - Deployment instructions

## Next Steps

1. Deploy the new proxy server to Render
2. Update the `CORS_PROXY_URL` in all study sites
3. Test feedback generation
4. Monitor for any errors

## Verification

After deploying, test the proxy:

```bash
# Health check
curl https://your-new-proxy.onrender.com/health

# Should return: {"status":"ok","timestamp":"..."}
```

Then test from the study site - feedback generation should work without CORS errors.
