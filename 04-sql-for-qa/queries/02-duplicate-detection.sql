-- ====================================================================
-- QA TEST SUITE: 02 - Duplicate Detection
-- Objective: Detect duplicate customer accounts, duplicate payments, and idempotency leaks
-- ====================================================================

-- Test 2.1: Detect duplicate registered email addresses across users
-- Expected: Flag 'alice@example.com' appearing twice
SELECT
    email,
    COUNT(user_id) AS occurrence_count,
    GROUP_CONCAT(user_id) AS conflicting_user_ids,
    'FAIL: Email address must be unique across all user accounts' AS defect_description
FROM users
GROUP BY email
HAVING COUNT(user_id) > 1;


-- Test 2.2: Detect double-billing (multiple successful payments for the exact same order)
-- Expected: Flag order_id 1002 having 2 successful charges within seconds
SELECT
    order_id,
    COUNT(payment_id) AS total_successful_payments,
    SUM(amount_paid) AS total_charged_amount,
    GROUP_CONCAT(transaction_reference) AS transaction_ids,
    'FAIL: Potential double-charge detected! Order has multiple successful payments' AS alert_level
FROM payments
WHERE payment_status = 'SUCCESS'
GROUP BY order_id
HAVING COUNT(payment_id) > 1;
