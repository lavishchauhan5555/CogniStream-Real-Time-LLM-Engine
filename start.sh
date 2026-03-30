#!/bin/bash

echo "Activating Python venv..."
source /app/venv/bin/activate

echo "Starting FastAPI..."
cd ai-logic
uvicorn main:app --host 0.0.0.0 --port 8000 &

echo "Starting Node server..."
cd ../server
node Server.js