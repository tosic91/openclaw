# 🔌 Pancake POS API — Complete Reference

## CÁCH SỬ DỤNG

Bạn PHẢI dùng `exec` tool với `curl -s` để gọi Pancake API **trực tiếp**.

### Mẫu gọi chuẩn:
```bash
curl -s "https://pos.pages.fm/api/v1/shops/407181592/orders?api_key=$PANCAKE_POS_API_KEY&page_size=20"
```

### Quy tắc:
1. **Base URL**: `https://pos.pages.fm/api/v1`
2. **Auth**: Luôn thêm `?api_key=$PANCAKE_POS_API_KEY` vào query string
3. **Shop ID mặc định**: `407181592`
4. **KHÔNG hiển thị raw JSON** cho user — parse và trả lời tự nhiên
5. **Format**: Tiền VNĐ (150.000đ), ngày dd/mm/yyyy
6. **Timezone**: Pancake trả UTC — cộng thêm 7h để ra giờ Việt Nam

---

## 1. 🏪 Shop

```bash
# Danh sách shop
curl -s "https://pos.pages.fm/api/v1/shops?api_key=$PANCAKE_POS_API_KEY"
```
Trả về: id, name, avatar_url, link_post_marketer

---

## 2. 📍 Address (Địa chỉ)

```bash
# Danh sách tỉnh thành
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/addresses/provinces?api_key=$PANCAKE_POS_API_KEY"

# Quận huyện theo tỉnh
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/addresses/districts?province_id=XX&api_key=$PANCAKE_POS_API_KEY"

# Phường xã theo quận
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/addresses/wards?district_id=XX&api_key=$PANCAKE_POS_API_KEY"
```

---

## 3. 🏭 Warehouse (Kho hàng)

```bash
# Danh sách kho
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/warehouses?api_key=$PANCAKE_POS_API_KEY"

# Lịch sử tồn kho
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/inventory_histories?api_key=$PANCAKE_POS_API_KEY&page_size=20"
```
Response: id, name, address, phone, is_default, created_at

---

## 4. 🛒 Order (Đơn hàng) ⭐ QUAN TRỌNG

```bash
# Danh sách đơn hàng
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/orders?api_key=$PANCAKE_POS_API_KEY&page_size=20&page_number=1"

# Lọc theo trạng thái
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/orders?api_key=$PANCAKE_POS_API_KEY&filter_status[]=confirmed&filter_status[]=pending"

# Tìm kiếm theo SĐT/tên
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/orders?api_key=$PANCAKE_POS_API_KEY&search=0912345678"

# Chi tiết 1 đơn
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/orders/{ORDER_ID}?api_key=$PANCAKE_POS_API_KEY"

# Tạo đơn mới
curl -s -X POST "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/orders?api_key=$PANCAKE_POS_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"bill_full_name":"...", "bill_phone_number":"...", "items":[...]}'

# Cập nhật đơn
curl -s -X PUT "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/orders/{ORDER_ID}?api_key=$PANCAKE_POS_API_KEY" \
  -H "Content-Type: application/json" -d '{"status":"confirmed"}'

# Nguồn đơn hàng (order sources)
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/order_source?api_key=$PANCAKE_POS_API_KEY"

# Giao hàng / In tem
curl -s -X POST "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/orders/arrange_shipment?api_key=$PANCAKE_POS_API_KEY" \
  -H "Content-Type: application/json" -d '{"order_ids":[...]}'

# Đơn hoàn (return)
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/return_orders?api_key=$PANCAKE_POS_API_KEY"
```

**Params quan trọng cho orders:**
- `page_size` (int): Số đơn/trang (default 20, max 100)
- `page_number` (int): Trang
- `search` (string): Tìm theo SĐT, tên, mã đơn
- `filter_status[]`: `pending`, `confirmed`, `shipping`, `shipped`, `cancelled`, `returned`
- `include_removed` (bool): Bao gồm đơn đã xóa
- `start_time` / `end_time`: Lọc theo khoảng thời gian (ISO format UTC)

**Response fields:**
- id, status_name, cod, total_price, bill_full_name, bill_phone_number
- shipping_address, note, inserted_at, items (danh sách SP)
- page_id (xác định kênh bán: tts_=TikTok, spo_=Shopee, lzd_=Lazada, zl_=Zalo)

---

## 5. 🧾 E-Invoice (Hóa đơn điện tử)

```bash
# Danh sách hóa đơn
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/e_invoices?api_key=$PANCAKE_POS_API_KEY"

# Tạo hóa đơn
curl -s -X POST "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/e_invoices?api_key=$PANCAKE_POS_API_KEY" \
  -H "Content-Type: application/json" -d '{...}'
```

---

## 6. 📺 Livestream

