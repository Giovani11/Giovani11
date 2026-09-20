# 📑 Test Scenarios & Requirements Traceability Matrix (RTM)

## 1. Overview
This document outlines high-level test scenarios mapped directly to business and functional requirements for the **SwiftShop Web Portal**.

---

## 2. Requirements Traceability Matrix (RTM)

| Req ID | Requirement Description | Scenario ID | High-Level Test Scenario | Test Type |
| :--- | :--- | :--- | :--- | :--- |
| **REQ-AUTH-01** | User registration with email verification | **TS-AUTH-01** | Verify user can successfully register with valid details and receive email verification link | Functional / Positive |
| **REQ-AUTH-02** | Form field validation on registration | **TS-AUTH-02** | Verify registration form displays inline errors for invalid emails, weak passwords, and duplicate accounts | Negative / BVA |
| **REQ-AUTH-03** | User login with credentials | **TS-AUTH-03** | Verify existing user can log in with valid email/password and redirect to homepage | Functional / Positive |
| **REQ-AUTH-04** | Security lockout on failed attempts | **TS-AUTH-04** | Verify user account locks for 15 minutes after 5 consecutive invalid password attempts | Security / Negative |
| **REQ-PROD-01** | Product keyword search | **TS-PROD-01** | Verify search bar returns accurate matching items for full titles, partial keywords, and SKU numbers | Functional / Positive |
| **REQ-PROD-02** | Product search with special/empty query | **TS-PROD-02** | Verify search behavior when entering SQL keywords, HTML tags, or non-existent items | Negative / Security |
| **REQ-PROD-03** | Product filtering by category & price | **TS-PROD-03** | Verify filtering products by category and dynamic price slider updates product grid accurately | Functional |
| **REQ-PROD-04** | Product sorting | **TS-PROD-04** | Verify sorting options (Price: Low to High, High to Low, Top Rated) order the results correctly | Functional |
| **REQ-CART-01** | Add to shopping cart | **TS-CART-01** | Verify item can be added to cart from product list and details page with quantity update badge | Functional / Positive |
| **REQ-CART-02** | Stock limit constraint in cart | **TS-CART-02** | Verify user cannot add more units than currently available in warehouse stock | Boundary / Negative |
| **REQ-CART-03** | Coupon code discounts | **TS-CART-03** | Verify application of valid percentage, fixed amount, and expired discount coupons | Functional / Negative |
| **REQ-CART-04** | Cart state persistence | **TS-CART-04** | Verify cart items persist across page refreshes, tab closing, and post-login session merge | Session / State |
| **REQ-CHK-01** | Shipping address entry | **TS-CHK-01** | Verify address form enforces mandatory fields, valid postal codes, and phone number formats | Functional / Negative |
| **REQ-CHK-02** | Payment calculation & checkout | **TS-CHK-02** | Verify final price breakdown matches subtotal + shipping fee + tax - coupon discount | Calculation / Integrity |
| **REQ-CHK-03** | Credit Card Payment Gateway | **TS-CHK-03** | Verify successful transaction using sandbox Visa/Mastercard and graceful handling of declined cards | Integration / Payment |
| **REQ-CHK-04** | Double submission prevention | **TS-CHK-04** | Verify clicking "Place Order" button multiple times does not result in duplicate charges or duplicate orders | Concurrency / Integrity |
