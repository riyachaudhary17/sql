CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);

INSERT INTO Authors1 (author_id, author_name) VALUES
(1, 'Author1'),
(2, 'Author2'),
(3, 'Author3');
CREATE TABLE Books1 (
    book_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    genre VARCHAR(100),
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

INSERT INTO Books1 (book_id, title, author_id, genre, price, stock_quantity) VALUES
(1, 'Book1', 1, 'Genre1', 19.99, 50),
(2, 'Book2', 2, 'Genre2', 29.99, 30),
(3, 'Book3', 1, 'Genre1', 24.99, 40);
CREATE TABLE Customers1 (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(15)
);
INSERT INTO Customers1 (customer_id, customer_name, email, phone) VALUES
(1, 'Customer1', 'customer1@example.com', '123-456-7890'),
(2, 'Customer2', 'customer2@example.com', '987-654-3210');
CREATE TABLE Orders1 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
INSERT INTO Orders1 (order_id, customer_id, order_date, total_amount) VALUES
(1, 1, '2024-02-01', 49.98),
(2, 2, '2024-02-05', 74.97);
CREATE TABLE OrderDetails1 (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);
INSERT INTO OrderDetails1 (order_detail_id, order_id, book_id, quantity, subtotal) VALUES
(1, 1, 1, 2, 39.98),
(2, 1, 2, 1, 9.99),
(3, 2, 3, 3, 74.97);
SELECT Books1.title, COUNT(OrderDetails1.book_id) AS total_sold
FROM Books1
JOIN OrderDetails1 ON Books1.book_id = OrderDetails1.book_id
GROUP BY Books1.title
ORDER BY total_sold DESC
LIMIT 10;
SELECT SUM(OrderDetails1.subtotal) AS total_revenue
FROM Orders1
JOIN OrderDetails1 ON Orders1.order_id = OrderDetails1.order_id
WHERE Orders1.order_date BETWEEN 'start_date' AND 'end_date';
