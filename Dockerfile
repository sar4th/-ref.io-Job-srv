FROM node:20-alpine

RUN corepack enable && corepack prepare pnpm@latest --activate

WORKDIR /app

COPY pnpm-lock.yaml package.json ./
RUN pnpm install --frozen-lockfile

# 🔥 Copy prisma folder (including migrations)
COPY prisma ./prisma

# Copy rest of project
COPY . .

# Generate Prisma client
RUN pnpm exec prisma generate

# Build TypeScript code
RUN pnpm build
RUN pnpm exec prisma migrate deploy
EXPOSE 3000

CMD ["node", "dist/server.js"]
