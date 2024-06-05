--Task - Subqueries - classicmodels DB #5

-- 1.Write a query to find customers whose payments are greater than the average payment using a subquery.
select customerNumber,checkNumber,amount from payments where amount > (select avg(amount) from payments);

-- 2.See the following customers and orders tables:
    --Use a subquery with NOT IN operator to find the customers who have not placed any orders.
select customerName from customers where customerNumber not in (select customerNumber from orders);

-- 3.Write a subquery that finds the maximum, minimum, and average number of items in sale orders from orderdetails.
select MAX(items),MIN(items),FLOOR(AVG(items)) from (select count(orderNumber) as items from orderdetails group by orderNumber) as derived_table;

-- 4.Unlike a standalone subquery, a correlated subquery is a subquery that uses the data from the outer query. In other words, a correlated subquery depends on the outer query. A correlated subquery is evaluated once for each row in the outer query.
    -- See the products table:
        --Use a correlated subquery to select products whose buy prices are greater than the average buy price of all products in each product line.
        --For each row in the products (or p1) table, the correlated subquery needs to execute once to get the average buy price of all products in the productline of that row.
        --If the buy price of the current row is greater than the average buy price returned by the correlated subquery, the query includes the row in the result set.
select productName,buyPrice from products where buyPrice > (select avg(buyPrice) from products);

-- 5.Let’s take a look at the orders and orderdetails tables:
    --Write a query that finds sales orders whose total values are greater than 60K as follows:
select o.orderNumber,sum(od.priceEach*od.quantityOrdered) as total from orders o,orderdetails od where o.orderNumber=od.orderNumber group by orderNumber having sum(priceEach*quantityOrdered)>60000;

-- 6.When a subquery is used with the EXISTS or NOT EXISTS operator, a subquery returns a Boolean value of TRUE or FALSE. The following query illustrates a subquery used with the EXISTS operator:
    --SELECT * FROM table_name WHERE EXISTS( subquery );
        --In the query above, if the subquery returns any rows, EXISTS subquery returns TRUE, otherwise, it returns FALSE.
        --Use the query in question no. 5 as a correlated subquery to find customers who placed at least one sales order with the total value greater than 60K by using the EXISTS operator:
select c.customerNumber,c.customerName from customers c where exists(select o.orderNumber,sum(od.priceEach*od.quantityOrdered) as total from orders o,orderdetails od where o.orderNumber=od.orderNumber and customerNumber=c.customerNumber group by orderNumber having sum(priceEach*quantityOrdered)>60000);

-- 7.Let's take a look at the orders and orderdetails table:
    --Write a query that gets the top five products by sales revenue in 2003 from the orders and orderdetails tables as follows:
select productCode,sum(quantityOrdered*priceEach)as sales from orderdetails inner join orders using(orderNumber) where year(shippedDate)=2003 group by productCode order by sales desc limit 5;

-- 8.You can use the result of the previous query as a derived table called top5product2003 and join it with the products table using the productCode column.. Then, find out the productName and sales of the top 5 products in 2003.
select productName,sales from (select productCode,floor(sum(quantityOrdered*priceEach)) as sales from orderdetails inner join orders using(orderNumber) where year(shippedDate)=2003 group by productCode order by sales desc limit 5) top5product2003 join products using(productCode);

-- 9.Suppose you have to label the customers who bought products in 2003 into 3 groups: platinum, gold, and silver with the following conditions:
    --Platinum customers who have orders with the volume greater than 100K.
    --Gold customers who have orders with the volume between 10K and 100K.
    --Silver customers who have orders with the volume less than 10K.
    --To form this query, you first need to put each customer into the respective group using CASE expression and GROUP BY to display the following:
select customerNumber,floor(sum(quantityOrdered*priceEach)) as sales,(case when (sum(quantityOrdered*priceEach)) > 100000 then 'Platinum' when (sum(quantityOrdered*priceEach)) between 10000 and 100000 then 'Gold' when (sum(quantityOrdered*priceEach)) < 10000 then 'Silver' end) as customerGroup from orderdetails inner join orders using(orderNumber) where year(shippedDate)=2003 group by customerNumber order by customerNumber;

-- 10.Use the previous query as the derived table to know the number of customers in each group: platinum, gold, and silver.
select customerGroup,count(customerGroup) as groupCount from (select customerNumber,floor(sum(quantityOrdered*priceEach)) as sales,(case when (sum(quantityOrdered*priceEach)) > 100000 then 'Platinum' when (sum(quantityOrdered*priceEach)) between 10000 and 100000 then 'Gold' when (sum(quantityOrdered*priceEach)) < 10000 then 'Silver' end) as customerGroup from orderdetails inner join orders using(orderNumber) where year(shippedDate)=2003 group by customerNumber order by customerNumber) as derived_table1 group by customerGroup;