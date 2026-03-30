# Base image
FROM node:18-bullseye

# Install Python + venv
RUN apt-get update && apt-get install -y python3 python3-venv python3-pip

# Set working dir
WORKDIR /app

# Copy everything
COPY . .

# -----------------------------
# 📦 Install Node Backend
# -----------------------------
WORKDIR /app/server
RUN npm install

# -----------------------------
# 🤖 Setup Python (FastAPI)
# -----------------------------
WORKDIR /app/ai-logic

# Create virtual environment
RUN python3 -m venv /app/venv

# Install Python dependencies inside venv
RUN /app/venv/bin/pip install --no-cache-dir -r requirements.txt

# -----------------------------
# 🎨 Build React Frontend
# -----------------------------
WORKDIR /app/client
RUN npm install && npm run build

# -----------------------------
# 🚀 Final Setup
# -----------------------------
WORKDIR /app

# Make start script executable
RUN chmod +x start.sh

# Expose port (Render uses this)
EXPOSE 10000

# Start app
CMD ["./start.sh"]