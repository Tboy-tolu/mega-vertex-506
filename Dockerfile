FROM node:22-alpine

# Install required packages
RUN apk add --no-cache \
    git \
    ffmpeg \
    libwebp-tools \
    python3 \
    make \
    g++

# Clone the bot source
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

# Expose Render's port
EXPOSE 10000

# Run a tiny Express server + your bot with PM2
CMD pm2 start index.js --name bot && pm2 start "node -e \"const express=require('express');const app=express();app.get('/',(req,res)=>res.send('Bot is alive!'));app.listen(process.env.PORT||10000);\"" --name keepalive && pm2 logs
