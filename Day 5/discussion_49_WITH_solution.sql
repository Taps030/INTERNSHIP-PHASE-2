-- 1. Basic Data Selection
-- Objective: Learn to retrieve data from a single table.
-- Task: Query the country table to select the Name, Continent, and Population

select name,continent,population from country;


-- 2. Using Aliases for Columns and Tables
-- •	Objective: Improve query readability and manage column names in the result set.
-- •	Task: Use aliases to rename the Name column to Country Name and the country table as c in your queries.

select name as 'Country Name' from country as c;


-- 3. Filtering Data with Basic WHERE Clauses
-- •	Objective: Learn to filter data based on specific criteria.
-- •	Task: Find all countries in the 'Europe' continent with a population greater than 10 million.

select name,population from country where continent='Europe' and population>10000000;


-- 4. Combining Conditions with AND, OR
-- Objective: Use logical operators to combine multiple conditions in a WHERE clause.
-- Task: Retrieve all cities in 'Poland' or 'Belgium'.

select name,countrycode from city where countrycode='POL' or countrycode='BEL';

-- 5. Sorting Results with ORDER BY
-- objective: Order your query results based on one or more columns.
-- Task: List all countries in 'South America' by their LifeExpectancy in descending order.

select name,lifeexpectancy from country where continent='South America' order by lifeexpectancy desc;

-- 6. Limiting Results with LIMIT
-- Objective: Restrict the number of rows returned by a query.
-- Task: Get the top 5 largest cities by population in the database.

select name,population from city order by population desc limit 5;