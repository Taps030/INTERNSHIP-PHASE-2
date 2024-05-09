-- Part 1: Mastering Pattern Matching with LIKE
-- Task 1.1: Wildcard Searches for Product Names
-- Objective: Create a query to find product names that start with "Classic", include any characters in the middle, and end with "Car".

> select productName from products where productName like 'Classic%Car';

-- Task 1.2: Flexible Search for Customer Addresses
-- Objective: Identify all customer addresses that contain the word "Street" or "Avenue" in any part of the address field.

> select customerName, addressLine1 as customer_address from customers where addressLine1 like "%Street%" or addressLine1 like "%Avenue%";

-- Part 2: Utilizing Range Queries with BETWEEN
-- Task 2.1: Orders within a Price Range
-- Objective: Find all orders with total amounts between two values, indicating mid-range transactions.

> select orderNumber, sum(priceEach*quantityOrdered) as total_amount from orderdetails
    -> group by orderNumber having total_amount between 1000 and 2000;

-- Task 2.2: Payments within a Date Range
-- Objective: Retrieve all payments made within a specific date range, focusing on a high-activity period.

> select amount,paymentDate from payments where paymentDate between '2005-03-01' and '2005-05-31';

-- Part 3: Exploring Subqueries with ANY and ALL
-- Task 3.1: Orders Exceeding Average Sale Amount
-- Objective: Identify orders where the total amount exceeds the average sale amount across all orders.

> select orderNumber, sum(priceEach * quantityOrdered) as total_amount
    -> from orderdetails
    -> group by orderNumber
    -> having total_amount > ANY (select avg(priceEach * quantityOrdered) as avg_sale_amount from orderdetails);

-- Task 3.2: Products with Maximum Order Quantity
-- Objective: Find products that have been ordered in quantities equal to the maximum quantity ordered for any product.

> select productCode from orderdetails
    -> group by productCode
    -> having sum(quantityOrdered) = ALL (select max(total_quantity) from (select sum(quantityOrdered) as total_quantity from orderdetails group by productCode) as max_quantity_per_product);

-- Part 4: Combining Operators for Complex Queries
-- Task 4.1: High-Value Customers in Specific Regions
-- Objective: Identify customers who have made payments in the top 10% of all payments and are located in specific geographic regions.
-- Task 4.2: Seasonal Sales Analysis
-- Objective: Analyze sales data to identify products with significantly higher sales in specific seasons compared to their annual sales average.
