# Base image
FROM node:18

# Install Python
RUN apt-get update && apt-get install -y python3 python3-pip

# Set working dir
WORKDIR /app

# Copy everything
COPY . .

# Install Node deps
WORKDIR /app/server
RUN npm install

# Install Python deps
WORKDIR /app/ai-logic
RUN pip install --no-cache-dir -r requirements.txt

# Build React
WORKDIR /app/client
RUN npm install && npm run build

# Back to root
WORKDIR /app

# Give permission to start script
RUN chmod +x start.sh

EXPOSE 10000

CMD ["./start.sh"]