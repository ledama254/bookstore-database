USE BookStoreDB;
DROP TABLE IF EXISTS 
  book_author, 
  book, 
  author, 
  book_language, 
  publisher, 
  customer_address, 
  customer, 
  address, 
  address_status, 
  country, 
  order_line, 
  cust_order, 
  shipping_method, 
  order_history, 
  order_status;
-- Use the database
USE BookStoreDB;

-- 1. book_language
CREATE TABLE book_language (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    language_name VARCHAR(100) NOT NULL
);

-- 2. publisher
CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

-- 3. book
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    publisher_id INT,
    language_id INT,
    price DECIMAL(10, 2),
    publication_date DATE,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

-- 4. author
CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

-- 5. book_author
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- 6. country
CREATE TABLE country (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(100) NOT NULL
);

-- 7. address
CREATE TABLE address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    street VARCHAR(255),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- 8. address_status
CREATE TABLE address_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL
);

-- 9. customer
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255),
    phone_number VARCHAR(20)
);

-- 10. customer_address
CREATE TABLE customer_address (
    customer_address_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    address_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- 11. shipping_method
CREATE TABLE shipping_method (
    shipping_method_id INT PRIMARY KEY AUTO_INCREMENT,
    method_name VARCHAR(100)
);

-- 12. order_status
CREATE TABLE order_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50)
);

-- 13. cust_order
CREATE TABLE cust_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    shipping_method_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- 14. order_line
CREATE TABLE order_line (
    order_line_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    book_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- 15. order_history
CREATE TABLE order_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    status_id INT,
    change_date DATETIME,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);
SHOW TABLES;
-- Insert languages
INSERT INTO book_language (language_name) VALUES ('English'), ('Swahili');

-- Insert publishers
INSERT INTO publisher (name) VALUES ('Penguin Books'), ('Macmillan Publishers');

-- Insert books
INSERT INTO book (title, publisher_id, language_id, price, publication_date) 
VALUES 
('Learn MySQL', 1, 1, 2000.00, '2025-04-13'),
('Advanced SQL', 2, 1, 2500.00, '2025-03-15');

-- Insert authors
INSERT INTO author (first_name, last_name) VALUES ('John', 'Doe'), ('Jane', 'Smith');

-- Link books to authors
INSERT INTO book_author (book_id, author_id) VALUES (1, 1), (2, 2);

-- Insert countries
INSERT INTO country (country_name) VALUES ('Kenya'), ('Uganda');

-- Insert address status
INSERT INTO address_status (status_name) VALUES ('Current'), ('Old');

-- Insert addresses
INSERT INTO address (street, city, postal_code, country_id) 
VALUES 
('Buruburu', 'Nairobi', '00515', 1),
('Nkrumah Road', 'Mombasa', '80100', 1);

-- Insert customer
INSERT INTO customer (first_name, last_name, email, phone_number) 
VALUES 
('Joshua', 'Ledama', 'joshualedama3@gmail.com', '+254725401725');

-- Link customer to address
INSERT INTO customer_address (customer_id, address_id, status_id) VALUES (1, 1, 1);

-- Insert shipping methods
INSERT INTO shipping_method (method_name) VALUES ('Postal Mail'), ('Courier');

-- Insert order statuses
INSERT INTO order_status (status_name) VALUES ('Pending'), ('Shipped'), ('Delivered');

-- Insert customer order
INSERT INTO cust_order (customer_id, order_date, shipping_method_id, status_id)
VALUES (1, '2025-04-13', 2, 1);

-- Insert order lines (books in the order)
INSERT INTO order_line (order_id, book_id, quantity) VALUES (1, 1, 2), (1, 2, 1);

-- Insert order history
INSERT INTO order_history (order_id, status_id, change_date) 
VALUES (1, 1, NOW());
-- View customer orders with book details
SELECT 
    c.first_name, c.last_name, b.title, ol.quantity, co.order_date
FROM customer c
JOIN cust_order co ON c.customer_id = co.customer_id
JOIN order_line ol ON co.order_id = ol.order_id
JOIN book b ON ol.book_id = b.book_id;
-- Create admin user
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'adminpass';
GRANT ALL PRIVILEGES ON BookStoreDB.* TO 'admin_user'@'localhost';

-- Create read-only user
CREATE USER 'readonly_user'@'localhost' IDENTIFIED BY 'readonlypass';
GRANT SELECT ON BookStoreDB.* TO 'readonly_user'@'localhost';
-- Create admin user
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'adminpass';
GRANT ALL PRIVILEGES ON BookStoreDB.* TO 'admin_user'@'localhost';

-- Create read-only user
CREATE USER 'readonly_user'@'localhost' IDENTIFIED BY 'readonlypass';
GRANT SELECT ON BookStoreDB.* TO 'readonly_user'@'localhost';

