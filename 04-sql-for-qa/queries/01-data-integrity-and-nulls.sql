-- ====================================================================
-- QA TEST SUITE: 01 - Data Integrity, Negative Values & Missing Fields
-- Objective: Detect illegal null values, negative prices, and negative quantities
-- ====================================================================

-- Test 1.1: Detect products with negative price or negative stock quantity
-- Expected: Flag product_id 104 (negative price) and 105 (negative stock)
SELECT
    product_id,
    product_name,
    stock_quantity,
    unit_price,
    CASE
        WHEN unit_price <= 0 THEN 'FAIL: Unit price must be strictly greater than 0'
        WHEN stock_quantity < 0 THEN 'FAIL: Stock quantity cannot be negative'
    END AS validation_error
FROM products
WHERE unit_price <= 0 OR stock_quantity < 0;


-- Test 1.2: Detect order items with invalid or negative quantities
-- Expected: Flag item_id 5007 (quantity -2)
SELECT
    item_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    line_total,
    'FAIL: Order item quantity must be >= 1' AS failure_reason
FROM order_items
WHERE quantity <= 0;


-- Test 1.3: Verify active users with missing contact phone numbers
-- Objective: Assess completeness of customer profile data
SELECT
    user_id,
    full_name,
    email,
    'WARNING: Active user missing contact phone number' AS qa_notice
FROM users
WHERE is_active = 1 AND (phone_number IS NULL OR TRIM(phone_number) = '');
