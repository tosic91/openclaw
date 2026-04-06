# Railway-compatible OpenClaw Dockerfile
# Installs pre-built OpenClaw from npm to avoid complex build deps
FROM node:22-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install OpenClaw globally from npm (pre-built binary)
# grammy + sub-packages needed for Telegram channel support (peer deps of @openclaw/telegram)
# grammy: Telegram channel | @larksuiteoapi/node-sdk: Feishu/Lark channel
# @buape/carbon: required by openclaw Control UI dashboard
RUN npm install -g openclaw@latest grammy @grammyjs/runner @grammyjs/transformer-throttler @larksuiteoapi/node-sdk @buape/carbon

# Create config directory and workspace
RUN mkdir -p /root/.openclaw /root/mhos-workspace

# Copy config (bind=lan for Railway internal networking, models via 9Router)
COPY openclaw.docker.json /root/.openclaw/openclaw.json

# Copy workspace bootstrap files (SOUL, TOOLS, IDENTITY, USER)
COPY workspace/ /root/mhos-workspace/

EXPOSE 18789

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s \
  CMD curl -f http://localhost:18789/ || exit 1

CMD ["openclaw", "gateway", "--port", "18789", "--bind", "lan", "--allow-unconfigured"]
