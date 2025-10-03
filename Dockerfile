# Use Remotion's official base image which includes Node, Puppeteer, and FFmpeg
FROM remotion/player:4.0.131

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to leverage Docker cache
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# The command to run when the container starts.
# For now, we'll just start a shell to allow for manual testing in the terminal.
CMD ["/bin/bash"]
