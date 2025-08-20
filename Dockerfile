FROM node:22-alpine

# Install required packages
RUN apk add --no-cache \
    git \
    ffmpeg \
    libwebp-tools \
    python3 \
    make \
    g++

# Clone the bot repo
RUN echo "$(date)" && git clone -b main https://github.com/souravkl11/raganork-md /rgnk

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

# Expose both ports
EXPOSE 10000 3000

# Start bot and keep-alive server simultaneously
CMD pm2 start npm --name bot -- start && node keep-alive.js
