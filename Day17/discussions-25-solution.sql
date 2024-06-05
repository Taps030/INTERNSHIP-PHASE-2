-- Scenario-based Exercises - Views - MySQL #25

-- Scenario 1: Advanced Analytics Dashboard

    -- Create an inline view to calculate the daily total sales.
    create view daily_sales_inline_view as select date(orderDate) as order_date, sum(quantityOrdered * priceEach) as total_sales
    from orders join orderdetails using (orderNumber)
    group by order_date;

    -- Create an updatable view to show the number of orders for each day. Also include a functionality to update the order status in the same view.
    create view daily_orders as select date(orderDate) as order_date, count(orderNumber) as no_of_orders, status from orders group by order_date, status;
    -- to update the view: update daily_orders set status='new_status' where order_date='some_date';
    
    -- Create a view to identify the most purchased product of each day.
    create view daily_top_products as select date(orderDate) as order_date, productCode, sum(quantityOrdered) as total_quantity 
    from orders join orderdetails using(orderNumber) 
    group by order_date, productCode 
    order by total_quantity asc;

    -- Finally, combine these views to produce the required daily report.
    select distinct order_date, total_sales, no_of_orders, 
    (select productCode from daily_top_products where daily_top_products.order_date=daily_total_sales.order_date limit 1) as top_product 
    from daily_total_sales join daily_orders using(order_date) 
    join daily_top_products using(order_date);

-- Scenario 2: Sales Monitoring System

    -- Classic Models has a system to monitor the performance of sales reps. The sales reps' performance is judged based on the number of customers handled, total payments received, and the total number of orders. The details of sales reps are in the employees table and the sales are recorded in the orders and payments tables.

    -- Create a view that shows the total number of customers handled by each sales rep.
    create view rep_customers as select salesRepEmployeeNumber, count(distinct customerNumber) as no_of_customers 
    from customers 
    group by salesRepEmployeeNumber;

    -- Create a view that displays the total payments received by each sales rep.
    create view rep_total_payments as select salesRepEmployeeNumber, sum(amount) as total_payments 
    from customers 
    join payments using (customerNumber) 
    group by salesRepEmployeeNumber;

    -- Create another view that shows the total number of orders handled by each sales rep.
    create view rep_orders as select salesRepEmployeeNumber, count(distinct orderNumber) as no_of_orders 
    from customers 
    join orders using (customerNumber) 
    group by salesRepEmployeeNumber;

    -- Finally, create a combined view that uses the above views to display the performance of each sales rep.
    create view rep_performance as select rc.salesRepEmployeeNumber,rc.num_of_customers,rp.total_payments,ro.num_of_orders 
    from rep_customers rc inner join rep_total_payments rp on rc.salesRepEmployeeNumber = rp.salesRepEmployeeNumber 
    inner join rep_orders ro on rc.salesRepEmployeeNumber = ro.salesRepEmployeeNumber;

-- Scenario 3: HR and Sales Data Analysis

    -- Assume the Classic Models has recently acquired a company and you now also have access to the hr database. The management wants to know if there's a relationship between employee's department, age, and their sales performance.

    -- Create a view in the hr database that shows the department and age of each employee.
    create view emp_details as select employee_id, department_id, TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) as age 
    from employees; -- In the given hr database the employees table doesn't contain birth_date column --
    
    -- Create a view in the classicmodels database that shows the sales performance of each employee.
    create view emp_sales_performance as select salesRepEmployeeNumber, sum(amount) as total_sales 
    from customers join payments using (customerNumber) 
    group by salesRepEmployeeNumber;        
    