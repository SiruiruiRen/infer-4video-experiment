# CORS Proxy Fix - Quick Solution

## Problem

The CORS proxy at `https://tubingen-feedback-cors-proxy.onrender.com` is not allowing requests from the study sites, causing CORS errors.

## Immediate Solution

### Option 1: Fix Existing Proxy (If You Have Access)

If you have access to the Render dashboard for `tubingen-feedback-cors-proxy`:

1. Go to Render dashboard → Your proxy service
2. Check the code/deployment
3. Ensure CORS headers are set correctly:
   ```javascript
   Access-Control-Allow-Origin: https://infer-study-alpha.onrender.com
   Access-Control-Allow-Methods: GET, POST, OPTIONS
   Access-Control-Allow-Headers: Content-Type, Authorization
   ```
4. Redeploy the service

### Option 2: Deploy New Proxy (Recommended)

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
