# Use Node.js 20 Alpine as base image
FROM node:20-alpine

RUN apk add --no-cache openssl3

# Set working directory
WORKDIR /app

# Copy package files from backend
COPY ../../package*.json ../../yarn.lock ./
COPY ../../nest-cli.json ./
COPY ../../tsconfig*.json ./

# Install dependencies
RUN yarn install

# Copy source code from backend
COPY ../../apps ./apps
COPY ../../libs ./libs
COPY ../../configs ./configs
COPY ../../protos ./protos
COPY ../../utils ./utils
COPY ../../databases ./databases

# Run Prisma generate client
RUN npx prisma generate --schema=databases/auth/schema.prisma

# Build the api-gateway microservice
RUN npm run build api

# Expose HTTP port
EXPOSE 3000

# Start the api-gateway microservice
CMD ["node", "dist/apps/api/main"]