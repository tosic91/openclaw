# Railway-compatible OpenClaw Dockerfile
# Installs pre-built OpenClaw from npm to avoid complex build deps
FROM node:22-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install OpenClaw globally from npm (pre-built binary)
RUN npm install -g openclaw@latest

# Create config directory
RUN mkdir -p /root/.openclaw

EXPOSE 18789

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s \
  CMD curl -f http://localhost:18789/ || exit 1

CMD ["openclaw", "gateway", "--port", "18789", "--allow-unconfigured"]
