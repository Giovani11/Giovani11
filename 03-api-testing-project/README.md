# ⚡ Automated REST API Testing Suite (Postman + Newman)

![Postman](https://img.shields.io/badge/Postman-v10+-FF6C37?style=for-the-badge&logo=postman&logoColor=white)
![Newman](https://img.shields.io/badge/Newman_CLI-v6.x-orange?style=for-the-badge&logo=postman&logoColor=white)
![API Under Test](https://img.shields.io/badge/API-Restful--Booker-005571?style=for-the-badge)
![CI/CD](https://img.shields.io/badge/CI%2FCD-GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)

An automated, data-driven API test framework for RESTful web services powered by **Postman**, **Newman CLI**, and **Chai BDD Assertion Library**.

---

## 📌 1. What Was Tested?

Testing was conducted against the **Restful-Booker Booking Platform** (`https://restful-booker.herokuapp.com`), validating:

1. **Authentication Service (`POST /auth`)**:
   - Extraction and persistence of session authorization token into runtime environment variables.
   - Rejection and failure response handling when invalid credentials are provided.
2. **Booking Resource Lifecycle (Full CRUD)**:
   - **Create (`POST /booking`)**: Dynamic payload injection, HTTP 200 validation, booking ID capture.
   - **Read (`GET /booking/:id`)**: Schema contract validation, payload equality checks against generated variables.
   - **Update (`PUT /booking/:id`)**: Authorized updates modifying total price and additional requirements.
   - **Partial Update (`PATCH /booking/:id`)**: Modifying specific fields using JSON patch while maintaining data integrity.
   - **Delete (`DELETE /booking/:id`)**: Removal of booking and verification of HTTP 201 response.
3. **Data Integrity & Negative Edge Cases**:
   - Access control checks (verifying HTTP 403 Forbidden when modifying booking without a valid auth token).
   - Verifying HTTP 404 Not Found upon querying non-existent or deleted resource IDs.
   - Response time thresholds (< 1,500ms) to ensure API SLA adherence.

---

## 🛠️ 2. Which Tools Were Used?

| Tool / Technology | Purpose |
| :--- | :--- |
| **Postman** | API design, manual request debugging, test suite organization, and environment management |
| **Newman CLI** | Command-line runner executing Postman collections directly in terminal and automated CI/CD pipelines |
| **Chai Assertion Library** | JavaScript BDD testing syntax (`pm.test()`, `pm.expect()`) for status, headers, and schemas |
| **GitHub Actions** | Automated CI workflow running Newman tests on every code commit and PR |

---

## 🚀 3. How Can Someone Run This Project?

### Method A: Running via Newman CLI (Recommended)

1. **Prerequisites**: Ensure Node.js (v18+) is installed.
2. **Navigate to the directory**:
   ```bash
   cd 03-api-testing-project
   ```
3. **Install dependencies**:
   ```bash
   npm install
   ```
4. **Execute tests**:
   ```bash
   # Run full test collection with staging environment
   npm test

   # Run data-driven test with external JSON payload
   npm run test:data

   # Run and export JSON results to reports/
   npm run test:report
   ```

### Method B: Running via Postman Desktop App

1. Open the **Postman** desktop application.
2. Click **Import** (top left).
3. Select the files:
   - Collection: `collections/qa-api-portfolio.postman_collection.json`
   - Environment: `environments/staging.postman_environment.json`
4. In the top-right environment dropdown, select **"Restful-Booker Staging Environment"**.
5. Click on the collection name and click **Run Collection**.

---

## 🔍 4. What Scenarios Were Covered?

| Folder | Request Name | Method | Key Assertions & Scenarios |
| :--- | :--- | :---: | :--- |
| **01 - Auth** | Create Auth Token (Positive) | `POST` | Status 200, valid token string length >= 10, saves `authToken` to environment |
| **01 - Auth** | Create Auth Token (Negative) | `POST` | Status 200, error reason equals `"Bad credentials"`, no token issued |
| **02 - CRUD** | Create Booking | `POST` | Status 200, generates `bookingid`, request parameters match response object |
| **02 - CRUD** | Get Booking by ID | `GET` | Status 200, `Content-Type` is JSON, full contract schema validated |
| **02 - CRUD** | Full Update Booking | `PUT` | Status 200 with auth cookie, `totalprice` updated to 450 |
| **02 - CRUD** | Partial Update Booking | `PATCH` | Status 200 with auth cookie, specific field `additionalneeds` updated |
| **02 - CRUD** | Delete Booking | `DELETE` | Status 201 Created (confirmed deletion by service spec) |
| **02 - CRUD** | Verify Deleted Returns 404 | `GET` | Status 404 Not Found (confirms persistent deletion) |
| **03 - Security** | Update without Token | `PUT` | Status 403 Forbidden (verifies unauthorized state rejection) |
| **03 - Security** | Query Non-Existent ID | `GET` | Status 404 Not Found (verifies bounds validation) |

---

## 📊 Sample Execution Log

For a complete terminal log of the Newman test run, refer to [reports/sample-newman-summary.md](./reports/sample-newman-summary.md).
