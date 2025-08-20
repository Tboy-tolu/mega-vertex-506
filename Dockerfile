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
RUN git clone -b main https://github.com/souravkl11/raganork-md /rgnk
WORKDIR /rgnk

# Create temp folder
RUN mkdir -p temp

ENV TZ=Asia/Kolkata

# Install global tools
RUN npm install -g --force yarn pm2

# Install dependencies
RUN yarn install

# Install express for keep-alive
RUN npm install express --legacy-peer-deps

# Copy keep-alive.js into container
COPY keep-alive.js /rgnk/keep-alive.js

# Expose ports
EXPOSE 10000 3000

# Run bot + keep-alive server
CMD pm2 start npm --name bot -- start && node keep-alive.js

