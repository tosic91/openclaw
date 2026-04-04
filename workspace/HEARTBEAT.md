# ❤️ Heartbeat — Scheduled Proactive Behaviors

## What This Controls
These are automated check-ins the system performs WITHOUT being asked. Each heartbeat triggers a Gateway scheduler job that sends results to Telegram.

## Active Heartbeats (Wave 1+2)

### ☀️ Morning Startup (8:00 AM)
- **Job**: `morning-briefing`
- **Action**: Recap yesterday's revenue, top products, pending orders
- **Output**: Telegram message to Founder
- **Autonomy**: Full auto

### 📋 Warehouse Dispatch (8:15 AM)
- **Job**: `coo-pick-list`
- **Action**: Scan pending orders → format pick list → send to Warehouse Team
- **Output**: Telegram pick list (VIP orders first)
- **Autonomy**: Full auto

### ✍️ Daily Content (9:00 AM)
- **Job**: `content-writer`
- **Action**: AI generates Facebook caption based on trending products + day theme
- **Output**: Telegram preview to Founder
- **Autonomy**: Full auto (CMO approved)

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
- **Action**: Complete daily dashboard — revenue, orders, channels, top products, top customers
- **Output**: Telegram report to Founder
- **Autonomy**: Full auto

### 💬 CS Quality (9:00 PM)
- **Job**: `cco-quality-review`
- **Action**: Review conversation metrics, CS→Order conversion, recommendations
- **Output**: Telegram report to Founder
- **Autonomy**: Full auto

### 🧹 Maintenance (3:00 AM)
- **Job**: `memory-cleanup`
- **Action**: Clean conversations older than 72 hours
- **Output**: Silent (log only)
- **Autonomy**: Full auto

## Planned Heartbeats (Wave 3+)
- Weekly performance report (Monday 9AM)
- Marketplace health check (9AM, 3PM)
- SEO ranking tracker (Weekly)
- Financial summary (End of month)
