---
name: pick-list-generator
description: Tạo pick list đóng gói hằng ngày
trigger: Khi cần tạo pick list, đơn cần đóng gói
---
# Pick List Generator
## Steps
1. `GET /api/pancake/orders-summary/407181592?date=today&status=pending`
2. Sort: VIP (>1M) trước, rồi theo thời gian
3. Group by location trong kho nếu có
4. Format pick list cho warehouse team
