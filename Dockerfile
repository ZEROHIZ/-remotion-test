FROM node:18-bullseye

# Install system dependencies as root first
RUN apt-get update && apt-get install -y \
    ffmpeg \
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
    chromium \
    && rm -rf /var/lib/apt/lists/*

# Set Puppeteer env
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Set working directory
WORKDIR /app

# Copy local files to the container's work directory
COPY . .

# Change the ownership of the app directory and all its contents to the node user
# This is the definitive fix.
RUN chown -R node:node /app

# Switch to the non-root user
USER node

# Run npm install as the 'node' user.
# The user now owns the directory and the files within it.
RUN npm install

# The CMD will run as 'node'
CMD ["npm", "run", "render"]