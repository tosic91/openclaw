---
name: order-processing
description: Handle order inquiries, check status, and process fulfillment tasks
trigger: When user asks about orders, shipping, or delivery status
---

# Order Processing Skill

## When to Use
- Customer asks about order status
- Founder asks for order summary
- Need to check pending/new orders

## Steps

### 1. Identify the Query
- Is this a specific order lookup? → Use order ID
- Is this a general summary? → Use daily dashboard
- Is this about pending orders? → Check pending alerts

### 2. Fetch Data
```
# Specific order
GET /api/pancake/orders-summary/{shop_id}?date=today

# Daily dashboard
GET /api/pancake/daily-dashboard/{shop_id}?date=today

# Customer lookup
GET /api/pancake/customers/{shop_id}?search={phone_or_name}
```

### 3. Format Response
- For customers: friendly, reassuring tone
- For Founder: data-first, concise, with insights
- Always include: order ID, status, amount, channel
- Format money as VNĐ, dates as dd/mm/yyyy

### 4. Escalation
- Order stuck > 2 hours → flag to Founder
- VIP order (>500K) → prioritize
- Missing/wrong items → escalate immediately
