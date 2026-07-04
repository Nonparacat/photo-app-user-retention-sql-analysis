-- 01_create_tables.sql
-- SQLite-compatible table definitions.

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS orders;

CREATE TABLE users (
    user_id TEXT PRIMARY KEY,
    register_date DATE,
    channel TEXT,
    device TEXT,
    city TEXT,
    gender TEXT,
    age_group TEXT
);

CREATE TABLE events (
    event_id TEXT PRIMARY KEY,
    user_id TEXT,
    event_time DATETIME,
    event_date DATE,
    event_name TEXT
);

CREATE TABLE orders (
    order_id TEXT PRIMARY KEY,
    user_id TEXT,
    order_time DATETIME,
    order_date DATE,
    product_type TEXT,
    amount REAL,
    payment_status TEXT
);
