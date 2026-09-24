# 🐛 Defect Tracking & Bug Reports: SwiftShop Web Portal

The following are standard Jira/GitHub-style bug reports logged during the manual test execution of **SwiftShop Web Portal (v2.4.0)**.

---

### [BUG-001] Rapid double-click on "Pay & Place Order" creates duplicate orders and double-charges credit card
* **Issue Key**: `SWIFT-1042` / `BUG-001`
* **Issue Type**: Bug
* **Severity**: **S1 - Blocker** 🔥
* **Priority**: **P0 - Blocker**
* **Status**: Open / In Review
* **Component**: Checkout & Payment Gateway
* **Reporter**: Yong Giovani Edbert (QA Engineer)
* **Assignee**: Backend Lead / Payment Team
* **Environment**:
  - Environment: Staging (`https://staging.swiftshop-test.internal`)
  - Browser: Google Chrome v124.0.6367.60 (macOS Sonoma 14.4)
  - Network: Fast 3G / Fiber 100Mbps

#### Description:
When a user clicks the "Pay & Place Order" button rapidly multiple times (simulating a double-click or impatient user), the client application fails to disable the submit button immediately. This sends duplicate `POST /api/v1/orders/checkout` requests with identical payloads to the backend, resulting in two separate orders created in the database and two authorization charges placed on the user's credit card.

#### Steps to Reproduce:
1. Log in with an active account (`testuser@swiftshop.com`).
2. Add any in-stock product to cart (e.g. *Mechanical Keyboard* - $120.00).
3. Proceed to `/checkout`.
4. Enter standard shipping address and sandbox payment details (Visa `4242...`).
5. Open Chrome DevTools > Network tab.
6. Click the **"Pay & Place Order"** button rapidly twice within ~300ms.

#### Expected Result:
1. Upon the first click, the button should immediately disable, show a spinner (`"Processing your order..."`), and ignore subsequent clicks.
2. The backend should utilize an idempotency key (`Idempotency-Key: <uuid>`) so duplicate requests within a time window return the cached response rather than processing a new charge.
3. Only **one** order ID and **one** credit card transaction are generated.

#### Actual Result:
1. The button remained clickable for ~450ms while awaiting the network response.
2. Two identical `POST /api/v1/orders/checkout` requests were sent (Status: 200 OK, latency 410ms and 425ms).
3. Database created Order `#SWIFT-8921` and `#SWIFT-8922`. Stripe dashboard confirms two separate charges of $120.00 against the customer token.

#### Network Logs & Visual Capture:
* 🎥 **Jam.dev Session Recording**: `https://jam.dev/c/swiftshop-bug-001-double-charge` (Includes console logs, DOM timeline, and network payloads)
* 📸 **BrowserStack Bug Capture**: `https://capture.browserstack.com/rec/swiftshop-s1-1042`
* 📖 **Scribe.how Step-by-Step Walkthrough**: `https://scribehow.com/shared/SwiftShop_Duplicate_Charge_Repro`

```http
Request 1: POST https://staging.swiftshop-test.internal/api/v1/orders/checkout
Payload: {"cart_id": 9812, "payment_token": "tok_1P345x", "amount": 120.00}
Response: 200 OK -> {"order_id": "SWIFT-8921", "status": "CONFIRMED"}

Request 2: POST https://staging.swiftshop-test.internal/api/v1/orders/checkout
Payload: {"cart_id": 9812, "payment_token": "tok_1P345x", "amount": 120.00}
Response: 200 OK -> {"order_id": "SWIFT-8922", "status": "CONFIRMED"}
```

#### Root Cause Analysis (RCA):
- Frontend: Missing `disabled={isSubmitting}` on the checkout button component.
- Backend: Endpoint lacks idempotency validation using an `Idempotency-Key` HTTP header.

---

### [BUG-002] Price slider filter includes items exceeding max price ceiling due to SQL integer casting
* **Issue Key**: `SWIFT-1045` / `BUG-002`
* **Issue Type**: Bug
* **Severity**: **S3 - Major**
* **Priority**: **P2 - Medium**
* **Status**: Open
* **Component**: Product Catalog & Search
* **Reporter**: Yong Giovani Edbert (QA Engineer)
* **Environment**: Staging | All Browsers

#### Description:
Filtering products by setting the maximum price to `$200` incorrectly displays products priced at `$200.50` and `$200.99`.

#### Steps to Reproduce:
1. Go to `/category/electronics`.
2. Adjust the Price Filter slider: Min = `$50`, Max = `$200`.
3. Click "Apply Filters".
4. Observe the returned product grid.

#### Expected Result:
Only products with `unit_price <= 200.00` are displayed.

#### Actual Result:
Product "Studio Stereo Headset" priced at `$200.75` appears in the results list.

#### Root Cause:
Backend query in `ProductRepository.ts` casts price filter to integer:
`WHERE price BETWEEN CAST(:min AS INT) AND CAST(:max AS INT)`
causing `$200.75` to be rounded down during evaluation.

---

### [BUG-003] User session terminates abruptly without warning when switching between checkout tabs
* **Issue Key**: `SWIFT-1049` / `BUG-003`
* **Issue Type**: Bug
* **Severity**: **S2 - Critical**
* **Priority**: **P1 - High**
* **Component**: Session & State Management
* **Reporter**: Yong Giovani Edbert (QA Engineer)

#### Description:
When a user opens two tabs of the checkout page simultaneously, modifying shipping details in Tab 2 instantly destroys the active cart session in Tab 1, causing an unhandled React error boundary crash (`TypeError: Cannot read properties of undefined (reading 'items')`).

---

### [BUG-004] Mobile viewport: Checkout sticky footer overlaps coupon code input on Safari iOS
* **Issue Key**: `SWIFT-1051` / `BUG-004`
* **Issue Type**: UI / Responsive Defect
* **Severity**: **S4 - Minor**
* **Priority**: **P3 - Low**
* **Component**: UI / Mobile CSS
* **Reporter**: Yong Giovani Edbert (QA Engineer)
* **Device**: iPhone 14 Pro, iOS 17.4, Mobile Safari

#### Description:
On mobile Safari when the on-screen keyboard appears, the sticky "Proceed to Payment" footer covers the coupon code input field and submit button, preventing the user from seeing what they are typing.
