# 🧪 Detailed Test Cases: SwiftShop E-Commerce Web Portal

This document contains full test case specifications designed for the **SwiftShop Web Portal**.

---

### Module 1: User Authentication & Security

#### TC-AUTH-001: Successful User Registration with Valid Data
* **Module**: Authentication
* **Type**: Positive / Functional
* **Priority**: High (P1) | **Severity**: Major (S2)
* **Pre-conditions**: User is on registration page (`/register`), not logged in.
* **Test Data**:
  - Name: `Alex Morgan`
  - Email: `alex.qa.test+01@example.com`
  - Password: `Password123!#`
  - Confirm Password: `Password123!#`
* **Steps to Execute**:
  1. Navigate to `https://staging.swiftshop-test.internal/register`.
  2. Enter valid Name, Email, Password, and Confirm Password into respective fields.
  3. Check "I agree to Terms & Conditions".
  4. Click the "Create Account" button.
* **Expected Result**: Account is created, user sees flash notification "Registration successful. Please verify your email.", and redirect occurs to onboarding/dashboard.
* **Actual Result**: As expected. Account created and confirmation token generated.
* **Status**: **PASS** ✅

---

#### TC-AUTH-002: Registration Form Validation with Invalid Email and Mismatched Passwords
* **Module**: Authentication
* **Type**: Negative / Validation
* **Priority**: High (P1) | **Severity**: Major (S2)
* **Pre-conditions**: User is on registration page.
* **Test Data**:
  - Email: `alex_invalid_email.com` (missing `@`)
  - Password: `Password123!`
  - Confirm Password: `Password456!`
* **Steps to Execute**:
  1. Enter invalid email and non-matching passwords.
  2. Click "Create Account".
* **Expected Result**: Inline error displays under email: *"Please enter a valid email address"* and under confirm password: *"Passwords do not match"*. Form submission is blocked.
* **Actual Result**: As expected. Form blocked; errors highlighted in red.
* **Status**: **PASS** ✅

---

#### TC-AUTH-003: Account Lockout after 5 Consecutive Failed Login Attempts
* **Module**: Authentication / Security
* **Type**: Security / Boundary
* **Priority**: Critical (P0) | **Severity**: Critical (S2)
* **Pre-conditions**: Registered user exists (`gio.qa@example.com`).
* **Test Data**:
  - Email: `gio.qa@example.com`
  - Incorrect Password: `WrongPass123!` (entered 5 times)
* **Steps to Execute**:
  1. Navigate to `/login`.
  2. Enter email and incorrect password. Click "Log In". Repeat 5 times consecutively.
  3. On the 6th attempt, enter the *correct* password.
* **Expected Result**: On the 5th failed attempt, system locks the account and displays: *"Your account has been temporarily locked due to multiple failed login attempts. Please try again in 15 minutes or reset your password."* 6th attempt with correct password remains rejected while locked.
* **Actual Result**: As expected. Redis cache lock enforced for 15 minutes.
* **Status**: **PASS** ✅

---

### Module 2: Product Search, Filter & Catalog

#### TC-PROD-001: Search with Valid Alphanumeric Keyword
* **Module**: Product Catalog
* **Type**: Positive / Functional
* **Priority**: High (P1) | **Severity**: Major (S3)
* **Pre-conditions**: User is on homepage with database populated with electronic items.
* **Test Data**: Keyword: `Wireless Headphones`
* **Steps to Execute**:
  1. Click on the global search input bar.
  2. Type `Wireless Headphones` and press Enter.
* **Expected Result**: Product grid displays all items whose title, tags, or description contain "Wireless Headphones". Result counter shows *"Found 14 products"*.
* **Actual Result**: As expected. 14 relevant products displayed.
* **Status**: **PASS** ✅

---

#### TC-PROD-002: Search Field XSS / SQL Injection Vulnerability Check
* **Module**: Product Catalog / Security
* **Type**: Security / Negative
* **Priority**: Critical (P0) | **Severity**: Blocker (S1)
* **Pre-conditions**: User is on product search page.
* **Test Data**: Payload: `<script>alert('XSS-TEST')</script>` and `' OR '1'='1`
* **Steps to Execute**:
  1. Input malicious script payload into search bar.
  2. Submit search query.
* **Expected Result**: Input is sanitized and encoded by the backend. No JavaScript pop-up is executed. Page renders: *"No products found for '<script>alert('XSS-TEST')</script>'"*.
* **Actual Result**: As expected. Sanitized cleanly.
* **Status**: **PASS** ✅

---

#### TC-PROD-003: Filter by Price Slider & Category
* **Module**: Product Catalog
* **Type**: Functional / Filter
* **Priority**: Medium (P2) | **Severity**: Major (S3)
* **Pre-conditions**: Category "Electronics" contains products ranging from $10 to $1,500.
* **Steps to Execute**:
  1. Select Category filter: "Audio".
  2. Set Min Price: `$50`, Max Price: `$200`.
  3. Click "Apply Filters".
* **Expected Result**: All displayed products belong to "Audio" category and have prices satisfying: `$50 <= Price <= $200`.
* **Actual Result**: **FAIL** ❌ (Products with price `$200.50` and `$205` are still returned due to rounding error in the SQL backend clause).
* **Defect Logged**: **BUG-002**

---

