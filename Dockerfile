FROM node:20-alpine

# Enable corepack and activate latest pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

WORKDIR /app

# Copy only lockfile and package.json first for better caching
COPY pnpm-lock.yaml package.json ./

# Install dependencies strictly by lockfile
RUN pnpm install --frozen-lockfile

# Copy prisma schema and migrations
COPY prisma ./prisma

# Copy rest of the app source code
COPY . .

# Generate Prisma client (creates typings needed for build)
RUN pnpm exec prisma generate

# Build the TypeScript project
RUN pnpm build

EXPOSE 3000

# Run your server
CMD ["node", "dist/server.js"]
