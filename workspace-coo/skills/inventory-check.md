---
name: inventory-check
description: Kiểm tra tồn kho, cảnh báo hết hàng
trigger: Khi hỏi tồn kho, stock, còn bao nhiêu
---
# Inventory Check
## Steps
1. `GET /api/pancake/products-summary/407181592?search={keyword}`
2. Parse variations → remain_quantity cho từng phiên bản
3. Cảnh báo nếu <5 units
4. Format: "[SP] — còn [X] cái | [giá]đ"
