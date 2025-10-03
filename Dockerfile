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

# The base image has a 'node' user (UID 1000). We'll use that.
# Set the working directory.
WORKDIR /home/node/app

# Set Puppeteer env
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Copy files and set ownership to the 'node' user.
COPY --chown=node:node package*.json ./

# Switch to the non-root user 'node'
USER node

# Run npm install as the 'node' user.
RUN npm install

# Copy the rest of the files. They will be owned by 'node' because we switched user.
COPY . .

# The CMD will run as 'node'
CMD ["npm", "run", "render"]