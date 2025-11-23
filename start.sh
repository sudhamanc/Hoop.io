#!/bin/bash

# Start the FastAPI backend in the background
echo "Starting FastAPI backend..."
uvicorn backend.main:app --host 0.0.0.0 --port 8000 &

# Wait for backend to start
sleep 5

# Start the frontend dev server
echo "Starting React frontend..."
cd frontend
npm run dev -- --host 0.0.0.0 --port 5173

# Keep the script running
wait
