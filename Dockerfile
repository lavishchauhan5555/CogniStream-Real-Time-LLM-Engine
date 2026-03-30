# Use Node with newer Debian (comes with Python 3.11+ support)
FROM node:18-bullseye

# Install Python 3.11 manually
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv

# Set working dir
WORKDIR /app

# Copy all files
COPY . .

# -----------------------------
# Node backend
# -----------------------------
WORKDIR /app/server
RUN npm install

# -----------------------------
# Python FastAPI setup
# -----------------------------
WORKDIR /app/ai-logic

# Create virtual env
RUN python3 -m venv /app/venv

# Upgrade pip (IMPORTANT)
RUN /app/venv/bin/pip install --upgrade pip

# Install requirements
RUN /app/venv/bin/pip install --no-cache-dir -r requirements.txt

# -----------------------------
# React frontend build
# -----------------------------
WORKDIR /app/client
RUN npm install && npm run build

# -----------------------------
# Start script
# -----------------------------
WORKDIR /app
RUN chmod +x start.sh

EXPOSE 10000

CMD ["./start.sh"]