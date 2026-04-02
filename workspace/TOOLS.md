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
4. **Luôn dùng endpoint `-summary` hoặc `daily-dashboard`** khi có, để response gọn nhẹ.
5. Format tiền tệ VNĐ (ví dụ: 150.000đ), ngày dd/mm/yyyy.
6. Nếu API lỗi, thông báo ngắn gọn và gợi ý thử lại.

## API Endpoints

Base URL: `http://mh-os.railway.internal:8000`
Shop ID mặc định: `407181592`

---

### 📊 Dashboard hàng ngày (DÙNG KHI CẦN PHÂN TÍCH TỔNG QUAN)
```bash
curl -s "http://mh-os.railway.internal:8000/api/pancake/daily-dashboard/407181592?date=today"
```
**Endpoint mạnh nhất — 1 API call ra toàn bộ insight:**
- Tổng đơn, tổng doanh thu, giá trị đơn trung bình
- **Phân loại theo kênh bán** (Shopee, TikTok Shop, Lazada, Fanpage, Zalo, POS)
- Phân loại theo trạng thái (đã giao, chờ xử lý, hủy...)
- Top 5 sản phẩm bán chạy nhất (tên, số lượng, doanh thu)
- Top 5 khách hàng chi tiêu nhiều nhất
- Danh sách 10 đơn gần nhất (có kèm kênh bán)

Tham số `date`: `today`, `yesterday`, hoặc `YYYY-MM-DD`

**Khi user hỏi "tóm tắt kinh doanh hôm nay" hoặc "phân tích đơn hàng" → LUÔN dùng daily-dashboard trước.**

---

### 🛒 Đơn hàng — Danh sách theo ngày
```bash
curl -s "http://mh-os.railway.internal:8000/api/pancake/orders-summary/407181592?date=today"
```
- `?date=today` = đơn hôm nay
- `?date=yesterday` = đơn hôm qua
- `?date=2026-04-01` = đơn ngày cụ thể
- Không truyền date = 10 đơn mới nhất (mọi ngày)

Trả về: count, total_revenue, danh sách (order_id, status, amount, customer, phone).

---

### 📦 Đơn hàng — Chi tiết 1 đơn (sản phẩm & địa chỉ)
```bash
curl -s "http://mh-os.railway.internal:8000/api/pancake/order-detail/407181592/{order_id}"
```
Thay `{order_id}` bằng mã đơn (ví dụ: `260402Q3CU1DT3` hoặc `102801`).
Trả về: danh sách sản phẩm trong đơn (tên, số lượng, giá), người mua, SĐT, địa chỉ ship, ghi chú.

---

### 🏷️ Sản phẩm — Tìm kiếm & tồn kho
```bash
curl -s "http://mh-os.railway.internal:8000/api/pancake/products-summary/407181592?search=catan&page=1&page_size=10"
```
Tìm sản phẩm theo tên. Trả về: tên, giá bán lẻ, tồn kho, danh mục, biến thể (variants).
- Dùng `search=tên sản phẩm` để tìm kiếm
- Không truyền search = danh sách tất cả (phân trang)

---

### 👥 Khách hàng — Tìm kiếm & lịch sử
```bash
curl -s "http://mh-os.railway.internal:8000/api/pancake/customers-summary/407181592?search=Minh"
```
Tìm theo tên hoặc SĐT. Trả về: tên, SĐT, email, tổng số đơn, tổng chi tiêu, ghi chú.

---

### 💬 Hội thoại chat (Zalo, Facebook, Shopee)
```bash
curl -s "http://mh-os.railway.internal:8000/api/pancake/conversations/{page_id}?limit=10"
```
Xem tin nhắn gần nhất từ các kênh bán hàng.

---

### 🏪 Danh sách shop
```bash
curl -s http://mh-os.railway.internal:8000/api/pancake/shops
```

---

### 🛍️ Shopify — Tìm sản phẩm
```bash
curl -s "http://mh-os.railway.internal:8000/api/shopify/products/search?q=board+game"
```

### 📈 Shopify — Tổng sản phẩm
```bash
curl -s http://mh-os.railway.internal:8000/api/shopify/products/count
```

### 🧾 Shopify — Đơn hàng
```bash
curl -s http://mh-os.railway.internal:8000/api/shopify/orders
```

---

### 📢 Telegram — Gửi thông báo
```bash
curl -s -X POST http://mh-os.railway.internal:8000/api/telegram/send -H "Content-Type: application/json" -d '{"message": "Nội dung"}'
```

### ❤️ Kiểm tra hệ thống
```bash
curl -s http://mh-os.railway.internal:8000/health
```

---

## 🧠 Hướng dẫn phân tích kinh doanh

Khi user yêu cầu phân tích, hãy:

