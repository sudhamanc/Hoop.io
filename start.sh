#!/bin/bash

# Start the FastAPI backend in the background
echo "Starting FastAPI backend..."
uvicorn backend.main:app --host 0.0.0.0 --port 8000 &

# Wait for backend to start
sleep 5

# Detect if running in MyBinder and set API URL accordingly
# In MyBinder, we need to use the proxy URL structure
if [ -n "$JUPYTERHUB_SERVICE_PREFIX" ]; then
    # Extract base URL and construct backend proxy URL
    # The URL pattern is: /user/{username}/proxy/{port}/
    BASE_URL=$(echo $JUPYTERHUB_SERVICE_PREFIX | sed 's/\/$//')
    export VITE_API_URL="${BASE_URL}/proxy/8000"
    echo "MyBinder detected - Backend API will be at: $VITE_API_URL"
else
    # Running locally
    echo "Local environment - using localhost:8000"
fi

# Start the frontend dev server
echo "Starting React frontend..."
cd frontend
npm run dev -- --host 0.0.0.0 --port 5173

# Keep the script running
wait
