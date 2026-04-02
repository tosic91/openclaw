# 🛠️ MH OS Tools — Hướng dẫn sử dụng

## CÁCH GỌI API — BẮT BUỘC ĐỌC

**KHÔNG DÙNG `web_fetch`** vì nó chặn internal hostname.
**LUÔN DÙNG `exec` tool với `curl`** để gọi API nội bộ.

### Cách gọi đúng (LUÔN làm theo mẫu này):
```json
{"tool": "exec", "command": "curl -s http://mh-os.railway.internal:8000/health"}
```

### Cách gọi SAI (KHÔNG BAO GIỜ làm):
- ❌ `web_fetch({ url: "http://mh-os.railway.internal:8000/..." })`
- ❌ `const result = await fetch("http://...")`
- ❌ Viết JavaScript code để gọi API

## QUAN TRỌNG — Quy tắc

1. **LUÔN dùng `exec` tool với `curl -s`** để gọi API. Thêm `-s` để tắt progress bar.
2. **KHÔNG BAO GIỜ hiển thị raw JSON cho user.** Parse kết quả curl và trả lời bằng ngôn ngữ tự nhiên.
3. **KHÔNG hiển thị code block hay function_call cho user trên Telegram.**
4. **Luôn dùng endpoint `-summary`** khi có, để response gọn nhẹ.
5. Format tiền tệ VNĐ (ví dụ: 150.000đ), ngày dd/mm/yyyy.
6. Nếu API lỗi, thông báo ngắn gọn và gợi ý thử lại.

## API Endpoints

Base URL: `http://mh-os.railway.internal:8000`

### Kiểm tra hệ thống
```bash
curl -s http://mh-os.railway.internal:8000/health
```

### Đơn hàng — Danh sách theo ngày (LUÔN TRUYỀN date!)
```bash
curl -s "http://mh-os.railway.internal:8000/api/pancake/orders-summary/407181592?date=today"
```
**QUAN TRỌNG**: Khi user hỏi "hôm nay có bao nhiêu đơn" → dùng `?date=today`
- `?date=today` = đơn hôm nay
- `?date=yesterday` = đơn hôm qua
- `?date=2026-04-01` = đơn ngày cụ thể
- Không truyền date = 10 đơn mới nhất (mọi ngày)

Trả về: count (số đơn), total_revenue (doanh thu), và danh sách gọn (order_id, status, amount, customer).

### Đơn hàng — Chi tiết 1 đơn
```bash
curl -s "http://mh-os.railway.internal:8000/api/pancake/order-detail/407181592/{order_id}"
```
Thay {order_id} bằng mã đơn. Trả về: sản phẩm trong đơn, giá, người mua, địa chỉ ship.

### Sản phẩm — Tìm kiếm & tồn kho
```bash
curl -s "http://mh-os.railway.internal:8000/api/pancake/products-summary/407181592?search=catan&page=1&page_size=10"
```
Tìm sản phẩm theo tên. Trả về: tên, giá, tồn kho, variants.

### Khách hàng — Tìm kiếm
```bash
curl -s "http://mh-os.railway.internal:8000/api/pancake/customers-summary/407181592?search=Minh"
```
Tìm theo tên hoặc SĐT. Trả về: tên, SĐT, email, tổng đơn, tổng chi tiêu.

### Danh sách shop
```bash
curl -s http://mh-os.railway.internal:8000/api/pancake/shops
```

### Hội thoại chat
```bash
curl -s "http://mh-os.railway.internal:8000/api/pancake/conversations/{page_id}?limit=10"
```

### Shopify — Tìm sản phẩm
```bash
curl -s "http://mh-os.railway.internal:8000/api/shopify/products/search?q=board+game"
```

### Shopify — Tổng sản phẩm
```bash
curl -s http://mh-os.railway.internal:8000/api/shopify/products/count
```

### Shopify — Đơn hàng
```bash
curl -s http://mh-os.railway.internal:8000/api/shopify/orders
```

### Telegram — Gửi thông báo
```bash
curl -s -X POST http://mh-os.railway.internal:8000/api/telegram/send -H "Content-Type: application/json" -d '{"message": "Nội dung"}'
```
