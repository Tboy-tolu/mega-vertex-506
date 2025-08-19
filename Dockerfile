# Use Node.js 22 (alpine = lightweight)
FROM node:22-alpine

# Install required system packages
RUN apk add --no-cache \
    git \
    ffmpeg \
    libwebp-tools \
    python3 \
    make \
    g++

# Clone the bot repo
RUN echo "$(date)" && \
    git clone -b main https://github.com/souravkl11/raganork-md /rgnk

# Set working directory
WORKDIR /rgnk

# Create temp folder
RUN mkdir -p temp

# Set timezone
ENV TZ=Asia/Kolkata

# Install global tools
RUN npm install -g --force yarn pm2

# Install bot dependencies
RUN yarn install

# Install express for keep-alive server
RUN npm install express --legacy-peer-deps

# Expose Render's port
EXPOSE 3000

# Start bot and keep-alive server together
CMD ["sh", "-c", "npm start & node server.js"]

