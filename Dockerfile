# Railway-compatible OpenClaw Dockerfile — Multi-Agent Setup
# 5 agents: CEO, CS, COO, CMO, CCO
FROM node:22-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install OpenClaw globally from npm (pre-built binary)
# @larksuiteoapi/node-sdk: Feishu/Lark channel (primary)
# @buape/carbon: required by openclaw Control UI dashboard
RUN npm install -g openclaw@latest @larksuiteoapi/node-sdk @buape/carbon

# Create config directory and agent workspaces
RUN mkdir -p /root/.openclaw \
    /root/workspace-ceo/skills \
    /root/workspace-cs/skills \
    /root/workspace-coo/skills \
    /root/workspace-cmo/skills \
    /root/workspace-cco/skills

# Copy config (multi-agent, Lark-only, models via 9Router)
COPY openclaw.docker.json /root/.openclaw/openclaw.json

# Copy shared workspace files to ALL agent workspaces
COPY workspace-shared/ /root/workspace-ceo/
COPY workspace-shared/ /root/workspace-cs/
COPY workspace-shared/ /root/workspace-coo/
COPY workspace-shared/ /root/workspace-cmo/
COPY workspace-shared/ /root/workspace-cco/

# Copy agent-specific files (SOUL.md, AGENTS.md, skills/)
COPY workspace-ceo/ /root/workspace-ceo/
COPY workspace-cs/ /root/workspace-cs/
COPY workspace-coo/ /root/workspace-coo/
COPY workspace-cmo/ /root/workspace-cmo/
COPY workspace-cco/ /root/workspace-cco/

EXPOSE 18789

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s \
  CMD curl -f http://localhost:18789/ || exit 1

CMD ["openclaw", "gateway", "--port", "18789", "--bind", "lan", "--allow-unconfigured"]
