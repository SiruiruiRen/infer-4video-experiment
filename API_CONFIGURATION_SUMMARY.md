# API Configuration Summary

## OpenAI API Key Setup

### ❌ **DO NOT** put API keys in frontend code (app.js)
- The frontend code does NOT contain API keys (this is correct for security)
- API keys should be stored on the **CORS Proxy Server**

### ✅ **API Key Location: CORS Proxy Server**
- **Server**: `tubingen-feedback-cors-proxy.onrender.com`
- **Where to configure**: On the Render.com dashboard for the CORS proxy service
- **How**: Set as an environment variable (e.g., `OPENAI_API_KEY`) in the proxy server's settings

### Current Setup
- **CORS Proxy URL**: `https://tubingen-feedback-cors-proxy.onrender.com`
- **API Endpoint**: `${CORS_PROXY_URL}/api/openai/v1/chat/completions`
- **Model**: `gpt-4o`

### To Verify API is Working
1. Check CORS proxy server is running on Render.com
2. Verify `OPENAI_API_KEY` environment variable is set on the proxy server
3. Test by clicking "Generate Feedback" and check browser console for errors

---

## Temperature Settings

### All Three Websites (Alpha, Beta, Gamma)

#### Binary Classification (D/E/P Analysis)
- **Temperature**: `0.0`
- **Purpose**: Deterministic classification (Description/Explanation/Prediction)
- **Used in**: `classifyDescription()`, `classifyExplanation()`, `classifyPrediction()`
- **Location**: All three sites use the same temperature for classification

#### Feedback Generation

**Alpha & Beta (INFER Feedback):**
- **Temperature**: `0.3`
- **Purpose**: Generate detailed, structured feedback with some creativity
- **Used in**: `generateWeightedFeedback()` function
- **Model**: `gpt-4o`
- **Max Tokens**: `2000`

**Gamma (Simple Feedback):**
- **Temperature**: `0.3`
- **Purpose**: Generate simple 1-2 sentence feedback
- **Used in**: `generateSimpleFeedback()` function
- **Model**: `gpt-4o`
- **Max Tokens**: `200` (shorter for simple feedback)

### Summary Table

| Website | Binary Classification | Feedback Generation | Max Tokens (Feedback) |
|---------|----------------------|-------------------|---------------------|
| **Alpha** | 0.0 | 0.3 | 2000 |
| **Beta** | 0.0 | 0.3 | 2000 |
| **Gamma** | 0.0 | 0.3 | 200 |

---

## Notes

- **Temperature 0.0**: Used for binary classification to ensure consistent, deterministic results
- **Temperature 0.3**: Used for feedback generation to allow some variation while maintaining quality
- **API Key**: Must be configured on the CORS proxy server, NOT in frontend code
