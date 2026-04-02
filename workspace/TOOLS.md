# 🛠️ MH OS Tools — Hướng dẫn sử dụng

## MH OS Gateway API

MH OS Gateway là trung tâm dữ liệu chạy tại: `http://mh-os.railway.internal:8000`

Dùng tool `web_fetch` để gọi API. Tất cả API trả về JSON.

### Health Check
```
GET http://mh-os.railway.internal:8000/health
```
Kiểm tra trạng thái hệ thống và các integration.

### Pancake POS — Đơn hàng & Bán hàng

```
GET http://mh-os.railway.internal:8000/api/pancake/shops
```
Lấy danh sách cửa hàng. Shop chính: ID `407181592`.

```
GET http://mh-os.railway.internal:8000/api/pancake/orders/407181592?page=1
```
Lấy đơn hàng gần nhất. Hỗ trợ phân trang (?page=1,2,3...).

```
GET http://mh-os.railway.internal:8000/api/pancake/customers/407181592?search=<tên>
```
Tìm khách hàng theo tên hoặc SĐT.

### Pancake Chat — Hội thoại

```
GET http://mh-os.railway.internal:8000/api/pancake/conversations/<page_id>?limit=10
```
Lấy hội thoại gần nhất từ một page.

### Shopify — Sản phẩm & Kho

```
GET http://mh-os.railway.internal:8000/api/shopify/products/search?q=<từ khóa>
```
Tìm sản phẩm theo tên.

```
GET http://mh-os.railway.internal:8000/api/shopify/products/count
```
Tổng số sản phẩm trên Shopify.

```
GET http://mh-os.railway.internal:8000/api/shopify/orders
```
Đơn hàng gần nhất trên Shopify.

### Telegram — Thông báo

```
POST http://mh-os.railway.internal:8000/api/telegram/send
Content-Type: application/json
Body: {"message": "Nội dung thông báo"}
```
Gửi thông báo khẩn cho founder.

## Quy tắc sử dụng API

1. **Luôn dùng URL nội bộ Railway** (`mh-os.railway.internal:8000`), KHÔNG dùng URL public
2. Khi tra đơn hàng, bắt đầu với page=1 rồi tăng dần nếu cần thêm
3. Format kết quả gọn gàng: chỉ hiển thị thông tin quan trọng, bỏ qua fields rỗng
4. Nếu API lỗi, thông báo cho user và gợi ý kiểm tra /health
5. Khi tìm sản phẩm, dùng từ khóa tiếng Việt hoặc tiếng Anh đều được