1. **Bắt đầu với daily-dashboard** để lấy tổng quan
2. **So sánh**: Gọi dashboard cho hôm qua (`?date=yesterday`) để so sánh
3. **Chi tiết**: Nếu cần xem đơn cụ thể, dùng order-detail
4. **Sản phẩm**: Kiểm tra tồn kho nếu sản phẩm bán chạy

### Các insight nên đưa ra:
- 📊 So sánh hôm nay vs hôm qua (đơn hàng, doanh thu)
- 🛒 **Phân tích theo kênh bán**: Shopee chiếm bao nhiêu %, TikTok Shop, Fanpage, v.v.
- 🏆 Sản phẩm bán chạy nhất
- 💰 Khách hàng VIP (chi tiêu nhiều nhất)
- 📈 Giá trị đơn trung bình
- ⚠️ Đơn chờ xử lý cần follow up
- 🔥 Sản phẩm sắp hết hàng (tồn kho thấp)

### ⏰ QUAN TRỌNG — Nhận biết thời gian đơn hàng:
Khi user hỏi "đơn mới nhất", "có đơn mới không":
1. **Luôn so sánh** thời gian đơn hàng với thời điểm hiện tại
2. **Nếu đơn "mới nhất" đã cách đây >1 giờ**: Nói rõ "Đơn mới nhất là từ lúc X giờ sáng/chiều. Từ đó đến hiện tại (Y giờ) chưa có đơn mới nào phát sinh."
3. **KHÔNG BAO GIỜ** trình bày đơn cũ như thể nó vừa mới xảy ra
4. **Nếu user nói "không phải, đơn cũ rồi"**: Xác nhận rằng đây đúng là đơn mới nhất trên hệ thống, giải thích rõ ràng
5. Ví dụ đúng: "Đơn mới nhất trên Pancake là từ 8:14 sáng nay — tức cách đây khoảng 7 tiếng. Hiện chưa có thêm đơn mới nào phát sinh từ đó đến bây giờ anh nhé."
- 📣 Kênh bán nào hiệu quả nhất (doanh thu/đơn cao nhất)

---

## 🤖 Hệ thống Agents (Wave 1+2)

### ⏰ Kiểm tra Scheduled Jobs
```bash
curl -s http://mh-os.railway.internal:8000/api/scheduler/status
```
Xem trạng thái tất cả 8 job tự động, lần chạy tiếp theo.

### 🔧 Trigger Job Thủ Công
```bash
curl -s -X POST http://mh-os.railway.internal:8000/api/scheduler/trigger/daily-summary
```
Chạy một job ngay lập tức. Các job có sẵn:

**Wave 1:**
- `daily-summary` — [CEO] Tổng kết ngày
- `morning-briefing` — [CEO] Briefing sáng
- `inventory-alert` — [Inventory-Agent] Kiểm tra tồn kho
- `pending-orders` — [Order-Processor] Kiểm tra đơn pending
- `memory-cleanup` — Dọn dẹp bộ nhớ

**Wave 2:**
- `coo-pick-list` — [COO] Pick list đóng gói cho Warehouse Team
- `content-writer` — [Content-Writer] Tạo caption FB tự động
- `cco-quality-review` — [CCO] Review chất lượng CSKH

### 🧠 Kiểm tra Memory
```bash
curl -s http://mh-os.railway.internal:8000/api/memory/stats
```
Xem thống kê bộ nhớ hội thoại: tổng conversations, messages, active 24h.

### 📚 Kiểm tra Knowledge Base
```bash
curl -s http://mh-os.railway.internal:8000/api/knowledge/stats
```

### 🖥️ Tổng quan hệ thống
```bash
curl -s http://mh-os.railway.internal:8000/api/system/overview
```
Xem toàn bộ trạng thái: scheduler, memory, knowledge, integrations.

### 📌 Tất cả jobs tự động:
| Job | Agent | Lịch | Mô tả |
|-----|-------|------|-------|
| Daily Summary | CEO | 6PM | Tổng kết doanh thu, đơn hàng, top SP |
| Morning Briefing | CEO | 8AM | Recap hôm qua + đơn pending |
| Inventory Alert | Inventory-Agent | Mỗi 2h | Cảnh báo hết hàng/sắp hết |
| Pending Orders | Order-Processor | Mỗi 30p | Alert đơn chờ >2h, đơn VIP >500K |
| Memory Cleanup | System | 3AM | Dọn conversations cũ >72h |
| **Pick List** | **COO** | **8:15AM** | **Pick list đóng gói → Warehouse** |
| **Content Post** | **Content-Writer** | **9AM** | **Auto caption FB (AI-generated)** |
| **CS Review** | **CCO** | **9PM** | **Review chất lượng CSKH hàng ngày** |

### 🏢 Org Chart (22 AI Agents — 9 Phòng Ban)
```bash
curl -s http://mh-os.railway.internal:8000/api/system/overview
```
Xem config tại `data/org-chart.json`. Toàn bộ agents, departments, autonomy rules.
