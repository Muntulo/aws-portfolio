# Use official Node.js 20 slim image (lightweight)
FROM node:20-slim

# Set working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and install dependencies first (caching layer)
COPY package*.json ./
RUN npm install

# Copy the rest of your app code
COPY . .

# Expose the port your app listens on
EXPOSE 8080

# Command to run your app
CMD ["node", "index.js"]