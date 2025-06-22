-- Print-on-Demand Order Manager SQL Assignment
-- Author: [Your Name]
-- Description: Full database schema, sample data, and queries for order management

-- =======================
-- 1. DATABASE SCHEMA
-- =======================

-- USER MANAGEMENT
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('customer', 'admin', 'staff') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_deleted BOOLEAN DEFAULT FALSE
);

-- SHIPPING ADDRESSES
CREATE TABLE shipping_addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    address_line VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    zip_code VARCHAR(20),
    country VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- PRODUCT CATALOG
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    size VARCHAR(50),
    color VARCHAR(50),
    material VARCHAR(100),
    price DECIMAL(10,2),
    inventory_quantity INT,
    is_deleted BOOLEAN DEFAULT FALSE
);

-- ORDERS
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    address_id INT,
    order_total DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (address_id) REFERENCES shipping_addresses(address_id)
);

-- ORDER ITEMS
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    custom_print_details TEXT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ORDER STATUS TRACKING
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status ENUM('Pending', 'In Production', 'Shipped', 'Delivered', 'Cancelled') NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- AUDIT TRAIL
CREATE TABLE order_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    action VARCHAR(255),
    performed_by INT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (performed_by) REFERENCES users(user_id)
);

-- RETURNS AND REFUNDS
CREATE TABLE order_returns (
    return_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    reason TEXT,
    refund_amount DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- =======================
-- 2. SAMPLE DATA
-- =======================

-- Users
INSERT INTO users (name, email, password, role) VALUES
('Alice', 'alice@example.com', 'hashedpass1', 'customer'),
('Bob', 'bob@example.com', 'hashedpass2', 'admin'),
('Charlie', 'charlie@example.com', 'hashedpass3', 'staff'),
('Diana', 'diana@example.com', 'hashedpass4', 'customer');

-- Addresses
INSERT INTO shipping_addresses (user_id, address_line, city, state, zip_code, country) VALUES
(1, '123 Street', 'Delhi', 'Delhi', '110001', 'India'),
(2, '456 Avenue', 'Mumbai', 'Maharashtra', '400001', 'India'),
(3, '789 Lane', 'Bangalore', 'Karnataka', '560001', 'India');

-- Products
INSERT INTO products (name, description, size, color, material, price, inventory_quantity) VALUES
('Custom T-Shirt', 'Print-ready T-Shirt', 'L', 'Red', 'Cotton', 499.00, 50),
('Mug', 'Personalized Mug', 'Medium', 'White', 'Ceramic', 299.00, 100),
('Custom Hoodie', 'Warm custom hoodie', 'XL', 'Black', 'Fleece', 899.00, 75),
('Notebook', 'Custom printed notebook', 'A5', 'Blue', 'Paper', 199.00, 200);

-- Orders
INSERT INTO orders (user_id, address_id, order_total) VALUES
(1, 1, 1297.00),
(2, 2, 1697.00),
(3, 3, 1498.00);

-- Order Items
INSERT INTO order_items (order_id, product_id, quantity, price, custom_print_details) VALUES
(1, 1, 2, 499.00, 'Front logo print'),
(1, 2, 1, 299.00, 'Name print'),
(2, 3, 1, 899.00, 'Back side print'),
(2, 4, 4, 199.00, 'Front cover image'),
(3, 1, 1, 499.00, 'Sleeve text'),
(3, 3, 1, 899.00, 'Hood print');

-- Order Status
INSERT INTO order_status (order_id, status) VALUES
(1, 'Pending'),
(2, 'In Production'),
(3, 'Pending');

-- Audit Trail
INSERT INTO order_audit (order_id, action, performed_by) VALUES
(1, 'Order Placed', 1),
(2, 'Order Placed', 2),
(2, 'Status Updated to In Production', 2),
(3, 'Order Placed', 3);

-- Returns
INSERT INTO order_returns (order_id, reason, refund_amount) VALUES
(2, 'Damaged on delivery', 500.00);

-- =======================
-- 3. SQL QUERIES
-- =======================

-- a. Place a new order (simplified: assume existing user & products)
-- Insert into orders, then into order_items, then deduct inventory and set status

-- b. Update Order Status
UPDATE order_status SET status = 'In Production', updated_at = CURRENT_TIMESTAMP WHERE order_id = 1;

-- c. Retrieve all orders for a user
SELECT * FROM orders WHERE user_id = 1;

-- d. List inventory levels
SELECT product_id, name, inventory_quantity FROM products;

-- e. Report of orders by status
SELECT status, COUNT(*) as total_orders FROM order_status GROUP BY status;

-- =======================
-- END OF FILE
-- =======================
