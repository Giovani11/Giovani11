# 📋 SwiftShop Web Application - Manual Testing Portfolio

![Manual Testing](https://img.shields.io/badge/Testing_Type-Manual_Testing-blue?style=for-the-badge)
![App Type](https://img.shields.io/badge/AUT-E--Commerce_Web_App-orange?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)

A comprehensive, production-grade manual testing project showcasing end-to-end Quality Assurance processes for **SwiftShop**, a modern multi-vendor e-commerce platform.

---

## 📌 1. What Was Tested?
The scope of testing focused on critical end-user journeys and financial transactions across the **SwiftShop Web Portal (v2.4.0)**:

1. **User Authentication & Account Security**:
   - Registration with email verification & password policy validation.
   - Login, logout, persistent sessions, password reset flows.
   - Account lockout after 5 consecutive failed login attempts.
2. **Product Catalog, Search & Filtering**:
   - Keyword search with autocomplete and special character handling.
   - Multi-facet filtering (Category, Price range slider, Customer ratings).
   - Dynamic sorting (Price Low-to-High, High-to-Low, Newest arrivals).
3. **Cart & Promotional Discounts**:
   - Add/remove items, update quantity with boundary value checks (0, 1, max stock).
   - Cart persistence across browser refresh and user login sessions.
   - Coupon/discount code validation (valid, expired, minimum spend thresholds).
4. **Checkout & Payment Processing**:
   - Shipping address validation (postal code format, required field alerts).
   - Payment gateway integration (Credit/Debit card, Digital Wallet, Cash on Delivery).
   - Order summary calculations (Subtotal, Tiered Shipping, Tax, Discounts).
5. **Order Confirmation & Tracking**:
   - Order ID generation, invoice generation, email dispatch verification.

---

## 🛠️ 2. Which Tools Were Used?

| Tool / Technology | Purpose |
| :--- | :--- |
| **Jira Software** | Test management, sprint planning, and bug tracking |
| **TestRail** | Test case design, repository structure, and execution runs |
| **Google Sheets / CSV** | Traceability matrix and portable test case format |
| **Chrome DevTools** | Network payload inspection, console error capture, mobile device emulation, and cookie/session storage verification |
| **BrowserStack / CrossBrowserTesting** | Compatibility testing across Chrome, Firefox, Safari, and Edge on Windows and macOS |
| **Lighthouse** | Quick performance and accessibility (a11y) spot checks |

---

## 🚀 3. How Can Someone Review / Run This Project?

This repository contains all formal QA deliverables organized into dedicated folders:

1. **Test Strategy & Scope**: Read the [Test Plan](./docs/01-test-plan.md) to understand objectives, test environments, entry/exit criteria, and risk mitigation.
2. **Requirements Traceability**: Review [Test Scenarios](./docs/02-test-scenarios.md) to see how functional requirements are mapped to high-level test scenarios.
3. **Detailed Test Cases**:
   - Read formatted [Detailed Test Cases](./test-cases/test-cases-detailed.md) for step-by-step instructions, test data, and expected outcomes.
   - Or inspect [test-cases.csv](./test-cases/test-cases.csv) ready for import into Jira, Xray, or TestRail.
4. **Defect Tracking**: Inspect [Bug Reports](./bug-reports/BUG-REPORTS.md) to review realistic Jira-style bug tickets with reproduction steps, severity/priority tags, and root cause notes.
5. **Execution Results & Sign-Off**: Check the [Test Execution Report](./reports/test-execution-report.md) for pass/fail statistics, bug distribution, and the QA sign-off decision.
6. **Testing Checklists**: Use the [Testing Checklist](./checklists/testing-checklist.md) for Smoke, Sanity, Regression, and Pre-Release checklists.

---

## 🔍 4. What Scenarios Were Covered?

| Category | Scenarios Covered |
| :--- | :--- |
| **Positive Testing** | Happy path login, successful item purchase, valid coupon application, address autocomplete |
| **Negative Testing** | Invalid login credentials, SQL injection attempts in login fields, exceeding inventory quantity, applying expired coupons |
| **Boundary Value Analysis (BVA)** | Input fields at minimum (1 char), maximum (255 chars), cart quantity limits (0, 1, 99, 100), price filter extremes |
| **Equivalence Class Partitioning (ECP)** | Postal code formats, email address formats, discount code validity classes |
| **Session & State Management** | Cart retention after browser restart, auto-logout upon session expiration, concurrent logins |
| **Cross-Browser & Responsiveness** | UI rendering on Desktop (1920x1080), Tablet (iPad Air), and Mobile (iPhone 14 / Pixel 7) |
| **Error Handling & UX** | Clear field-level error messages, disabled buttons during API calls to prevent double submission |

---

## 📊 Summary Metrics

```
Total Test Cases Designed:  25
Executed:                   25 (100%)
Passed:                     21 (84%)
Failed:                      4 (16%)
Bugs Reported:               4 (1 Blocker, 1 Critical, 2 Major)
Release Decision:           ⚠️ CONDITIONAL PASS (Pending hotfix for Blocker BUG-001)
```
