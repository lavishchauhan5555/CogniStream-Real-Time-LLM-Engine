#!/bin/bash

# Start FastAPI in background
cd ai-logic
uvicorn main:app --host 0.0.0.0 --port 8000 &

# Start Node server
cd ../server
node index.js