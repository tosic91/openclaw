---
name: product-lookup
description: Tra cứu sản phẩm, giá, tồn kho cho khách hàng
trigger: Khi khách hỏi về sản phẩm, giá, còn hàng không
---
# Product Lookup
## Steps
1. `GET /api/pancake/products-summary/407181592?search={keyword}`
2. Parse: tên SP, giá, tồn kho (remain_quantity), variations
3. Trả lời thân thiện: "[Tên SP] giá [X]đ, còn [Y] cái ạ"
4. Gợi ý SP tương tự nếu không tìm thấy
