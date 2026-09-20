# 🤖 E2E Automation Testing Framework (Playwright + TypeScript)

![Playwright](https://img.shields.io/badge/Playwright-v1.43+-45ba4b?style=for-the-badge&logo=playwright&logoColor=white)
![TypeScript](https://img.shields.io/badge/TypeScript-5.x-3178c6?style=for-the-badge&logo=typescript&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-Page_Object_Model_(POM)-purple?style=for-the-badge)
![CI/CD](https://img.shields.io/badge/CI%2FCD-GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)

A production-grade, enterprise-ready end-to-end automation testing framework built with **Playwright**, **TypeScript**, and the **Page Object Model (POM)** pattern.

---

## 📌 1. What Was Tested?

The automation suite validates the complete user journey on **Sauce Demo** (`https://www.saucedemo.com`), the industry-standard benchmark e-commerce application:

1. **Authentication & Session State**:
   - Standard user login and redirect to inventory.
   - Account lockout error handling for restricted users (`locked_out_user`).
   - Rejection and error banner verification for invalid credentials.
   - Required field validation on empty input submission.
2. **Product Catalog, Filtering & Cart Operations**:
   - Price sorting ascending (*Low to High*) with mathematical array validation.
   - Price sorting descending (*High to Low*).
   - Alphabetical reverse sorting (*Z to A*).
   - Dynamic cart badge updates upon adding/removing items.
3. **End-to-End Checkout Flow**:
   - Adding items, reviewing cart contents, entering shipping details.
   - Calculation verification: item subtotal + tax + total.
   - Form boundary error handling when mandatory postal code is omitted.
   - Order finalization and receipt confirmation.

---

## 🛠️ 2. Which Tools Were Used?

| Tool / Dependency | Purpose |
| :--- | :--- |
| **Playwright Test** | Modern browser automation engine supporting Chromium, WebKit, and Firefox with auto-waiting |
| **TypeScript** | Strict compile-time type safety, cleaner IDE autocompletion, and refactoring confidence |
| **Page Object Model (POM)** | Clean architecture separating test logic from page selectors and DOM actions |
| **Playwright HTML Reporter** | Rich visual reports including step-by-step traces, console logs, and failure screenshots |
| **GitHub Actions** | Automated CI pipeline triggered on every pull request and push to main |

---

## 🚀 3. How Can Someone Run This Project?

### Prerequisites
* **Node.js**: v18.0.0 or higher
* **npm**: v9.0.0 or higher

### Installation Steps

```bash
# 1. Navigate to the automation project directory
cd 02-automation-testing-project

# 2. Install dependencies
npm install

# 3. Install Playwright browser binaries
npx playwright install chromium
# (Optional: install all browsers: npx playwright install)
```

### Execution Commands

```bash
# Run all tests in headless mode (default)
npm test

# Run tests in headed mode (watch browser UI in real time)
npm run test:headed

# Open Playwright interactive UI Mode (best for debugging & time-travel)
npm run test:ui

# Run tests against a specific browser
npm run test:chromium
npm run test:firefox
npm run test:webkit

# View the rich HTML test report
npm run report
```

---

## 🔍 4. What Scenarios Were Covered?

| Test Case ID | Suite | Scenario Description | Expected Outcome |
| :--- | :--- | :--- | :--- |
| **TC-AUTH-01** | `auth.spec.ts` | Valid login with `standard_user` | Redirect to `/inventory.html`, 6 products displayed |
| **TC-AUTH-02** | `auth.spec.ts` | Login attempt with `locked_out_user` | Access denied, *"Sorry, this user has been locked out"* shown |
| **TC-AUTH-03** | `auth.spec.ts` | Login with non-existent username & password | Access denied, *"Username and password do not match"* shown |
| **TC-AUTH-04** | `auth.spec.ts` | Login attempt with empty username | Form blocked, *"Username is required"* banner displayed |
| **TC-INV-01** | `inventory.spec.ts` | Price sorting: Low to High (`lohi`) | Product prices sorted strictly in ascending numeric order |
| **TC-INV-02** | `inventory.spec.ts` | Price sorting: High to Low (`hilo`) | Product prices sorted strictly in descending numeric order |
| **TC-INV-03** | `inventory.spec.ts` | Title sorting: Z to A (`za`) | Product titles sorted reverse alphabetically |
| **TC-INV-04** | `inventory.spec.ts` | Dynamic cart counter add/remove | Badge count increments on add, decrements on remove |
| **TC-CHK-01** | `checkout.spec.ts` | Full E2E purchase journey | Add item -> Checkout -> Fill Form -> Calculate Tax -> Finish |
| **TC-CHK-02** | `checkout.spec.ts` | Checkout with missing postal code | Form blocked, *"Error: Postal Code is required"* displayed |

---

## 🏗️ Project Architecture (Page Object Model)

```
02-automation-testing-project/
├── .github/workflows/e2e-tests.yml  # CI/CD Automated Pipeline
├── pages/                           # Encapsulated UI Selectors & Methods
│   ├── BasePage.ts                  # Shared page actions (navigate, wait, screenshot)
│   ├── LoginPage.ts                 # Form filling, submit, error extraction
│   ├── InventoryPage.ts             # Item listing, sorting, add/remove cart
│   ├── CartPage.ts                  # Cart verification, proceed to checkout
│   └── CheckoutPage.ts              # Multi-step checkout & completion
├── test-data/
│   └── testData.ts                  # Centralized test users, error strings, products
├── tests/                           # Clean test specifications
│   ├── auth.spec.ts
│   ├── inventory.spec.ts
│   └── checkout.spec.ts
├── playwright.config.ts             # Global configuration & multi-browser setup
├── tsconfig.json                    # TypeScript compiler options
└── package.json
```

---

## 📊 Test Reports & Failure Diagnostics

* **HTML Report**: Run `npm run report` after test execution to launch Playwright's interactive report viewer.
* **Auto-Artifacts**: Playwright is configured to automatically capture full-page screenshots, execution trace logs, and video recordings whenever a test assertion fails.
