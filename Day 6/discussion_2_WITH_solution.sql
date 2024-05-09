-- Write DDL statements to create a DB and tables as per the given schema:

> CREATE TABLE employees (
    ->   employeeNumber INT NOT NULL PRIMARY KEY,
    ->   lastName VARCHAR(50) NOT NULL,
    ->   firstName VARCHAR(50) NOT NULL,
    ->   extension VARCHAR(10),
    ->   email VARCHAR(100) NOT NULL,
    ->   officeCode CHAR(5) NOT NULL,
    ->   reportsTo INT,
    ->   jobTitle VARCHAR(50) NOT NULL
    -> );

> CREATE TABLE offices (
    ->   officeCode CHAR(5) NOT NULL PRIMARY KEY,
    ->   city VARCHAR(50) NOT NULL,
    ->   phone VARCHAR(50) NOT NULL,
    ->   addressLine1 VARCHAR(100) NOT NULL,
    ->   addressLine2 VARCHAR(100),
    ->   state VARCHAR(50),
    ->   postalCode VARCHAR(15),
    ->   country VARCHAR(50) NOT NULL,
    ->   territory VARCHAR(10)
    -> );

> CREATE TABLE customers (
    ->   customerNumber INT NOT NULL PRIMARY KEY,
    ->   customerName VARCHAR(50) NOT NULL, 
    ->   contactLastName VARCHAR(50) NOT NULL,  
    ->   contactFirstName VARCHAR(50) NOT NULL,
    ->   phone VARCHAR(50) NOT NULL,
    ->   addressLine1 VARCHAR(100) NOT NULL,
    ->   addressLine2 VARCHAR(100),
    ->   city VARCHAR(50) NOT NULL,
    ->   state VARCHAR(50),
    ->   postalCode VARCHAR(15),
    ->   country VARCHAR(50) NOT NULL,
    ->   salesRepEmployeeNumber INT,
    ->   creditLimit DECIMAL(10,2)
    -> );

> CREATE TABLE payments (
    ->   customerNumber INT NOT NULL,
    ->   checkNumber VARCHAR(50) NOT NULL,
    ->   paymentDate DATE NOT NULL,
    ->   amount DECIMAL(10,2) NOT NULL,
    ->   PRIMARY KEY (customerNumber, checkNumber),
    ->   FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
    -> );

> CREATE TABLE orders (
    ->   orderNumber INT NOT NULL PRIMARY KEY,
    ->   orderDate DATE NOT NULL,
    ->   requiredDate DATE NOT NULL,
    ->   shippedDate DATE,
    ->   status VARCHAR(15) NOT NULL,
    ->   comments TEXT,
    ->   customerNumber INT NOT NULL,
    ->   FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
    -> );

> CREATE TABLE products (
    ->   productCode VARCHAR(50) NOT NULL PRIMARY KEY,
    ->   productName VARCHAR(80) NOT NULL,
    ->   productLine VARCHAR(50) NOT NULL,
    ->   productScale VARCHAR(10),
    ->   productDescription VARCHAR(255),
    ->   quantityInStock SMALLINT NOT NULL,
    ->   buyPrice DECIMAL(10,2) NOT NULL,
    ->   MSRP DECIMAL(10,2) NOT NULL,
    ->   vendorId VARCHAR(50),
    ->   produceSize DECIMAL(10,2),
    ->   produceWeight DECIMAL(10,2),
    ->   imageFile VARCHAR(255),
    ->   active SMALLINT NOT NULL
    -> );

> CREATE TABLE products (
    ->   productCode VARCHAR(50) NOT NULL PRIMARY KEY,
    ->   productName VARCHAR(80) NOT NULL,
    ->   productLine VARCHAR(50) NOT NULL,
    ->   productScale VARCHAR(10),
    ->   productDescription VARCHAR(255),
    ->   quantityInStock SMALLINT NOT NULL,
    ->   buyPrice DECIMAL(10,2) NOT NULL,
    ->   MSRP DECIMAL(10,2) NOT NULL,
    ->   vendorId VARCHAR(50),
    ->   produceSize DECIMAL(10,2),
    ->   produceWeight DECIMAL(10,2),
    ->   imageFile VARCHAR(255),
    ->   active SMALLINT NOT NULL
    -> );

> CREATE TABLE orderdetails (
    ->   orderNumber INT NOT NULL,
    ->   productCode VARCHAR(50) NOT NULL,
    ->   quantityOrdered INT NOT NULL,
    ->   priceEach DECIMAL(10,2) NOT NULL,
    ->   orderLineNumber SMALLINT NOT NULL,
    ->   PRIMARY KEY (orderNumber, orderLineNumber),
    ->   FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber),
    ->   FOREIGN KEY (productCode) REFERENCES products(productCode)
    -> );

> CREATE TABLE productlines (
    ->   productLine VARCHAR(50) NOT NULL PRIMARY KEY,
    ->   textDescription VARCHAR(255),
    ->   htmlDescription VARCHAR(255),
    ->   image VARCHAR(255)
    -> );