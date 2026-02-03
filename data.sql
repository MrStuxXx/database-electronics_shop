USE electronics_shop;

INSERT INTO categories (category_name, description) VALUES
('Смартфоны', 'Мобильные телефоны'),
('Ноутбуки', 'Портативные компьютеры'),
('Наушники', 'Беспроводные и проводные наушники'),
('Планшеты', 'Планшетные компьютеры'),
('Аксессуары', 'Чехлы, зарядки и другие аксессуары');

INSERT INTO brands (brand_name, country) VALUES
('Apple', 'USA'),
('Samsung', 'South Korea'),
('Xiaomi', 'China'),
('Sony', 'Japan'),
('HP', 'USA');

INSERT INTO products (product_name, category_id, brand_id, price, stock_quantity) VALUES
('iPhone 15 Pro', 1, 1, 99999.99, 50),
('Samsung Galaxy S24', 1, 2, 89999.99, 30),
('MacBook Air M2', 2, 1, 129999.99, 20),
('Xiaomi Redmi Note 13', 1, 3, 24999.99, 100),
('Sony WH-1000XM5', 3, 4, 29999.99, 40),
('Samsung Galaxy Tab S9', 4, 2, 79999.99, 25),
('HP Pavilion 15', 2, 5, 64999.99, 15),
('Apple AirPods Pro', 3, 1, 24999.99, 60);

INSERT INTO customers (email, first_name, last_name, phone, registration_date) VALUES
('ivanov@mail.ru', 'Иван', 'Иванов', '+79161234567', '2024-01-15'),
('petrova@mail.ru', 'Мария', 'Петрова', '+79162345678', '2024-02-10'),
('sidorov@mail.ru', 'Алексей', 'Сидоров', '+79163456789', '2024-03-01'),
('smirnova@mail.ru', 'Анна', 'Смирнова', '+79164567890', '2024-02-28');

INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES
(1, '2024-03-01', 24999.99, 'delivered'),
(2, '2024-03-05', 154999.98, 'processing'),
(3, '2024-03-10', 29999.99, 'shipped');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 8, 1, 24999.99),  -- Иванов купил AirPods Pro
(2, 3, 1, 129999.99), -- Петрова купила MacBook Air
(2, 5, 1, 29999.99),  -- Петрова купила еще наушники Sony
(3, 5, 1, 29999.99);  -- Сидоров купил наушники Sony

INSERT INTO reviews (product_id, customer_id, rating, comment) VALUES
(8, 1, 5, 'Отличные наушники! Шумоподавление на высоте'),
(3, 2, 4, 'Ноутбук быстрый, но дорогой'),
(5, 3, 5, 'Лучшие наушники, которые у меня были!');
