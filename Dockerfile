
# Use Node.js LTS version with pnpm
FROM node:20-alpine

# Install pnpm globally
RUN corepack enable && corepack prepare pnpm@latest --activate

# Set working directory
WORKDIR /app

# Copy and install dependencies
COPY pnpm-lock.yaml package.json ./
RUN pnpm install --frozen-lockfile

# Copy the rest of the project
COPY . .

# 6) Generate the Prisma client
RUN pnpm exec prisma generate

# Build the TypeScript project
RUN pnpm build

# Expose the port your app runs on
EXPOSE 3000

# Run the server
CMD ["node", "dist/server.js"]
