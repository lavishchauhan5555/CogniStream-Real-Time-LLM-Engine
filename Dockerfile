# -----------------------------
# Base Image (Node + Debian Bookworm → Python 3.11)
# -----------------------------
FROM node:18-bookworm

# Install Python 3.11 + venv
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------
# App Setup
# -----------------------------
WORKDIR /app
COPY . .

# -----------------------------
# Node Backend
# -----------------------------
WORKDIR /app/server
RUN npm install

# -----------------------------
# FastAPI (Python)
# -----------------------------
WORKDIR /app/ai-logic

# Create virtual environment
RUN python3 -m venv /app/venv

# Upgrade pip
RUN /app/venv/bin/pip install --upgrade pip

# Install Python dependencies
RUN /app/venv/bin/pip install --no-cache-dir -r requirements.txt

# -----------------------------
# React Frontend
# -----------------------------
WORKDIR /app/client
RUN npm install && npm run build

# -----------------------------
# Start Script
# -----------------------------
WORKDIR /app
RUN chmod +x start.sh

EXPOSE 10000

CMD ["./start.sh"]