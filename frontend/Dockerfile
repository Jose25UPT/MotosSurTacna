# ---- Build stage ----
FROM node:20-alpine AS builder
WORKDIR /app

# Instalar dependencias
COPY package.json package-lock.json* ./
RUN npm install --frozen-lockfile || npm install

# Copiar el resto del código
COPY . .

# Compilar Next.js en standalone
RUN npm run build

# ---- Run stage ----
FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production

# Copiar solo lo necesario desde builder
COPY --from=builder /app/package.json ./
COPY --from=builder /app/next.config.ts ./
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static

EXPOSE 3000

# Usar standalone en lugar de npm start
CMD ["node", "server.js"]
