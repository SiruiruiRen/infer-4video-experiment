// CORS Proxy Server for INFER Study Sites
// Deploy this to Render.com as a web service
// Environment variables needed:
// - OPENAI_API_KEY: Your OpenAI API key

const express = require('express');
const cors = require('cors');
const fetch = require('node-fetch');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// CORS Configuration - Allow all study sites
const allowedOrigins = [
    'https://infer-study-alpha.onrender.com',
    'https://infer-study-beta.onrender.com',
    'https://infer-study-gamma.onrender.com',
    'https://infer-study-assignment.onrender.com',
    'http://localhost:8000',
    'http://localhost:8080',
    'http://127.0.0.1:8000',
    'http://127.0.0.1:8080'
];

// CORS middleware with specific origin handling
app.use(cors({
    origin: function (origin, callback) {
        // Allow requests with no origin (like mobile apps or curl requests)
        if (!origin) return callback(null, true);
        
        if (allowedOrigins.indexOf(origin) !== -1) {
            callback(null, true);
        } else {
            // Log for debugging
            console.log('Blocked origin:', origin);
            callback(new Error('Not allowed by CORS'));
        }
    },
    credentials: true,
    methods: ['GET', 'POST', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization']
}));

// Handle preflight requests
app.options('*', cors());

// Body parser middleware
app.use(express.json());

// Health check endpoint
app.get('/health', (req, res) => {
    res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// OpenAI API proxy endpoint
app.post('/api/openai/v1/chat/completions', async (req, res) => {
    const apiKey = process.env.OPENAI_API_KEY;
    
    if (!apiKey) {
        console.error('OPENAI_API_KEY not set in environment variables');
        return res.status(500).json({ 
            error: { 
                message: 'Server configuration error: OPENAI_API_KEY not set',
                type: 'server_error'
            }
        });
    }

    try {
        console.log('Received request from origin:', req.headers.origin);
        console.log('Request body:', JSON.stringify(req.body, null, 2));

        const response = await fetch('https://api.openai.com/v1/chat/completions', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${apiKey}`
            },
            body: JSON.stringify(req.body)
        });

        const data = await response.json();
        
        // Forward the status code and response
        res.status(response.status).json(data);
        
        console.log('Response status:', response.status);
    } catch (error) {
        console.error('Proxy error:', error);
        res.status(500).json({
            error: {
                message: error.message || 'Internal server error',
                type: 'proxy_error'
            }
        });
    }
});

// Start server
app.listen(PORT, () => {
    console.log(`CORS Proxy Server running on port ${PORT}`);
    console.log('Allowed origins:', allowedOrigins);
    console.log('OpenAI API Key configured:', !!process.env.OPENAI_API_KEY);
});
