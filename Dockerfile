# 1. Start from a standard Node.js image
FROM node:18-bullseye

# 2. Install all system dependencies for Puppeteer (Chrome) and FFmpeg
RUN apt-get update && apt-get install -y \
    # FFmpeg
    ffmpeg \
    # Puppeteer dependencies
    ca-certificates \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgbm1 \
    libgcc1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    lsb-release \
    wget \
    xdg-utils \
    # Chromium browser
    chromium \
    # Clean up
    && rm -rf /var/lib/apt/lists/*

# 3. Set up the environment for Puppeteer
# We need to tell Puppeteer to use the Chromium we installed via apt-get
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# 4. Standard project setup
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# 5. Command to run
CMD ["npm", "run", "render"]