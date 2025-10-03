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

# Now, create a non-root user that will own the files and run the app
RUN useradd -m -u 1000 user
USER user

# Set the working directory in the user's home
WORKDIR /home/user/app

# Set Puppeteer env for this user
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Copy package files and change their ownership to the new user
COPY --chown=user package*.json ./

# Run npm install AS THE NEW USER. This is the key fix.
RUN npm install

# Copy the rest of the app files, and change ownership
COPY --chown=user . .

# The CMD will now run as 'user', who has permission to write to node_modules
CMD ["npm", "run", "render"]
