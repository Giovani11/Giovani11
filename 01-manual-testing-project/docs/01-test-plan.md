# 📄 Master Test Plan: SwiftShop E-Commerce Web Portal (v2.4.0)

## 1. Introduction
This Test Plan outlines the testing strategy, scope, objectives, environment specifications, resource allocations, and defect management workflows for the **SwiftShop E-Commerce Web Portal (Release 2.4.0)**.

---

## 2. Scope of Testing

### 2.1 In Scope
- **User Authentication**: Sign-up, email verification, login/logout, password reset, account lockout.
- **Product Catalog & Discovery**: Search bar functionality, multi-facet filtering, sorting by price/rating.
- **Shopping Cart**: Add to cart, quantity update, item deletion, coupon code application, session persistence.
- **Checkout & Payment**: Multi-step checkout, shipping calculation, payment gateway sandbox (Cards & Wallets).
- **Cross-Browser Compatibility**: Chrome (latest 2 versions), Firefox (latest), Safari (16+), Edge.
- **Responsive Layouts**: Desktop (1920x1080), Laptop (1366x768), Tablet (768x1024), Mobile (375x812).

### 2.2 Out of Scope
- Native iOS / Android mobile applications (scheduled for sprint 2.5).
- Third-party vendor warehouse integration APIs.
- Extreme volume performance / stress testing (> 50,000 concurrent users; handled by dedicated DevOps/Perf team).

---

## 3. Test Strategy & Approaches

| Testing Type | Description | Objective |
| :--- | :--- | :--- |
| **Functional Testing** | Verify each business feature works according to functional requirements specification (FRS). | Ensure system correctness and data integrity. |
| **Negative Testing** | Provide invalid, malformed, or unexpected inputs. | Verify graceful error handling and prevent crashes or data leaks. |
| **Boundary Value Analysis (BVA)** | Test values at boundary edges (min, min+1, nominal, max-1, max). | Detect off-by-one errors and field overflow flaws. |
| **Exploratory Testing** | Unscripted, creative testing based on persona heuristics. | Discover edge-case UX bugs not covered by formal scripts. |
| **Cross-Browser Testing** | Test UI and rendering across major browser engines (Blink, Gecko, WebKit). | Ensure consistent experience across platforms. |
| **Regression Testing** | Re-test untouched modules after bug fixes. | Ensure fixes do not introduce new regressions. |

---

## 4. Test Environment & Configurations

* **Staging Server**: `https://staging.swiftshop-test.internal`
* **Test Database**: PostgreSQL 15 (Mock staging seed data with 2,500 products and 150 test accounts)
* **Payment Gateway**: Stripe & Midtrans Sandbox Test Mode
* **Browsers Tested**:
  - Google Chrome (v124+)
  - Mozilla Firefox (v125+)
  - Apple Safari (v17+)
  - Microsoft Edge (v124+)
* **Test Operating Systems**: macOS Sonoma, Windows 11, iOS 17, Android 14.

---

## 5. Entry & Exit Criteria

### 5.1 Entry Criteria
1. Test environment deployed and smoke test passed (100%).
2. Release candidate build (RC-2.4.0) tagged and delivered with release notes.
3. Test data seeded and payment gateway sandbox credentials verified.
4. Test cases reviewed and approved by QA Lead and Product Owner.

### 5.2 Exit Criteria
1. 100% of planned test cases executed.
2. 0 Blocker (P0) or Critical (P1) open defects.
3. All Major (P2) defects have documented workarounds or are accepted by Product Owner for patch v2.4.1.
4. Minimum 90% overall test pass rate.
5. Final Test Execution Summary Report published and signed off.

---

## 6. Defect Severity & Priority Matrix

| Severity | Definition | SLA for Resolution |
| :--- | :--- | :--- |
| **S1 - Blocker** | System crash, data corruption, payment gateway failure, unable to complete checkout. | < 4 hours |
| **S2 - Critical** | Core feature severely broken with no workaround (e.g. login fails for certain providers). | < 24 hours |
| **S3 - Major** | Feature broken, but acceptable manual workaround exists (e.g. filter reset button unresponsive). | < 3 days |
| **S4 - Minor / Trivial** | Cosmetic, typo, UI alignment imperfection, minor color inconsistency. | Next scheduled sprint |

---

## 7. Deliverables & Milestones

- ✅ **Test Plan Document**: Completed
- ✅ **Test Scenarios & Traceability Matrix**: Completed
- ✅ **Test Cases Specification**: Completed
- ✅ **Defect Tracking Reports**: Completed
- ✅ **Test Summary & Sign-off Report**: Completed
