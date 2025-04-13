# bookstore-database
PLP GROUP 67
# BookStore Database Project 📚

This project is a relational database for a bookstore, created using MySQL. It manages essential data about books, authors, customers, orders, and shipping methods.

## 🔧 Features
- Stores information on books, authors, customers, orders, and shipping.
- Supports many-to-many relationships between books and authors.
- Efficiently handles customer data, including their addresses.
- Provides various order statuses and shipping methods.
- Implements secure user roles with specific access rights (Admin and Read-Only).

## 📦 Tables Included
- **book**: Details of each book available in the store.
- **author**: Information about the authors.
- **book_author**: The relationship between books and authors (many-to-many).
- **customer**: Personal data about customers.
- **cust_order**: Orders placed by customers.
- **order_line**: Books that are part of an order.
- **address**: Customer's address details.
- **shipping_method**: Different types of shipping methods.
- **order_status**: Tracks the status of each order (pending, shipped, delivered).
- **order_history**: Keeps a history of the changes in order status.

## 👥 User Roles
- **admin_user**: Full access to all operations (create, read, update, delete).
- **readonly_user**: Only read (select) access to the data.

## 🛠 Tools Used
- **MySQL**: Database management system.
- **Draw.io**: Tool used to create the Entity Relationship Diagram (ERD).

## 🖼 ERD (Entity Relationship Diagram)
The ERD (schema design) is included as a .drawio file and exported as a PDF. It shows the relationships between the tables.

## ✅ Status
The project is complete and ready for evaluation. You can review the schema and sample queries to understand the functionality.