```bash
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/livestreams?api_key=$PANCAKE_POS_API_KEY"
```

---

## 7. 🛍️ eCommerce (Sàn TMĐT)

```bash
# Sản phẩm trên sàn
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/marketplace/products?api_key=$PANCAKE_POS_API_KEY"

# Đánh giá Shopee
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/shopee/evaluate?api_key=$PANCAKE_POS_API_KEY"
```

---

## 8. 📞 Call Later (Gọi lại sau)

```bash
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/call_laters?api_key=$PANCAKE_POS_API_KEY"
```

---

## 9. 👥 Customer (Khách hàng) ⭐

```bash
# Danh sách khách hàng
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/customers?api_key=$PANCAKE_POS_API_KEY&search=Minh"

# Chi tiết khách hàng
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/customers/{CUSTOMER_ID}?api_key=$PANCAKE_POS_API_KEY"

# Tạo khách hàng
curl -s -X POST "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/customers?api_key=$PANCAKE_POS_API_KEY" \
  -H "Content-Type: application/json" -d '{"name":"...", "phone_number":"..."}'

# Cấp độ khách hàng (loyalty tiers)
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/customer_levels?api_key=$PANCAKE_POS_API_KEY"

# Lịch sử điểm thưởng
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/customers/{CUSTOMER_ID}/point_histories?api_key=$PANCAKE_POS_API_KEY"

# Tạo ghi chú cho KH
curl -s -X POST "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/customers/{CUSTOMER_ID}/create_note?api_key=$PANCAKE_POS_API_KEY" \
  -H "Content-Type: application/json" -d '{"content":"..."}'
```

**Params:** search (tên/SĐT), start_time_inserted_at, end_time_inserted_at

---

## 10. 💸 Debt (Công nợ)

```bash
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/debts?api_key=$PANCAKE_POS_API_KEY"
```

---

## 11. 💰 Transaction (Thu chi) ⭐

```bash
# Danh sách thu chi
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/transactions?api_key=$PANCAKE_POS_API_KEY&page_size=20"

# Tạo phiếu thu/chi
curl -s -X POST "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/transactions?api_key=$PANCAKE_POS_API_KEY" \
  -H "Content-Type: application/json" -d '{"amount":100000, "type":"income", "note":"..."}'

# Chi phí quảng cáo
curl -s -X POST "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/adv_costs?api_key=$PANCAKE_POS_API_KEY" \
  -H "Content-Type: application/json" -d '{...}'
```

---

## 12. 📦 Product (Sản phẩm) ⭐

```bash
# Danh sách sản phẩm
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/products?api_key=$PANCAKE_POS_API_KEY&page_size=20&search=catan"

# Chi tiết sản phẩm
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/products/{PRODUCT_ID}?api_key=$PANCAKE_POS_API_KEY"

# Tạo sản phẩm
curl -s -X POST "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/products?api_key=$PANCAKE_POS_API_KEY" \
  -H "Content-Type: application/json" -d '{"name":"...", "retail_price":100000}'

# Cập nhật sản phẩm
curl -s -X PUT "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/products/{PRODUCT_ID}?api_key=$PANCAKE_POS_API_KEY" \
  -H "Content-Type: application/json" -d '{"name":"...", "retail_price":150000}'

# Danh sách biến thể (variations) — xem tồn kho chi tiết
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/products/variations?api_key=$PANCAKE_POS_API_KEY&search=uno"

# Danh mục sản phẩm (categories)
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/categories?api_key=$PANCAKE_POS_API_KEY"

# Cập nhật tồn kho
curl -s -X PUT "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/products/{PRODUCT_ID}/update_inventory?api_key=$PANCAKE_POS_API_KEY" \
  -H "Content-Type: application/json" -d '{"warehouse_id":XX, "quantity":50}'
```

**Params cho variations:**
- `search`: Tìm theo tên
- `selling_status`: "selling" hoặc "stop_selling"
- `category_id[]`: Lọc theo danh mục
- `warehouse_until`: Tồn kho tại thời điểm (ISO date)

---

## 13. 🏢 Supplier (Nhà cung cấp)

```bash
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/suppliers?api_key=$PANCAKE_POS_API_KEY"
```
Response: id, name, phone, address, email, note

---

## 14. 📥 Purchase (Phiếu nhập hàng)

```bash
# Danh sách phiếu nhập
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/purchases?api_key=$PANCAKE_POS_API_KEY&page_size=20"

# Chi tiết phiếu nhập
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/purchases/{PURCHASE_ID}?api_key=$PANCAKE_POS_API_KEY"
```
Response: id, supplier, items (SP nhập), total_amount, status, inserted_at

---

## 15. 📤 Export (Phiếu xuất hàng)

