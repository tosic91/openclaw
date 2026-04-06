---
name: escalation-handler
description: Xử lý escalation - chuyển lên Founder khi cần
trigger: Khi phát hiện negative sentiment, refund >500K, khiếu nại nặng
---
# Escalation Handler
## Triggers
- Sentiment tiêu cực (giận dữ, thất vọng, đe dọa)
- Yêu cầu refund >500K VNĐ
- Khiếu nại sản phẩm lỗi/hỏng
- Khách đe dọa review xấu
## Actions
1. Xin lỗi và trấn an khách
2. Ghi nhận vấn đề chi tiết
3. Thông báo: "Em chuyển ngay cho quản lý xử lý ạ"
4. Alert Founder qua Lark với context đầy đủ
