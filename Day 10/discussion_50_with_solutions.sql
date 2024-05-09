-- Part 1: Understanding GROUP BY and Aggregate Functions Scenario
-- Tasks
-- 1.1:- Product Performance Analysis: Generate a report showing the total sales per product line. Include the product line, 
-- the total number of products sold, and the total sales amount.

> select productLine, count(*) as total_products_sold, sum(quantityOrdered*priceEach) as total_sales_amount
    -> from products join orderdetails
    -> using (productCode)
    -> group by productLine;

-- 1.2:- Office Sales Analysis: Determine the total sales for each office, including office city, number of orders processed, and total sales amount.

> select o.city as office_city, count(distinct ord.orderNumber) as total_orders_processed, sum(od.quantityOrdered * od.priceEach)  as total_sales
    -> from offices o
    -> join employees e using(officeCode)
    -> join customers c on e.employeeNumber=c.salesRepEmployeeNumber
    -> join orders ord using(customerNumber)
    -> join orderdetails od using(orderNumber)
    -> group by o.city;

-- Part 2: Filtering with HAVING Clause
-- Tasks
-- 2.1:- High-Value Order Analysis: Identify offices with an average order value greater than a certain threshold. Include office city, 
-- average order value, and total number of orders.

> select o.city as officeCity, avg(od.quantityOrdered*od.priceEach) as avg_order_value, count(distinct ord.orderNumber) as total_orders
    -> from offices o
    -> join employees e on o.officeCode=e.officeCode
    -> join customers c on e.employeeNumber=c.salesRepEmployeeNumber
    -> join orders ord on c.customerNumber=ord.customerNumber
    -> join orderdetails od on ord.orderNumber=od.orderNumber
    -> group by o.city
    -> having avg(od.quantityOrdered*od.priceEach)>3200;

-- 2.2:- Product Line Performance Filter: Filter product lines that have an average product sale price above a specific value.

> select productLine, avg(priceEach) as avg_product_sale_price
    -> from products
    -> join orderdetails using(productCode)
    -> group by productLine
    -> having avg(priceEach) > 100;

-- Part 3: Complex Aggregations and Grouping
-- Tasks
-- 3.1 Continent Analysis: For each continent, find the average population and total GDP. Filter out continents with an average
-- population below a certain threshold.

> select continent,avg(population) as avg_population,sum(gnp) as total_gdp
    -> from country
    -> group by continent;

-- Language Diversity: Identify countries with more than a specific number of official languages and display the country name, 
-- number of official languages, and total population.

> select c.name as country_name, count(cl.language) as total_languages
    -> from countrylanguage cl
    -> join country c on cl.CountryCode=c.code
    -> where cl.IsOfficial="T"
    -> group by c.name,cl.CountryCode
    -> having count(cl.language)>2;

-- Part 4: Time Series Analysis in classicmodels
-- Task 4.1: Month-over-Month Sales Growth
-- Objective: Calculate the month-over-month sales growth percentage for each product line.

-- Task 4.2: Quarterly Sales Analysis
-- Objective: Identify quarters with significantly higher sales for each office and investigate possible reasons.
> select year(orderDate) as orderYear,quarter(orderDate) as orderQuarter,o.officeCode,o.city as officeCity,
    -> sum(quantityOrdered * priceEach) as quarterlySales
    -> from orders ord
    -> join orderdetails od ON ord.orderNumber = od.orderNumber
    -> join customers c ON ord.customerNumber = c.customerNumber
    -> join employees e ON c.salesRepEmployeeNumber = e.employeeNumber
    -> join offices o ON e.officeCode = o.officeCode
    -> group by year(orderDate), quarter(orderDate), o.officeCode, officeCity;