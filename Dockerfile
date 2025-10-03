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

# Set Puppeteer env, can be done early
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Create the app directory AND set its ownership to the 'node' user.
# This is the key fix.
RUN mkdir -p /home/node/app && chown -R node:node /home/node/app

# Set the working directory
WORKDIR /home/node/app

# Switch to the non-root user 'node'
USER node

# Now we are the 'node' user, inside a directory we own.
# Copy package files. They will be owned by 'node' automatically.
COPY package*.json ./

# Run npm install as the 'node' user. This should now succeed.
RUN npm install

# Copy the rest of the app files.
COPY . .

# The CMD will run as 'node'
CMD ["npm", "run", "render"]
