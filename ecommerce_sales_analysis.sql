-- ============================================================
-- E-COMMERCE SALES DATA ANALYSIS
-- Database: ecommerce_sales_db
-- SQL Practice & Business Analysis Queries (Q1-Q20)
-- ============================================================
CREATE DATABASE ecommerce_sales_db;

USE ecommerce_sales_db;

-- 1. Customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50),
    signup_date DATE
);

-- 2. Products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10,2),
    stock_quantity INT
);

-- 3. Orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- 4. Order Items table
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

-- Check tables
SHOW TABLES;

USE ecommerce_sales_db;

INSERT INTO customers
(customer_id, customer_name, email, city, signup_date)
VALUES
(1, 'Rahul Sharma', 'rahul@gmail.com', 'Hyderabad', '2025-01-10'),
(2, 'Priya Reddy', 'priya@gmail.com', 'Bangalore', '2025-01-15'),
(3, 'Amit Kumar', 'amit@gmail.com', 'Chennai', '2025-02-05'),
(4, 'Sneha Patel', 'sneha@gmail.com', 'Mumbai', '2025-02-12'),
(5, 'Arjun Rao', 'arjun@gmail.com', 'Hyderabad', '2025-03-01'),
(6, 'Neha Singh', 'neha@gmail.com', 'Delhi', '2025-03-15'),
(7, 'Kiran Kumar', 'kiran@gmail.com', 'Pune', '2025-04-01'),
(8, 'Ananya Das', 'ananya@gmail.com', 'Kolkata', '2025-04-10'),
(9, 'Vikram Reddy', 'vikram@gmail.com', 'Hyderabad', '2025-05-05'),
(10, 'Meera Shah', 'meera@gmail.com', 'Mumbai', '2025-05-20');

INSERT INTO products
(product_id, product_name, category, unit_price, stock_quantity)
VALUES
(1, 'Laptop', 'Electronics', 55000, 20),
(2, 'Smartphone', 'Electronics', 25000, 35),
(3, 'Headphones', 'Accessories', 2000, 50),
(4, 'Keyboard', 'Accessories', 1500, 40),
(5, 'Office Chair', 'Furniture', 8000, 15),
(6, 'Study Table', 'Furniture', 6000, 12),
(7, 'Running Shoes', 'Fashion', 3000, 30),
(8, 'Backpack', 'Fashion', 1200, 45);

INSERT INTO orders
(order_id, customer_id, order_date, order_status)
VALUES
(101, 1, '2025-01-20', 'Delivered'),
(102, 2, '2025-01-22', 'Delivered'),
(103, 3, '2025-02-10', 'Shipped'),
(104, 4, '2025-02-15', 'Delivered'),
(105, 1, '2025-03-05', 'Delivered'),
(106, 5, '2025-03-12', 'Cancelled'),
(107, 6, '2025-03-18', 'Delivered'),
(108, 7, '2025-04-05', 'Shipped'),
(109, 8, '2025-04-12', 'Delivered'),
(110, 9, '2025-05-08', 'Delivered'),
(111, 2, '2025-05-15', 'Delivered'),
(112, 10, '2025-06-01', 'Returned'),
(113, 3, '2025-06-10', 'Delivered'),
(114, 5, '2025-06-15', 'Shipped'),
(115, 9, '2025-06-20', 'Delivered');

INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, unit_price)
VALUES
(1, 101, 1, 1, 55000),
(2, 101, 3, 2, 2000),
(3, 102, 2, 1, 25000),
(4, 102, 8, 2, 1200),
(5, 103, 4, 2, 1500),
(6, 103, 3, 1, 2000),
(7, 104, 5, 1, 8000),
(8, 104, 6, 1, 6000),
(9, 105, 2, 1, 25000),
(10, 105, 7, 2, 3000),
(11, 106, 1, 1, 55000),
(12, 107, 8, 3, 1200),
(13, 107, 3, 2, 2000),
(14, 108, 6, 1, 6000),
(15, 108, 5, 1, 8000),
(16, 109, 7, 2, 3000),
(17, 109, 8, 1, 1200),
(18, 110, 1, 1, 55000),
(19, 110, 4, 2, 1500),
(20, 111, 2, 2, 25000),
(21, 112, 5, 1, 8000),
(22, 113, 3, 3, 2000),
(23, 113, 4, 1, 1500),
(24, 114, 6, 2, 6000),
(25, 115, 1, 1, 55000);

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_items;
USE ecommerce_sales_db;


-- Q1. Total sales revenue from Delivered orders
SELECT
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered';


-- Q2. Top 5 best-selling products by quantity
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC, p.product_name
LIMIT 5;


-- Q3. Revenue by product category
SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.category
ORDER BY total_revenue DESC;


-- Q4. Number of orders in each order status
SELECT
    order_status,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_status;


-- Q5. Customers who placed more than one order
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;


-- Q6. Average order value (AOV) for Delivered orders
SELECT
    AVG(order_revenue) AS average_order_value
FROM (
    SELECT
        o.order_id,
        SUM(oi.quantity * oi.unit_price) AS order_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY o.order_id
) AS order_totals;


-- Q7. Highest-value Delivered order
SELECT
    o.order_id,
    SUM(oi.quantity * oi.unit_price) AS order_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY o.order_id
ORDER BY order_revenue DESC
LIMIT 1;

