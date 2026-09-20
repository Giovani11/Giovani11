-- ====================================================================
-- SwiftShop E-Commerce Core Database Schema
-- Compatible with SQLite, PostgreSQL, and MySQL
-- ====================================================================

CREATE TABLE IF NOT EXISTS users (
    user_id INTEGER PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone_number VARCHAR(20),
    is_active BOOLEAN DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(50) NOT NULL,
    stock_quantity INTEGER NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    is_discontinued BOOLEAN DEFAULT 0
);

CREATE TABLE IF NOT EXISTS orders (
    order_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    order_status VARCHAR(30) NOT NULL, -- PENDING, PROCESSING, SHIPPED, DELIVERED, CANCELLED
    subtotal DECIMAL(10, 2) NOT NULL,
    shipping_fee DECIMAL(10, 2) DEFAULT 0.00,
    tax_amount DECIMAL(10, 2) DEFAULT 0.00,
    discount_amount DECIMAL(10, 2) DEFAULT 0.00,
    total_amount DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    shipped_at TIMESTAMP,
    delivered_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS order_items (
    item_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    line_total DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS payments (
    payment_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    transaction_reference VARCHAR(100) NOT NULL,
    payment_method VARCHAR(50) NOT NULL, -- CREDIT_CARD, BANK_TRANSFER, EWALLET
    amount_paid DECIMAL(10, 2) NOT NULL,
    payment_status VARCHAR(30) NOT NULL, -- SUCCESS, FAILED, REFUNDED
    payment_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
