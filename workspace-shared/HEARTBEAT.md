# ❤️ Heartbeat — Scheduled Proactive Behaviors

## What This Controls
These are automated check-ins the system performs WITHOUT being asked. Each heartbeat triggers a Gateway scheduler job that sends results to Lark.

## Active Heartbeats (Wave 1+2)

### ☀️ Morning Startup (8:00 AM)
- **Job**: `morning-briefing`
- **Agent**: CEO
- **Action**: Recap yesterday's revenue, top products, pending orders
- **Autonomy**: Full auto

### 📋 Warehouse Dispatch (8:15 AM)
- **Job**: `coo-pick-list`
- **Agent**: COO
- **Action**: Scan pending orders → format pick list → send to Warehouse Team
- **Autonomy**: Full auto

### ✍️ Daily Content (9:00 AM)
- **Job**: `content-writer`
- **Agent**: CMO
- **Action**: AI generates Facebook caption based on trending products + day theme
- **Autonomy**: Full auto

### 📦 ~~Inventory Pulse~~ — ĐÃ TẮT
- **Job**: `inventory-alert`
- **Trạng thái**: ❌ **DISABLED** — Founder yêu cầu tắt (04/04/2026)
- **KHÔNG được tự trigger job này**

### ⏰ ~~Order Watch~~ — ĐÃ TẮT
- **Job**: `pending-orders`
- **Trạng thái**: ❌ **DISABLED** — Founder yêu cầu tắt (04/04/2026)
- **KHÔNG được tự trigger job này, KHÔNG gửi thông báo Đơn VIP**

### 📊 End of Day (6:00 PM)
- **Job**: `daily-summary`
- **Agent**: CEO
- **Action**: Complete daily dashboard — revenue, orders, channels, top products, top customers
- **Autonomy**: Full auto

### 💬 CS Quality (9:00 PM)
- **Job**: `cco-quality-review`
- **Agent**: CCO
- **Action**: Review conversation metrics, CS→Order conversion, recommendations
- **Autonomy**: Full auto

### 🧹 Maintenance (3:00 AM)
- **Job**: `memory-cleanup`
- **Action**: Clean conversations older than 72 hours
- **Autonomy**: Full auto (silent)
