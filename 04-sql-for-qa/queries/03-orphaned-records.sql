-- ====================================================================
-- QA TEST SUITE: 03 - Referential Integrity & Orphaned Record Detection
-- Objective: Detect foreign keys pointing to non-existent primary keys
-- ====================================================================

-- Test 3.1: Find orders placed by non-existent users
-- Expected: Flag order_id 1003 (user_id 999 does not exist in users table)
SELECT
    o.order_id,
    o.user_id AS invalid_user_id,
    o.total_amount,
    o.created_at,
    'FAIL: Order references a user_id that does not exist in users table' AS integrity_defect
FROM orders o
LEFT JOIN users u ON o.user_id = u.user_id
WHERE u.user_id IS NULL;


-- Test 3.2: Find order items pointing to non-existent orders
-- Expected: Flag item_id 5006 (order_id 9999 does not exist in orders table)
SELECT
    oi.item_id,
    oi.order_id AS missing_order_id,
    oi.product_id,
    oi.quantity,
    oi.line_total,
    'FAIL: Orphaned order item with no corresponding order record' AS integrity_defect
FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;


-- Test 3.3: Find payment transactions recorded for non-existent orders
-- Expected: Flag payment_id 7004 (order_id 8888 does not exist)
SELECT
    p.payment_id,
    p.order_id AS missing_order_id,
    p.transaction_reference,
    p.amount_paid,
    p.payment_status,
    'FAIL: Orphaned payment with no corresponding order in database' AS integrity_defect
FROM payments p
LEFT JOIN orders o ON p.order_id = o.order_id
WHERE o.order_id IS NULL;
