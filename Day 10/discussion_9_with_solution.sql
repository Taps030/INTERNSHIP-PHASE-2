-- Write a query to list the number of jobs available in the employees table.

> select count(distinct job_id) as 'Number of jobs' from employees;

-- Write a query to get the total salaries payable to employees.

> select sum(salary) as total_salary from employees;

-- Write a query to get the minimum salary from the employees table.

> select min(salary) as 'Minimum salary'  from employees;

-- Write a query to get the maximum salary of an employee working as a Programmer.

> select max(salary) as 'Max Salary' from employees inner join jobs using(job_id)
    -> where job_title='Programmer';

-- Write a query to get the average salary and number of employees working in department 90.

> select avg(salary) as "avreage salry", count(*) as 'employee in department 90'
    -> from employees where department_id=90;

-- Write a query to get the highest, lowest, sum, and average salary of all employees

> select max(salary) as 'max salary',min(salary) as 'min salary', sum(salary) as 'sum salary',avg(salary) as 'avg salary'
    -> from employees;

-- Write a query to get the number of employees with the same job.

> select count(*) as 'number of employee', job_id from employees
    -> group by job_id;

-- Write a query to get the difference between the highest and lowest salaries.

> select max(salary)-min(salary) as difference from employees;

-- Write a query to find the manager ID and the salary of the lowest-paid employee for that manager.

> select manager_id,min(salary)  from employees
    -> group by manager_id;

-- Write a query to get the department ID and the total salary payable in each department.

> select department_id,sum(salary) from employees group by department_id;

-- Write a query to get the average salary for each job ID excluding programmer.

> select job_id,avg(salary) from employees where job_id in
    -> (select job_id from jobs where job_title <>'Programmer')
    -> group by job_id;

-- Write a query to get the total salary, maximum, minimum, average salary of employees (job ID wise), for department ID 90 only.

> select job_id,min(salary),max(salary),avg(SALARY) from employees
    -> where department_id=90 group by job_id;

-- Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000.

> select job_id,max(salary) from employees
    -> group by job_id
    -> having max(salary)>=4000 ;

-- Write a query to get the average salary for all departments employing more than 10 employees.

>  select avg(salary),count(*) from employees group by department_id
    -> having count(employee_id)>10;