```bash
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/exports?api_key=$PANCAKE_POS_API_KEY&page_size=20"
```

---

## 16. 🔄 Warehouse Transfer (Chuyển kho)

```bash
# Danh sách phiếu chuyển kho
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/transfers?api_key=$PANCAKE_POS_API_KEY"

# Chi tiết phiếu chuyển kho
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/transfers/{TRANSFER_ID}?api_key=$PANCAKE_POS_API_KEY"
```

---

## 17. 📋 Stocktaking (Kiểm kho)

```bash
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/stocktakings?api_key=$PANCAKE_POS_API_KEY"
```

---

## 18. 🎉 Promotion (Khuyến mãi)

```bash
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/promotions?api_key=$PANCAKE_POS_API_KEY"
```

---

## 19. 🎟️ Voucher (Mã giảm giá)

```bash
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/vouchers?api_key=$PANCAKE_POS_API_KEY"
```

---

## 20. 🎁 Combo

```bash
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/combos?api_key=$PANCAKE_POS_API_KEY"
```

---

## 21. 📊 Statistics (Thống kê doanh thu) ⭐

```bash
# Báo cáo doanh thu
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/analytics/sale?api_key=$PANCAKE_POS_API_KEY&start_date=2026-04-01&end_date=2026-04-04"

# Thống kê theo khoảng thời gian
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/analytics/sale?api_key=$PANCAKE_POS_API_KEY&start_date=2026-03-01&end_date=2026-03-31"
```

**Params:**
- `start_date` / `end_date`: YYYY-MM-DD (bắt buộc)
- Response: total_revenue, total_orders, total_profit, by_day breakdown...

---

## 22. 📈 Inventory Analytics (Phân tích tồn kho) ⭐

```bash
# Phân tích tồn kho
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/inventory_analytics/inventory?api_key=$PANCAKE_POS_API_KEY"
```

---

## 23. 👨‍💼 Employee (Nhân viên)

```bash
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/users?api_key=$PANCAKE_POS_API_KEY"
```
Response: id, name, phone, email, role, department

---

## 24. 🔔 Webhook

```bash
# Danh sách webhook
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/webhooks?api_key=$PANCAKE_POS_API_KEY"

# Tạo webhook
curl -s -X POST "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/webhooks?api_key=$PANCAKE_POS_API_KEY" \
  -H "Content-Type: application/json" -d '{"url":"...", "events":["order.created"]}'
```

---

## 25. 📇 CRM (Quản lý quan hệ KH)

```bash
# Danh sách bảng CRM
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/crm/tables?api_key=$PANCAKE_POS_API_KEY"

# Records trong bảng
curl -s "https://pos.pages.fm/api/v1/shops/{SHOP_ID}/crm/{TABLE_ID}/records?api_key=$PANCAKE_POS_API_KEY"
```

---

## 26. 🔧 Models (Schema)

```bash
curl -s "https://pos.pages.fm/api/v1/models?api_key=$PANCAKE_POS_API_KEY"
```

---

## 🧠 Hướng dẫn chọn endpoint

| Khi user hỏi về... | Dùng endpoint |
|---|---|
| Đơn hàng hôm nay | `/orders` + filter by date |
| Doanh thu tuần/tháng | `/analytics/sale` + start_date & end_date |
| Tồn kho sản phẩm X | `/products/variations?search=X` |
| Tồn kho theo kho | `/warehouses` + `/inventory_histories` |
| Thu chi, lợi nhuận | `/transactions` |
| Nhà cung cấp | `/suppliers` |
| Lịch sử nhập hàng | `/purchases` |
| Kiểm kho | `/stocktakings` |
| Khuyến mãi đang chạy | `/promotions` |
| Mã giảm giá | `/vouchers` |
| Nhân viên | `/users` |
| Công nợ | `/debts` |
| Khách hàng VIP | `/customers` + `/customer_levels` |
| Combo sản phẩm | `/combos` |
| Đơn hoàn | `/return_orders` |
| Phân tích tồn kho | `/inventory_analytics/inventory` |

## ⚠️ LƯU Ý QUAN TRỌNG

1. **Luôn thêm `api_key=$PANCAKE_POS_API_KEY`** vào mọi request
2. **Shop ID mặc định: 407181592** — dùng nếu user không chỉ định
3. **Timestamp UTC**: Pancake trả thời gian UTC, cần +7h cho VN
4. **Phân trang**: Dùng `page_size` và `page_number` cho danh sách dài
5. **Nếu cần phân tích computed** (daily-dashboard tổng hợp): vẫn gọi Gateway
   ```bash
   curl -s "http://mh-os.railway.internal:8000/api/pancake/daily-dashboard/407181592?date=today"
   ```
