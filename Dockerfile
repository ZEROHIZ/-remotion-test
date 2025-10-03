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

# Set working directory. It will be created as root.
WORKDIR /app

# Copy files AND set ownership in the same step. Do this as ROOT.
COPY --chown=node:node . .

# Now that all files are in place and have the correct ownership,
# switch to the non-root user.
USER node

# Run npm install as the 'node' user.
# This user now owns all the files and the directory, so it can write node_modules.
RUN npm install

# The CMD will run as 'node'
CMD ["npm", "run", "render"]
