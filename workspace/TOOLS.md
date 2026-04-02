# 🛠️ MH OS Tools — Hướng dẫn sử dụng

## MH OS Gateway API

MH OS Gateway là trung tâm dữ liệu chạy tại: `http://mh-os.railway.internal:8000`

Dùng tool `web_fetch` để gọi API. Tất cả API trả về JSON.

## QUAN TRỌNG — Quy tắc khi dùng tool

1. **KHÔNG BAO GIỜ hiển thị raw JSON hoặc function_call cho user.** Luôn parse kết quả và trả lời bằng ngôn ngữ tự nhiên.
2. **Luôn dùng URL nội bộ Railway** (`mh-os.railway.internal:8000`), KHÔNG dùng URL public.
3. **Luôn dùng endpoint `-summary`** khi có, để tránh response quá lớn.
4. Format kết quả gọn gàng cho mobile: dùng emoji, bullet points, số liệu rõ ràng.
5. Nếu API lỗi hoặc timeout, thông báo ngắn gọn và gợi ý thử lại.
6. Format tiền tệ VNĐ (ví dụ: 150.000đ), ngày dd/mm/yyyy.

## API Endpoints

### Kiểm tra hệ thống
```
GET http://mh-os.railway.internal:8000/health
```

### Pancake POS — Đơn hàng (DÙNG ENDPOINT NÀY)
```
GET http://mh-os.railway.internal:8000/api/pancake/orders-summary/407181592?page=1
```
Trả về tóm tắt đơn hàng gọn nhẹ: id, status, bill_total, customer_name, items_count, created_at.
Có tổng total_orders và total_revenue sẵn.

### Pancake POS — Danh sách shop
```
GET http://mh-os.railway.internal:8000/api/pancake/shops
```

### Pancake POS — Tìm khách hàng
```
GET http://mh-os.railway.internal:8000/api/pancake/customers/407181592?search=<tên hoặc SĐT>
```

### Pancake Chat — Hội thoại
```
GET http://mh-os.railway.internal:8000/api/pancake/conversations/<page_id>?limit=10
```

### Shopify — Tìm sản phẩm
```
GET http://mh-os.railway.internal:8000/api/shopify/products/search?q=<từ khóa>
```

### Shopify — Tổng sản phẩm
```
GET http://mh-os.railway.internal:8000/api/shopify/products/count
```

### Shopify — Đơn hàng
```
GET http://mh-os.railway.internal:8000/api/shopify/orders
```

### Telegram — Gửi thông báo
```
POST http://mh-os.railway.internal:8000/api/telegram/send
Body: {"message": "Nội dung"}
```

