---
name: daily-reporting
description: Tổng hợp báo cáo doanh thu, KPIs hằng ngày
trigger: Khi hỏi doanh thu, tổng kết ngày, business performance
---
# Daily Reporting
## Steps
1. `GET /api/pancake/daily-dashboard/407181592?date=today`
2. Parse: tổng đơn, doanh thu, AVG, top SP, top KH, kênh bán
3. So sánh với hôm qua nếu có
4. Format báo cáo gọn cho mobile
