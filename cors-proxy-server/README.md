# CORS Proxy Server for INFER Study Sites

This is a CORS proxy server that allows the INFER study sites (alpha, beta, gamma, assignment) to make requests to the OpenAI API.

## Deployment to Render.com

### Step 1: Create New Web Service on Render

1. Go to [Render Dashboard](https://dashboard.render.com/)
2. Click "New +" → "Web Service"
3. Connect your GitHub repository (or create a new one for this proxy)

### Step 2: Configure Build Settings

- **Name:** `tubingen-feedback-cors-proxy` (or your preferred name)
- **Environment:** Node
- **Build Command:** `npm install`
- **Start Command:** `npm start`
- **Plan:** Free (or paid if you need more resources)

### Step 3: Set Environment Variables

In Render dashboard, go to "Environment" tab and add:

```
OPENAI_API_KEY=your_openai_api_key_here
```

**Important:** Replace `your_openai_api_key_here` with your actual OpenAI API key.

### Step 4: Deploy

Click "Create Web Service" and wait for deployment to complete.

### Step 5: Update Study Sites

Once deployed, update the `CORS_PROXY_URL` in all study sites to match your new Render URL:

```javascript
const CORS_PROXY_URL = isProduction 
    ? 'https://your-proxy-name.onrender.com'  // Update this
    : 'http://localhost:3000';
```

## Local Development

1. Install dependencies:
```bash
npm install
```

2. Create `.env` file:
```
OPENAI_API_KEY=your_openai_api_key_here
```

3. Run server:
```bash
npm start
```

The server will run on `http://localhost:3000`

## Allowed Origins

The proxy is configured to allow requests from:
- `https://infer-study-alpha.onrender.com`
- `https://infer-study-beta.onrender.com`
- `https://infer-study-gamma.onrender.com`
- `https://infer-study-assignment.onrender.com`
- `http://localhost:8000` (local development)
- `http://localhost:8080` (local development)

To add more origins, edit the `allowedOrigins` array in `server.js`.

## Testing

Test the proxy health endpoint:
```bash
curl https://your-proxy-name.onrender.com/health
```

Should return:
```json
{"status":"ok","timestamp":"2025-01-XX..."}
```

## Troubleshooting

### CORS Errors
- Make sure your study site URL is in the `allowedOrigins` array
- Check that the proxy URL in your study site matches the Render deployment URL
- Verify the proxy is running (check Render logs)

### API Key Errors
- Verify `OPENAI_API_KEY` is set in Render environment variables
- Check Render logs for error messages

### 500 Errors
- Check Render logs for detailed error messages
- Verify OpenAI API key is valid
- Check that request body format matches OpenAI API requirements
