# ✅ Quality Assurance Testing Checklists

Standard checklists used across different phases of the software release lifecycle for the **SwiftShop Web Portal**.

---

## 1. 💨 Smoke Testing Checklist (Post-Deployment Sanity)
> *Executed immediately after deployment to Staging or Production to verify core build stability (< 15 mins).*

- [ ] **Environment Health**: Homepage loads within 2.5s and returns HTTP `200 OK`.
- [ ] **SSL / Security**: HTTPS certificate is valid with no mixed-content console warnings.
- [ ] **Database Connectivity**: Database healthcheck endpoint (`/api/health`) returns status `UP`.
- [ ] **Authentication**: User can successfully log in with known test credentials and log out.
- [ ] **Search Bar**: Submitting a basic query ("shirt") returns relevant product items.
- [ ] **Product Page**: Product detail page renders title, image, price, and "Add to Cart" button.
- [ ] **Cart Flow**: Adding an item increments cart counter and displays in checkout drawer.
- [ ] **Checkout Smoke**: Can reach the payment selection page without 500 errors.

---

## 2. 🔍 Sanity Testing Checklist (Specific Feature Verification)
> *Executed when a specific build fixes a bug or adds a targeted minor enhancement.*

- [ ] **Bug Verification**: Verify the specific defect reproduction steps now result in expected behavior.
- [ ] **Negative Boundary Check**: Test input bounds immediately adjacent to the fixed code.
- [ ] **Direct Dependencies**: Test closely coupled features (e.g. if payment gateway was updated, test order confirmation and email trigger).
- [ ] **Console Inspection**: Confirm no uncaught exceptions (`Uncaught TypeError`, etc.) appear in browser console.

---

## 3. 🔄 Regression Testing Checklist (Full Release Candidate)
> *Comprehensive checklist executed prior to major version releases to prevent regressions.*

### User Management & Security
- [ ] User registration with valid email, invalid email, and duplicate email.
- [ ] Password complexity enforcement (letters, numbers, symbols, min length 8).
- [ ] "Forgot Password" reset link token expiration check.
- [ ] 5-minute inactivity session expiration check.
- [ ] Prevention of SQL Injection & Cross-Site Scripting (XSS) in all input fields.

### Product Catalog & Search
- [ ] Pagination controls (Next, Previous, First, Last, Jump to page).
- [ ] Sorting by: Price Ascending, Price Descending, Newest, Best Seller.
- [ ] Filtering with combined criteria (e.g. Category: Shoes + Size: 10 + Color: Black).
- [ ] "Clear All Filters" button resets grid to default view.
- [ ] Empty state page ("No products found") contains recommendations or links.

### Shopping Cart & Checkout
- [ ] Modify item quantity from 1 to 10; verify price multiplies accurately.
- [ ] Remove single item from multi-item cart.
- [ ] "Clear Cart" button clears entire cart state.
- [ ] Free shipping threshold calculation (e.g. orders > $100 receive free shipping).
- [ ] Coupon code: Percentage discount applied properly to eligible items only.
- [ ] Coupon code: Fixed amount discount does not reduce total below $0.00.
- [ ] Order confirmation page displays unique Order ID, billing address, and itemized receipt.
- [ ] Customer receives HTML order confirmation receipt via email within 2 minutes.

---

## 4. 📱 Responsive & Cross-Browser Checklist

- [ ] **Chrome (macOS / Windows)**: Layout, font rendering, and modal popups.
- [ ] **Firefox (macOS / Windows)**: Form inputs, datepickers, and scroll behaviors.
- [ ] **Safari (macOS / iOS)**: CSS Grid/Flexbox alignments, date formats, sticky headers.
- [ ] **Microsoft Edge**: Payment redirect flows and cookies.
- [ ] **Mobile Breakpoints (375px - 480px)**: Hamburger navigation menu, touch tap targets >= 48px, horizontal scroll prevention.
- [ ] **Tablet Breakpoints (768px - 1024px)**: 2-column to 3-column grid transitions.

---

## 5. 🚀 Pre-Release / Production Deployment Checklist

- [ ] **Code Freeze**: No further pull requests merged to `release/2.4.0` branch.
- [ ] **All Test Cases Executed**: 100% test case execution confirmed in TestRail/Jira.
- [ ] **Zero Blocker / Critical Bugs**: All P0/P1 bugs resolved and verified in staging.
- [ ] **Third-Party Credentials**: Production API keys (Stripe, SendGrid, Google Maps) verified in env vault.
- [ ] **Rollback Plan**: Previous stable build artifact tagged and rollback database migration script tested.
- [ ] **QA Lead Sign-Off**: Formal release approval delivered to Product and DevOps leads.
