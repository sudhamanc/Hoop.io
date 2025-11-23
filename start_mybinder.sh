#!/bin/bash

echo "========================================="
echo "🏀 Hoop.io - MyBinder Setup"
echo "========================================="

# Build frontend for production
echo "Building frontend..."
cd frontend
npm run build
cd ..

# Serve static files from backend
echo "Starting backend with static file serving..."
uvicorn backend.main:app --host 0.0.0.0 --port 8000 &

sleep 5

# Get the proxy URL
BASE_URL=$(echo $JUPYTERHUB_SERVICE_PREFIX | sed 's/\/$//')

echo ""
echo "========================================="
echo "✅ App is ready!"
echo "========================================="
echo "Open this URL in your browser:"
echo "https://hub.gesis.mybinder.org${BASE_URL}/proxy/8000/"
echo "========================================="
echo ""
echo "To stop the server: pkill -f uvicorn"
echo ""
