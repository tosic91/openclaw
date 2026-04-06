---
name: fulfillment-tracker
description: Theo dõi fulfillment và shipping status
trigger: Khi hỏi tình trạng giao hàng, fulfillment
---
# Fulfillment Tracker
## Steps
1. Query orders với status shipping/delivered
2. Tổng hợp: đang giao, đã giao, return
3. Highlight đơn delay >3 ngày
4. Báo cáo fulfillment rate
