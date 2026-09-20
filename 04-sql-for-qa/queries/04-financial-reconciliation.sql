-- ====================================================================
-- QA TEST SUITE: 04 - Financial Reconciliation & Calculation Verification
-- Objective: Validate whether order total equals item sum + tax + shipping - discount
-- ====================================================================

-- Test 4.1: Mathematical integrity of order totals
-- Formula: total_amount MUST equal (subtotal + shipping_fee + tax_amount - discount_amount)
-- Expected: Flag order_id 1002 (stored as 250.00, but math yields 124.59)
SELECT
    order_id,
    subtotal,
    shipping_fee,
    tax_amount,
    discount_amount,
    total_amount AS stored_total,
    ROUND(subtotal + shipping_fee + tax_amount - discount_amount, 2) AS calculated_expected_total,
    ROUND(total_amount - (subtotal + shipping_fee + tax_amount - discount_amount), 2) AS variance,
    'FAIL: Discrepancy between stored total_amount and computed sum' AS defect_reason
FROM orders
WHERE ROUND(total_amount, 2) != ROUND(subtotal + shipping_fee + tax_amount - discount_amount, 2);


-- Test 4.2: Order Subtotal vs Sum of Order Items
-- Subtotal in orders table MUST match SUM(line_total) of its child order_items
SELECT
    o.order_id,
    o.subtotal AS order_table_subtotal,
    SUM(oi.line_total) AS items_sum,
    ROUND(o.subtotal - SUM(oi.line_total), 2) AS discrepancy,
    'FAIL: Order subtotal does not match sum of individual line items' AS defect_reason
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.subtotal
HAVING ROUND(o.subtotal, 2) != ROUND(SUM(oi.line_total), 2);
