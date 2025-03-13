# Build stage
FROM node:18-alpine AS build

# Set working directory
WORKDIR /app

# Installing dependencies required for compilation
RUN apk add --no-cache python3 make g++

# Copy dependency configuration files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy application source code
COPY . .

# Build the application
RUN npm run build
# Generate Prisma client
RUN npx prisma generate

# Production stage
FROM node:18-slim AS production

# Setting environment variables for production
ENV NODE_ENV=production

# Install required libraries for Prisma
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user to run the application
RUN groupadd -g 1001 nodejs && \
    useradd -u 1001 -g nodejs -s /bin/bash -m astrouser

# Set working directory
WORKDIR /app

# Copy only necessary files from build stage
COPY --from=build --chown=astrouser:nodejs /app/dist ./dist
COPY --from=build --chown=astrouser:nodejs /app/node_modules ./node_modules
COPY --from=build --chown=astrouser:nodejs /app/package*.json ./
COPY --from=build --chown=astrouser:nodejs /app/prisma ./prisma

# Expose the port that the application will use
EXPOSE 4321

# Switch to non-root user
USER astrouser

# Command to start the application
CMD ["node", "./dist/server/entry.mjs"]