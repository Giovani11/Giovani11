-- ====================================================================
-- SwiftShop Seed Data (Includes deliberate edge cases and anomalies
-- to simulate real QA backend database validation)
-- ====================================================================

-- 1. Users
INSERT INTO users (user_id, full_name, email, phone_number, is_active, created_at) VALUES
(1, 'Alice Johnson', 'alice@example.com', '+1-555-0199', 1, '2026-01-15 10:00:00'),
(2, 'Bob Smith', 'bob@example.com', '+1-555-0123', 1, '2026-02-10 11:30:00'),
(3, 'Charlie Brown', 'charlie@example.com', NULL, 1, '2026-03-01 09:15:00'),
(4, 'Duplicate Email Guy', 'alice@example.com', '+1-555-9999', 1, '2026-03-05 14:00:00'), -- ANOMALY: Duplicate email
(5, 'Inactive User', 'inactive@example.com', '+1-555-0000', 0, '2026-01-01 00:00:00');

-- 2. Products
INSERT INTO products (product_id, product_name, category, stock_quantity, unit_price, is_discontinued) VALUES
(101, 'Ergonomic Wireless Mouse', 'Electronics', 150, 49.99, 0),
(102, 'Mechanical Gaming Keyboard', 'Electronics', 80, 119.99, 0),
(103, 'USB-C Fast Charging Cable', 'Accessories', 500, 14.99, 0),
(104, 'Ghost Product (Negative Price)', 'Faulty', 10, -5.00, 0), -- ANOMALY: Negative unit_price
(105, 'Oversold Item (Negative Stock)', 'Electronics', -3, 29.99, 0); -- ANOMALY: Negative stock_quantity

-- 3. Orders
INSERT INTO orders (order_id, user_id, order_status, subtotal, shipping_fee, tax_amount, discount_amount, total_amount, created_at, shipped_at, delivered_at) VALUES
-- Order 1001: Valid completed order
(1001, 1, 'DELIVERED', 169.98, 10.00, 13.60, 0.00, 193.58, '2026-03-10 14:00:00', '2026-03-11 09:00:00', '2026-03-13 16:30:00'),

-- Order 1002: Math mismatch! (subtotal + shipping + tax - discount does not equal total_amount)
(1002, 2, 'PROCESSING', 119.99, 5.00, 9.60, 10.00, 250.00, '2026-03-12 11:20:00', NULL, NULL), -- ANOMALY: Total should be 124.59, but stored as 250.00!

-- Order 1003: Orphaned Order (user_id 999 does not exist in users table)
(1003, 999, 'PENDING', 49.99, 5.00, 4.00, 0.00, 58.99, '2026-03-14 08:45:00', NULL, NULL), -- ANOMALY: Orphaned user_id

-- Order 1004: Invalid state sequence (delivered_at before shipped_at)
(1004, 1, 'DELIVERED', 14.99, 5.00, 1.20, 0.00, 21.19, '2026-03-15 10:00:00', '2026-03-17 12:00:00', '2026-03-16 10:00:00'), -- ANOMALY: Delivered before shipped

-- Order 1005: Future dated order (placed in year 2099)
(1005, 3, 'PENDING', 49.99, 0.00, 4.00, 0.00, 53.99, '2099-12-31 23:59:59', NULL, NULL); -- ANOMALY: Future order date

-- 4. Order Items
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, line_total) VALUES
(5001, 1001, 101, 1, 49.99, 49.99),
(5002, 1001, 102, 1, 119.99, 119.99),
(5003, 1002, 102, 1, 119.99, 119.99),
(5004, 1003, 101, 1, 49.99, 49.99),
(5005, 1004, 103, 1, 14.99, 14.99),
(5006, 9999, 101, 2, 49.99, 99.98), -- ANOMALY: Orphaned item (order_id 9999 does not exist in orders table)
(5007, 1005, 101, -2, 49.99, -99.98); -- ANOMALY: Negative quantity

-- 5. Payments
INSERT INTO payments (payment_id, order_id, transaction_reference, payment_method, amount_paid, payment_status, payment_timestamp) VALUES
(7001, 1001, 'TXN_STRIPE_1001A', 'CREDIT_CARD', 193.58, 'SUCCESS', '2026-03-10 14:02:00'),
(7002, 1002, 'TXN_STRIPE_1002A', 'CREDIT_CARD', 124.59, 'SUCCESS', '2026-03-12 11:21:00'),
-- ANOMALY: Duplicate payment transaction for Order 1002
(7003, 1002, 'TXN_STRIPE_1002B', 'CREDIT_CARD', 124.59, 'SUCCESS', '2026-03-12 11:21:02'),
-- ANOMALY: Orphaned payment with non-existent order_id 8888
(7004, 8888, 'TXN_STRIPE_8888X', 'EWALLET', 75.00, 'SUCCESS', '2026-03-14 15:30:00');
