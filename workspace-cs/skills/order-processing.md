---
name: order-processing
description: Tra cứu đơn hàng, trạng thái ship cho khách
trigger: Khi khách hỏi về đơn hàng, tracking, ship đến đâu
---
# Order Processing
## Steps
1. Xác định mã đơn hoặc tên khách
2. `GET /api/pancake/orders-summary/407181592` hoặc order-detail
3. Parse: trạng thái, sản phẩm, tổng tiền, shipping
4. Trả lời: "Đơn [mã] đang [trạng thái] ạ, dự kiến giao [ngày]"
