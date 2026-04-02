---
name: daily-reporting
description: Generate daily business reports and KPI summaries
trigger: When user asks for today's numbers, revenue, or business performance
---

# Daily Reporting Skill

## When to Use
- "Hôm nay bán được bao nhiêu?"
- "Doanh thu hôm nay thế nào?"
- "Tổng kết ngày đi"
- Morning briefing or end-of-day summary

## Steps

### 1. Fetch Dashboard Data
```
GET /api/pancake/daily-dashboard/407181592?date=today
```

### 2. Key Metrics to Report
- 📊 Total orders
- 💰 Total revenue (VNĐ)
- 📈 Average order value
- 🛒 Channel breakdown (FB, Zalo, Shopee, TikTok)
- 🏆 Top 5 products
- 👤 Top customers
- ⏰ Comparison with yesterday (if available)

### 3. Format for Telegram
```
📊 Tổng kết ngày DD/MM

💰 Doanh thu: X.XXX.XXXđ
🛒 Đơn hàng: XX đơn
📈 TB đơn: X.XXXđ

🏆 Top SP: [product name] (Xx)
📱 Kênh: FB XX | Zalo XX | Shopee XX

vs hôm qua: +/-XX%
```

### 4. Insights
- Highlight anomalies (sudden spike/drop)
- Note channel performance changes
- Flag any stockouts or fulfillment delays
