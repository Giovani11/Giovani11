-- ====================================================================
-- QA TEST SUITE: 05 - Business Rules & State Transition Validations
-- Objective: Detect chronological anomalies, invalid statuses, and future timestamps
-- ====================================================================

-- Test 5.1: State chronology: Delivery timestamp before Shipping timestamp
-- Expected: Flag order_id 1004 (shipped on 2026-03-17, delivered on 2026-03-16)
SELECT
    order_id,
    order_status,
    shipped_at,
    delivered_at,
    'FAIL: Order marked delivered before it was marked shipped' AS chronology_defect
FROM orders
WHERE delivered_at IS NOT NULL
  AND shipped_at IS NOT NULL
  AND delivered_at < shipped_at;


-- Test 5.2: Future-dated order creation detection
-- Expected: Flag order_id 1005 (created_at = '2099-12-31')
SELECT
    order_id,
    user_id,
    created_at,
    'FAIL: Order creation timestamp is set in the future' AS timeline_anomaly
FROM orders
WHERE created_at > CURRENT_TIMESTAMP;


-- Test 5.3: Completed payments for orders that are still marked 'CANCELLED'
SELECT
    o.order_id,
    o.order_status,
    p.payment_id,
    p.payment_status,
    p.amount_paid,
    'FAIL: Order is marked CANCELLED despite having an active SUCCESS payment' AS business_rule_violation
FROM orders o
JOIN payments p ON o.order_id = p.order_id
WHERE o.order_status = 'CANCELLED' AND p.payment_status = 'SUCCESS';