### Module 3: Shopping Cart & Promotions

#### TC-CART-001: Add Item to Cart and Verify Badge Count
* **Module**: Shopping Cart
* **Type**: Positive / Functional
* **Priority**: High (P1) | **Severity**: Major (S2)
* **Pre-conditions**: User views product details page for "Ergonomic Mechanical Keyboard" ($120.00).
* **Steps to Execute**:
  1. Select quantity: `2`.
  2. Click "Add to Cart".
* **Expected Result**: Header shopping cart icon updates counter to `2`. Sliding drawer opens displaying 2 units with subtotal `$240.00`.
* **Actual Result**: As expected.
* **Status**: **PASS** ✅

---

#### TC-CART-002: Exceeding Warehouse Available Stock
* **Module**: Shopping Cart / Boundary
* **Type**: Boundary / Negative
* **Priority**: High (P1) | **Severity**: Major (S2)
* **Pre-conditions**: Product "Limited Edition Mousepad" has only `3` units remaining in stock.
* **Steps to Execute**:
  1. Navigate to product page.
  2. Try to increment quantity selector beyond 3 (e.g. enter `5`).
  3. Click "Add to Cart".
* **Expected Result**: Increment button disables at 3. If manually typed `5`, an alert displays: *"Only 3 items available in stock"*, and cart adds only 3 items.
* **Actual Result**: As expected.
* **Status**: **PASS** ✅

---

#### TC-CART-003: Applying Expired Coupon Code
* **Module**: Shopping Cart / Promotions
* **Type**: Negative / Business Rules
* **Priority**: Medium (P2) | **Severity**: Major (S3)
* **Pre-conditions**: Cart has items totaling $100.
* **Test Data**: Promo code: `SUMMER2023` (expired on 31 Aug 2023).
* **Steps to Execute**:
  1. In cart checkout drawer, enter `SUMMER2023` in Promo Code field.
  2. Click "Apply".
* **Expected Result**: Coupon is rejected. Red banner states: *"This promotional code has expired."* Subtotal remains $100.
* **Actual Result**: As expected.
* **Status**: **PASS** ✅

---

#### TC-CART-004: Cart Persistence After Browser Refresh
* **Module**: Shopping Cart / Session
* **Type**: State / Persistence
* **Priority**: High (P1) | **Severity**: Major (S3)
* **Pre-conditions**: Guest user adds 2 items to cart.
* **Steps to Execute**:
  1. Close the browser tab or hit `F5` / `Cmd+R` hard refresh.
  2. Reopen the website.
* **Expected Result**: Cart items and quantities are preserved from LocalStorage / Session cookies.
* **Actual Result**: As expected.
* **Status**: **PASS** ✅

---

### Module 4: Checkout & Payment Gateway

#### TC-CHK-001: Place Order with Valid Sandbox Credit Card
* **Module**: Checkout
* **Type**: End-to-End / Positive
* **Priority**: Blocker (P0) | **Severity**: Blocker (S1)
* **Pre-conditions**: User logged in, cart subtotal = $150.00.
* **Test Data**:
  - Address: `123 Quality Assurance Way, San Francisco, CA 94105`
  - Card Number: `4242 4242 4242 4242` (Stripe Sandbox Success)
  - Exp: `12/28` | CVC: `123`
* **Steps to Execute**:
  1. Proceed to `/checkout`.
  2. Fill in valid shipping address.
  3. Select "Standard Shipping" ($10.00). Tax = $12.80. Total = $172.80.
  4. Select "Credit Card" payment method and fill test card details.
  5. Click "Pay & Place Order".
* **Expected Result**: Payment succeeds. User redirected to `/order-confirmation?order_id=SWIFT-8921`. Receipt details match total $172.80.
* **Actual Result**: As expected. Transaction logged in payment sandbox.
* **Status**: **PASS** ✅

---

#### TC-CHK-002: Double-Clicking "Place Order" Button Prevention
* **Module**: Checkout / Concurrency
* **Type**: Edge Case / Concurrency
* **Priority**: Critical (P0) | **Severity**: Blocker (S1)
* **Pre-conditions**: User on final payment confirmation screen.
* **Steps to Execute**:
  1. Click the "Pay & Place Order" button rapidly 3 times in less than 500ms.
* **Expected Result**: Button enters `disabled` state with a loading spinner after the first click to prevent duplicate payment API calls. Only one order and one charge are generated.
* **Actual Result**: **FAIL** ❌ (Button is NOT disabled immediately. Rapid double-click triggers two parallel `POST /api/v1/orders` requests, creating duplicate orders with identical card charge).
* **Defect Logged**: **BUG-001 (BLOCKER)**

---

#### TC-CHK-003: Declined Credit Card Handling
* **Module**: Checkout / Payment
* **Type**: Negative / Integration
* **Priority**: High (P1) | **Severity**: Critical (S2)
* **Pre-conditions**: User on checkout payment step.
* **Test Data**: Test Card: `4000 0000 0000 0002` (Stripe Sandbox Card Declined)
* **Steps to Execute**:
  1. Enter declined test card number and submit payment.
* **Expected Result**: System catches gateway error and displays user-friendly message: *"Your card was declined. Please check your card details or try an alternate payment method."* User remains on payment screen without data loss.
* **Actual Result**: As expected.
* **Status**: **PASS** ✅
