USE dev;

-- Insert sample users
INSERT INTO users (name, email)
VALUES
('Alice Johnson', 'alice@example.com'),
('Bob Smith', 'bob@example.com'),
('Charlie Davis', 'charlie@example.com'),
('Diana Roberts', 'diana@example.com'),
('Ethan Lee', 'ethan@example.com');

-- Insert sample products
INSERT INTO products (name, price, stock)
VALUES
('Laptop', 75000.00, 10),
('Smartphone', 35000.00, 20),
('Headphones', 2000.00, 50),
('Keyboard', 1500.00, 30),
('Monitor', 12000.00, 15);

-- Insert sample orders (assuming user_ids from 1 to 5)
INSERT INTO orders (user_id, order_date, total_amount)
VALUES
(1, '2025-11-01', 77000.00),
(2, '2025-11-02', 35000.00),
(3, '2025-11-03', 21500.00),
(4, '2025-11-04', 12000.00),
(5, '2025-11-05', 2000.00);
