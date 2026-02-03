CREATE DATABASE IF NOT EXISTS electronics_store;
USE electronics_store;

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) COMMENT 'Таблица категорий товаров (3NF)';

CREATE TABLE brands (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL UNIQUE,
    country VARCHAR(100),
    founded_year YEAR,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) COMMENT 'Таблица производителей (3NF)';

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(200) NOT NULL,
    category_id INT NOT NULL,
    brand_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price > 0),
    stock_quantity INT DEFAULT 0 CHECK (stock_quantity >= 0),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (category_id) 
        REFERENCES categories(category_id) 
        ON DELETE RESTRICT,
        
    FOREIGN KEY (brand_id) 
        REFERENCES brands(brand_id) 
        ON DELETE RESTRICT,
        
    INDEX idx_category (category_id),
    INDEX idx_brand (brand_id),
    INDEX idx_price (price)
) COMMENT 'Основная таблица товаров (3NF)';

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    registration_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_email (email),
    INDEX idx_name (last_name, first_name)
) COMMENT 'Таблица клиентов магазина (3NF)';

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) DEFAULT 0.00,
    status ENUM(
        'pending',      
        'processing',   
        'shipped',      
        'delivered',    
        'cancelled'     
    ) DEFAULT 'pending',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (customer_id) 
        REFERENCES customers(customer_id) 
        ON DELETE CASCADE,
        
    INDEX idx_customer (customer_id),
    INDEX idx_status (status),
    INDEX idx_date (order_date)
) COMMENT 'Таблица заказов (3NF)';

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price > 0),
    subtotal DECIMAL(10, 2) GENERATED ALWAYS AS (quantity * unit_price) STORED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (order_id) 
        REFERENCES orders(order_id) 
        ON DELETE CASCADE,
        
    FOREIGN KEY (product_id) 
        REFERENCES products(product_id) 
        ON DELETE RESTRICT,
        
    UNIQUE KEY unique_order_product (order_id, product_id),
    INDEX idx_order (order_id),
    INDEX idx_product (product_id)
) COMMENT 'Таблица позиций заказа (связующая, 3NF)';


CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date DATE NOT NULL,
    is_verified BOOLEAN DEFAULT FALSE, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (product_id) 
        REFERENCES products(product_id) 
        ON DELETE CASCADE,
        
    FOREIGN KEY (customer_id) 
        REFERENCES customers(customer_id) 
        ON DELETE CASCADE,
        
    UNIQUE KEY unique_product_customer (product_id, customer_id),
    INDEX idx_product_rating (product_id, rating),
    INDEX idx_customer (customer_id)
) COMMENT 'Таблица отзывов о товарах (3NF)';


CREATE TABLE discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NULL, 
    category_id INT NULL,
    discount_percent DECIMAL(5,2) NOT NULL CHECK (discount_percent BETWEEN 0 AND 100),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (product_id) 
        REFERENCES products(product_id) 
        ON DELETE CASCADE,
        
    FOREIGN KEY (category_id) 
        REFERENCES categories(category_id) 
        ON DELETE CASCADE,
        
    CHECK (product_id IS NOT NULL OR category_id IS NOT NULL),
    INDEX idx_dates (start_date, end_date),
    INDEX idx_product (product_id)
) COMMENT 'Таблица скидок (дополнительная)';

SELECT 'Схема базы данных создана успешно!' as message;
SELECT COUNT(*) as tables_count FROM information_schema.tables 
WHERE table_schema = 'electronics_store';
