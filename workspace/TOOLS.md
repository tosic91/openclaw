# 🛠️ MH OS Tools

## ⛔⛔⛔ QUY TẮC TUYỆT ĐỐI — ĐỌC TRƯỚC KHI LÀM GÌ ⛔⛔⛔

**KHÔNG BAO GIỜ BỊA DỮ LIỆU.** Đây là quy tắc quan trọng nhất.

- Mọi mã đơn, tên SP, tên KH, số tiền, doanh thu bạn nói ra PHẢI đến từ kết quả API thực tế.
- Nếu `exec curl` trả về lỗi/timeout → nói: "Em không lấy được dữ liệu lúc này, anh thử lại sau nhé."
- Nếu response rỗng/không có data → nói: "Hiện tại không có dữ liệu."
- **KHÔNG ĐƯỢC** tự nghĩ ra mã đơn (ví dụ: 103579, 103580...) — mã đơn thật có dạng `260404V4YWYK5Y`.
- **KHÔNG ĐƯỢC** tự nghĩ ra tên sản phẩm, tên khách hàng, số điện thoại, hay bất cứ con số nào.

**Quy trình BẮT BUỘC:**
1. Gọi API → 2. Đọc response → 3. Trích xuất data từ response → 4. Trình bày tự nhiên
**KHÔNG BAO GIỜ bỏ qua bước 1-3 và tự viết ra kết quả.**

## Cách gọi API

**LUÔN dùng `exec` tool với `curl -s`:**
```json
{"tool": "exec", "command": "curl -s http://mh-os.railway.internal:8000/api/pancake/daily-dashboard/407181592?date=today"}
```

**KHÔNG dùng `web_fetch`.** KHÔNG dùng JavaScript fetch.

## API Endpoints — Shop ID: `407181592`

Base URL: `http://mh-os.railway.internal:8000`

### 📊 Daily Dashboard (dùng khi hỏi tổng quan ngày)
```bash
curl -s "http://mh-os.railway.internal:8000/api/pancake/daily-dashboard/407181592?date=today"
```
Trả về: tổng đơn, doanh thu, AVG, top SP, top KH, phân kênh bán, 10 đơn gần nhất.
Params: `date=today`, `date=yesterday`, `date=2026-04-01`

### 🛒 Đơn hàng
```bash
curl -s "http://mh-os.railway.internal:8000/api/pancake/orders-summary/407181592?date=today"
curl -s "http://mh-os.railway.internal:8000/api/pancake/order-detail/407181592/{order_id}"
```

### 📦 Sản phẩm
```bash
curl -s "http://mh-os.railway.internal:8000/api/pancake/products-summary/407181592?search=catan"
```

### 👥 Khách hàng
```bash
curl -s "http://mh-os.railway.internal:8000/api/pancake/customers-summary/407181592?search=Minh"
```

### 📢 Telegram
```bash
curl -s -X POST http://mh-os.railway.internal:8000/api/telegram/send -H "Content-Type: application/json" -d '{"message": "Nội dung"}'
```

### ❤️ Kiểm tra hệ thống
```bash
curl -s http://mh-os.railway.internal:8000/health
```

## Pancake POS API trực tiếp (khi Gateway không đủ)

Khi cần: tồn kho, thu chi, nhà cung cấp, thống kê tháng → đọc file **PANCAKE-API.md** rồi gọi trực tiếp.
```bash
curl -s "https://pos.pages.fm/api/v1/shops/407181592/{endpoint}?api_key=$PANCAKE_POS_API_KEY"
```
**CHỈ GET. KHÔNG POST/PUT/DELETE.**

## Quy tắc hiển thị

1. **KHÔNG hiển thị raw JSON, curl commands, tool calls cho user**
2. Parse kết quả → trả lời bằng tiếng Việt tự nhiên
3. Format tiền VNĐ (150.000đ), ngày dd/mm/yyyy
4. Nếu API lỗi → báo ngắn gọn, gợi ý thử lại

## Scheduled Jobs
```bash
curl -s http://mh-os.railway.internal:8000/api/scheduler/status
curl -s -X POST http://mh-os.railway.internal:8000/api/scheduler/trigger/{job_id}
```
Jobs: `daily-summary`, `morning-briefing`, `inventory-alert`, `pending-orders`, `memory-cleanup`, `coo-pick-list`, `content-writer`, `cco-quality-review`
