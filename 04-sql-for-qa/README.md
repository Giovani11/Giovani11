# 🗄️ SQL Practice & Backend Database Validation for QA

![SQL](https://img.shields.io/badge/SQL-Validation-blue?style=for-the-badge&logo=postgresql&logoColor=white)
![Database](https://img.shields.io/badge/Engine-SQLite%20%7C%20PostgreSQL%20%7C%20MySQL-orange?style=for-the-badge)
![Focus](https://img.shields.io/badge/Domain-Financial%20Reconciliation%20%26%20Integrity-success?style=for-the-badge)

A specialized collection of real-world database testing scripts and queries demonstrating practical backend validation skills for Quality Assurance Engineers.

---

## 📌 1. What Was Tested?

Backend database tables supporting the **SwiftShop E-Commerce Platform** (`users`, `products`, `orders`, `order_items`, and `payments`):

1. **Data Integrity & Constraint Violations**:
   - Detection of illegal negative values in financial/inventory fields (`unit_price <= 0`, `stock_quantity < 0`, `quantity <= 0`).
   - Audit of missing mandatory user contact attributes for active accounts.
2. **Duplicate & Idempotency Flaws**:
   - Identification of duplicate user account registrations across shared email addresses.
   - Double-billing detection: identifying orders with multiple successful payment transactions processed within seconds.
3. **Referential Integrity & Orphaned Records**:
   - Detection of orders linked to non-existent `user_id` values.
   - Detection of line items referencing deleted or non-existent `order_id` records.
   - Identification of stray payment transactions where no order record exists.
4. **Financial Reconciliation & Calculation Correctness**:
   - Formula validation: Verifying that `stored total_amount == subtotal + shipping_fee + tax_amount - discount_amount`.
   - Line-item rollup validation: Verifying that `order.subtotal == SUM(order_items.line_total)`.
5. **Business Logic & State Chronology**:
   - Chronological defects: Detecting orders marked `DELIVERED` before `SHIPPED`.
   - Future-dated timestamps: Detecting order creation dates set in the future.
   - State conflicts: Orders marked `CANCELLED` despite possessing successful payment records.

---

## 🛠️ 2. Which Tools Were Used?

| Tool / Engine | Purpose |
| :--- | :--- |
| **SQLite 3 / Python 3** | Zero-dependency in-memory execution and automated test runner (`run_sql_tests.py`) |
| **PostgreSQL / DBeaver** | Relational schema modeling, foreign key constraint evaluation, and graphical query profiling |
| **Standard ANSI SQL** | Portable query scripts compatible across SQLite, PostgreSQL, MySQL, and Oracle |

---

## 🚀 3. How Can Someone Run This Project?

### Option A: Run Automated Python Test Runner (Fastest & Zero Setup)

You can run the entire suite against an automated in-memory SQLite instance in a single command without installing any database server:

```bash
# Navigate to the SQL directory
cd 04-sql-for-qa

# Execute the runner script
python3 run_sql_tests.py
```

### Option B: Run in PostgreSQL / MySQL / SQLite CLI

If you prefer executing queries manually via DBeaver, pgAdmin, or command-line:

```bash
# 1. Initialize schema
sqlite3 swiftshop_qa.db < schema/01-schema.sql

# 2. Populate test records
sqlite3 swiftshop_qa.db < schema/02-seed-data.sql

# 3. Execute any query suite
sqlite3 -header -column swiftshop_qa.db < queries/04-financial-reconciliation.sql
```

---

## 🔍 4. What Scenarios Were Covered?

| Query Suite | Script File | Target Anomaly & QA Rule |
| :--- | :--- | :--- |
| **01 - Integrity** | `01-data-integrity-and-nulls.sql` | Detects products with `price <= 0`, negative inventory stock, or order item quantities `< 1`. |
| **02 - Duplicates** | `02-duplicate-detection.sql` | Uncovers duplicate registered emails and detects double-charges on payments. |
| **03 - Orphans** | `03-orphaned-records.sql` | Executes `LEFT JOIN` checks to flag foreign keys referencing missing parents. |
| **04 - Reconciliation**| `04-financial-reconciliation.sql` | Computes arithmetic discrepancy between recorded total amount and formula sum. |
| **05 - Business Rules** | `05-business-rule-validation.sql` | Flags illogical timestamps (`delivered_at < shipped_at`) and future-dated orders. |

---

## 💡 Why SQL Validation is Essential for QA Engineers

While UI testing verifies what the user sees, **backend database validation ensures data truth**. Bugs like race condition duplicate charges, silent calculation truncations, and uncascaded orphaned items are frequently undetectable on the frontend alone, making SQL proficiency a core differentiator for modern QA Engineers.
