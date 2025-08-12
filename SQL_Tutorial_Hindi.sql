CREATE DATABASE testdb

DROP TABLE customer;

--CREATE TABLE
CREATE TABLE customer
(
CustID int PRIMARY KEY,
CustName varchar(50) NOT NULL,
Age int NOT NULL,
City char(50),
Salary numeric );

--INSERT COMMAND
INSERT INTO customer (CustID, CustName, Age, City, Salary)
VALUES
(1, 'sam', 26, 'Delhi', 9008),
(2, 'Ram', 19, 'Bangalore', 11000),
(3, 'Pam', 31, 'Mumbai', 6060),
(4, 'Sam', 42, 'Pune', 10000);

SELECT * FROM customer;

--UPDATE COMMAND
UPDATE customer
SET CustName = 'Xam' , Age = 32
WHERE CustID = 4

SELECT * FROM customer;

--DELETE COMMAND
DELETE FROM customer WHERE custid=3;

SELECT * FROM customer;

--ALTER COMMAND - ADD COLUMN
ALTER TABLE customer ADD COLUMN gender VARCHAR(10);

UPDATE customer
SET gender = CASE
    WHEN custid = 1 THEN 'Male'
    WHEN custid = 2 THEN 'Male'
    WHEN custid = 4 THEN 'Male'
    ELSE gender
END
WHERE custid IN (1, 2, 4);

SELECT * FROM customer;

--ALTER COMMAND - DROP COLUMN

ALTER TABLE customer DROP COLUMN gender;

SELECT * FROM customer;

--ALTER COMMAND - ALTER/MODIFY COLUMN

ALTER TABLE customer RENAME COLUMN city TO city_name;

ALTER TABLE customer ALTER COLUMN city_name TYPE VARCHAR(100);

ALTER TABLE customer ALTER COLUMN city_name SET DEFAULT 'Unknown';
	
ALTER TABLE customer ALTER COLUMN city_name DROP DEFAULT;

ALTER TABLE customer ALTER COLUMN city_name SET NOT NULL;

SELECT * FROM customer;

--DROP/TRUNCATE TABLE

TRUNCATE TABLE customer;
--deletes data inside the table

DROP TABLE customer;
--deletes the whole table

--SELECT COMMAND

SELECT * FROM customer;

SELECT custname FROM customer;

SELECT DISTINCT city FROM customer;
--gives unique fields

--creating table classroom
CREATE TABLE classroom (
rollno int8 PRIMARY KEY,
name varchar(50) NOT NULL,
house char(12) NOT NULL,
grade char(1) );


INSERT INTO classroom (rollno, name, house, grade)
VALUES
(1, 'Sam', 'Akash', 'B'),
(2, 'Ram', 'Agni', 'A'),
(3, 'Shyam', 'Jal', 'B'),
(4, 'Sundar', 'Agni', 'A'),
(5, 'Ram', 'Yayu', 'B');


SELECT * FROM classroom;

SELECT DISTINCT grade FROM classroom;
--gives unique fields


--WHERE CLAUSE

SELECT name FROM classroom WHERE grade='A';

SELECT name FROM classroom WHERE grade='A' AND rollno > 3;

--LIMIT CLAUSE

SELECT * FROM classroom LIMIT 3;

--ORDERBY CLAUSE

SELECT * FROM classroom ORDER BY name ASC;

--Importing data from csv file
DROP TABLE if EXISTS customer;
CREATE TABLE customer
(
customer_id int8 PRIMARY KEY,
first_name varchar(50),
last_name varchar(50),
email varchar(100),
address_id int8
)

COPY customer(customer_id,first_name,last_name,email,address_id)
FROM 'D:\DataAnalyst\SQL\customer.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM customer;

CREATE TABLE payment
(
	customer_id int8 PRIMARY KEY,
	amount int8 NOT NULL,
	mode varchar(50),
	payment_date date
)
--Import/Export data in payment.csv by right clicking on table 

SELECT * FROM payment;

--STRING FUNCTIONS

SELECT LOWER(first_name) FROM customer;

SELECT UPPER(first_name) FROM customer;

SELECT LENGTH(first_name) FROM customer;

SELECT SUBSTRING(first_name,1,3), first_name FROM customer;

SELECT CONCAT(first_name,last_name), first_name, last_name FROM customer;

SELECT REPLACE(first_name,'Mary','Mohan'), first_name, last_name FROM customer;

--AGGREGATE FUNCTIONS

SELECT COUNT(amount) FROM payment;

SELECT COUNT(*) FROM payment;

SELECT SUM(amount) FROM payment;

SELECT MAX(amount) FROM payment;

SELECT MIN(amount) FROM payment;

SELECT ROUND(AVG(amount),2) FROM payment;

--GROUPBY(used by aggregate functions) AND HAVING CLAUSE

SELECT * FROM payment;

SELECT mode, SUM(amount) AS total
FROM payment
GROUP BY mode
ORDER BY total ASC

--WHERE CLAUSE is for SELECT and HAVING CLAUSE is for GROUP BY

SELECT mode, COUNT(amount) AS total
FROM payment
GROUP BY mode
HAVING COUNT(amount) >= 3
ORDER BY total ASC



SELECT mode, COUNT(amount) AS total
FROM payment
GROUP BY mode
HAVING COUNT(amount) >= 2 AND COUNT(amount) < 4
ORDER BY total ASC

/*
7 Stages of SQL Order of Execution 
1. FROM/JOIN
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. ORDER BY
7. LIMIT/OFFSET
*/


--TIMESTAMP FUNCTION

SHOW TIMEZONE
SELECT NOW()
SELECT TIMEOFDAY()
SELECT CURRENT_TIME
SELECT CURRENT_DATE

--EXTRACT FUNCTION

SELECT EXTRACT(MONTH FROM payment_date) AS payment_month, payment_date FROM payment

SELECT EXTRACT(YEAR FROM payment_date) AS payment_year, payment_date FROM payment

SELECT EXTRACT(DOW FROM payment_date) AS payment_dow, payment_date FROM payment
--day of week = DOW and similarly DOY = day of year


--JOINS IN SQL

DROP TABLE customer;

-- Create the customer table
CREATE TABLE customer (
    customer_id BIGINT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address_id BIGINT
);

-- Insert the values
INSERT INTO customer (customer_id, first_name, last_name, address_id)
VALUES 
    (1, 'Mary', 'Smith', 5),
    (3, 'Linda', 'Williams', 7),
    (4, 'Barbara', 'Jones', 8),
    (2, 'Madan', 'Mohan', 6),
    (17, 'R', 'Madhav', 9);
	
TRUNCATE TABLE payment;

INSERT INTO payment (customer_id, amount, mode, payment_date)
VALUES 
    (1, 60, 'Cash', '2020-09-24'),
    (11, 80, 'Cash', '2021-03-01'),
    (2, 500, 'Credit Card', '2020-04-27'),
    (8, 100, 'Cash', '2021-01-26'),
    (7, 20, 'Mobile Payment', '2021-02-01'),
    (17, 250, 'Credit Card', '2021-04-01'),
    (10, 70, 'Mobile Payment', '2021-02-28');


--1. INNER JOIN(A∩B)
SELECT * FROM customer AS c
INNER JOIN payment AS p
ON c.customer_id = p.customer_id
-- AS c is known as Alias in SQL

SELECT c.first_name, p.amount, p.mode 
FROM customer AS c
INNER JOIN payment AS p
ON c.customer_id = p.customer_id

--2. LEFT OUTER JOIN/LEFT JOIN(A ∪ (A ∩ B))
SELECT * FROM customer AS c
LEFT OUTER JOIN payment AS p
ON c.customer_id = p.customer_id

--3. RIGHT OUTER JOIN/RIGHT JOIN(B ∪ (A ∩ B))
SELECT * FROM customer AS c
RIGHT OUTER JOIN payment AS p
ON c.customer_id = p.customer_id

--4. FULL JOIN(A ∪ B)
SELECT * FROM customer AS c
FULL OUTER JOIN payment AS p
ON c.customer_id = p.customer_id

--5. SELF JOIN
CREATE TABLE employees (
    empid BIGINT PRIMARY KEY,
    empname VARCHAR(50),
    manager_id BIGINT
);

INSERT INTO employees (empid, empname, manager_id) VALUES
(1, 'Agni', 3),
(2, 'Akash', 4),
(3, 'Dharti', 2),
(4, 'Vayu', 3);

SELECT * 
FROM employees AS T1
JOIN employees AS T2
ON T2.empid = T1.manager_id

SELECT T1.empname AS employee_name, T2.empname AS manager_name 
FROM employees AS T1
JOIN employees AS T2
ON T2.empid = T1.manager_id

--UNION in SQL
/* combine or concatenates the results of two or more SELECT statements without returning any duplicate rows
and keeps unique records */
/* The SELECT statement must have -
1. Same no. of columns and selected expressions
2. Same datatype
3. Have them in same order*/

-- Create table custA
CREATE TABLE custA (
    cust_name CHARACTER(30),
    cust_amount BIGINT
);

-- Insert values into custA
INSERT INTO custA (cust_name, cust_amount) VALUES
('Madan Mohan', 2100),
('Gopi Nath', 1200),
('Govind Dev', 5000);

-- Create table custB
CREATE TABLE custB (
    cust_name CHARACTER(30),
    cust_amount BIGINT
);

-- Insert values into custB
INSERT INTO custB (cust_name, cust_amount) VALUES
('Gopal Bhat', 1500),
('Madan Mohan', 2100);

SELECT cust_name, cust_amount FROM custA
UNION
SELECT cust_name, cust_amount FROM custB

--UNION	ALL in SQL
/* combine or concatenates two or more table but keeps all records including duplicates */
SELECT cust_name, cust_amount FROM custA
UNION ALL
SELECT cust_name, cust_amount FROM custB


--Subquery
/*	Find the details of customers, whose payment amount is more than the average of total amount paid
by all customers
*/

SELECT * FROM payment where amount > (SELECT AVG(amount) FROM payment);

SELECT customer_id, amount, mode 
FROM payment 
WHERE customer_id IN (SELECT customer_id FROM customer);

SELECT first_name, last_name
FROM customer c
WHERE EXISTS(SELECT customer_id, amount FROM payment p
			WHERE p.customer_id = c.customer_id
			AND amount > 40)

--WINDOW FUNCTIONS
CREATE TABLE test_data (
    new_id BIGINT,
    new_cat VARCHAR
);

INSERT INTO test_data (new_id, new_cat) VALUES
(100, 'Agni'),
(200, 'Agni'),
(200, 'Vayu'),
(300, 'Vayu'),
(500, 'Vayu'),
(500, 'Dharti'),
(700, 'Dharti');

SELECT * FROM test_data;
/* 1. Applies on Aggregate, Ranking, and Analytic functions over a particular window(set of rows)
   2. OVER clause is used with window functions to define that window
*/
/*	SYNTAX:
	SELECT column_name(s),
       fun() OVER (
           [PARTITION BY clause]
           [ORDER BY clause]
           [ROW or RANGE clause]
       )
FROM table_name;
Here fun() can be Aggregate, Ranking, and Analytic functions
*/

/*

Window function applies aggregate, ranking and analytic functions over a particular window; for example, sum, avg, or row_number

Expression is the name of the column that we want the window function operated on. This may not be necessary depending on what window function is used

OVER is just to signify that this is a window function

PARTITION BY divides the rows into partitions so we can specify which rows to use to compute the window function

ORDER BY is used so that we can order the rows within each partition. This is optional and does not have to be specified

ROWS can be used if we want to further limit the rows within our partition. This is optional and usually not used

*/

/*
Window Functions
Aggregate functions - SUM, AVG, COUNT, MIN, MAX etc.
Ranking functions - ROW_NUMBER, RANK, DENSE_RANK, PERCENT_RANK etc.
Value/Analytic funtions - LEAD, LAG ,FIRST_VALUE, LAST_VALUE etc.
*/
--1. Aggregate Function

SELECT new_id, new_cat,
  SUM(new_id) OVER( PARTITION BY new_cat ORDER BY new_id ) AS "Total",
  AVG(new_id) OVER( PARTITION BY new_cat ORDER BY new_id ) AS "Average",
  COUNT(new_id) OVER( PARTITION BY new_cat ORDER BY new_id ) AS "Count",
  MIN(new_id) OVER( PARTITION BY new_cat ORDER BY new_id ) AS "Min",
  MAX(new_id) OVER( PARTITION BY new_cat ORDER BY new_id ) AS "Max"
FROM test_data;

--Correct version of above query
SELECT new_id, new_cat,
  SUM(new_id) OVER (PARTITION BY new_cat) AS "Total",
  AVG(new_id) OVER (PARTITION BY new_cat) AS "Average",
  COUNT(new_id) OVER (PARTITION BY new_cat) AS "Count",
  MIN(new_id) OVER (PARTITION BY new_cat) AS "Min",
  MAX(new_id) OVER (PARTITION BY new_cat) AS "Max"
FROM test_data
ORDER BY new_cat, new_id;

/* Output of above query
+--------+---------+-------+----------+-------+-----+-----+
| new_id | new_cat | Total | Average  | Count | Min | Max |
+--------+---------+-------+----------+-------+-----+-----+
|   100  | Agni    |   300 | 150      |     2 | 100 | 200 |
|   200  | Agni    |   300 | 150      |     2 | 100 | 200 |
|   500  | Dharti  |  1200 | 600      |     2 | 500 | 700 |
|   700  | Dharti  |  1200 | 600      |     2 | 500 | 700 |
|   200  | Vayu    |  1000 | 333.3333 |     3 | 200 | 500 |
|   300  | Vayu    |  1000 | 333.3333 |     3 | 200 | 500 |
|   500  | Vayu    |  1000 | 333.3333 |     3 | 200 | 500 |
+--------+---------+-------+----------+-------+-----+-----+
*/

SELECT new_id, new_cat,
    SUM(new_id) OVER(ORDER BY new_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Total",
    AVG(new_id) OVER(ORDER BY new_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Average",
    COUNT(new_id) OVER(ORDER BY new_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Count",
    MIN(new_id) OVER(ORDER BY new_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Min",
    MAX(new_id) OVER(ORDER BY new_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Max"
FROM test_data;

/*
	"ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING" will give a SINGLE output based on 
	all INPUT Values/PARTITION(if used)
 */

-- Output of above query
-- +--------+----------+-------+-----------+-------+-----+-----+
-- | new_id | new_cat  | Total | Average   | Count | Min | Max |
-- +--------+----------+-------+-----------+-------+-----+-----+
-- |  100   | Agni     | 2500  | 357.14286 |   7   | 100 | 700 |
-- |  200   | Agni     | 2500  | 357.14286 |   7   | 100 | 700 |
-- |  200   | Vayu     | 2500  | 357.14286 |   7   | 100 | 700 |
-- |  300   | Vayu     | 2500  | 357.14286 |   7   | 100 | 700 |
-- |  500   | Vayu     | 2500  | 357.14286 |   7   | 100 | 700 |
-- |  500   | Dharti   | 2500  | 357.14286 |   7   | 100 | 700 |
-- |  700   | Dharti   | 2500  | 357.14286 |   7   | 100 | 700 |
-- +--------+----------+-------+-----------+-------+-----+-----+

--2. Ranking Function 
SELECT new_id,
ROW_NUMBER() OVER(ORDER BY new_id) AS "ROW_NUMBER",
RANK() OVER(ORDER BY new_id) AS "RANK",
DENSE_RANK() OVER(ORDER BY new_id) AS "DENSE_RANK",
PERCENT_RANK() OVER(ORDER BY new_id) AS "PERCENT_RANK"
FROM test_data;

-- Output of above query 
-- new_id  ROW_NUMBER  RANK  DENSE_RANK  PERCENT_RANK
-- 100     1           1     1           0
-- 200     2           2     2           0.166
-- 200     3           2     2           0.166
-- 300     4           4     3           0.5
-- 500     5           5     4           0.666
-- 500     6           5     4           0.666
-- 700     7           7     5           1

--3. Analytic Function

SELECT new_id,
    FIRST_VALUE(new_id) OVER(ORDER BY new_id) AS "FIRST_VALUE",
    LAST_VALUE(new_id) OVER(ORDER BY new_id) AS "LAST_VALUE",
    LEAD(new_id) OVER(ORDER BY new_id) AS "LEAD",
    LAG(new_id) OVER(ORDER BY new_id) AS "LAG"
FROM test_data;

/*
 if you just want single value from whole column, use: ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
*/

-- Table showing values for new_id, FIRST_VALUE, LAST_VALUE, LEAD, and LAG
-- new_id | FIRST_VALUE | LAST_VALUE | LEAD | LAG
-- 100    | 100         | 100        | 200  | null
-- 200    | 100         | 200        | 200  | 100
-- 200    | 100         | 200        | 300  | 200
-- 300    | 100         | 300        | 500  | 200
-- 500    | 100         | 500        | 500  | 300
-- 500    | 100         | 500        | 700  | 500
-- 700    | 100         | 700        | null | 500

-- LAG and LEAD by two rows ahead/behind
SELECT new_id,
       LEAD(new_id, 2) OVER (ORDER BY new_id) AS "LEAD_by2",
       LAG(new_id, 2) OVER (ORDER BY new_id) AS "LAG_by2"
FROM test_data;

--CASE Statement	
SELECT customer_id, amount,
CASE
    WHEN amount > 100 THEN 'Expensive product'
    WHEN amount = 100 THEN 'Moderate product'
    ELSE 'Inexpensive product'
END AS ProductStatus
FROM payment;

--CASE Expression
SELECT customer_id,
CASE amount
    WHEN 500 THEN 'Prime Customer'
    WHEN 100 THEN 'Plus Customer'
    ELSE 'Regular Customer'
END AS CustomerStatus
FROM payment;

--COMMON TABLE EXPRESSIONS(CTEs)
-- A common table expression, or CTE, is a temporary named result set created from a simple SELECT statement 
-- that can be used in a subsequent SELECT statement.
-- We can define CTEs by adding a WITH clause directly before SELECT, INSERT, UPDATE, DELETE, or MERGE statement.
-- The WITH clause can include one or more CTEs separated by commas.

--1. Easy CTEs
WITH my_cte AS (
    SELECT *, 
           AVG(amount) OVER(ORDER BY p.customer_id) AS "Average_Price",
           COUNT(address_id) OVER(ORDER BY c.customer_id) AS "Count"
    FROM payment AS p
    INNER JOIN customer AS c
    ON p.customer_id = c.customer_id
)
SELECT first_name, last_name, amount
FROM my_cte;


--2. Medium CTEs
WITH my_cte AS (
    SELECT *, 
           AVG(amount) OVER(ORDER BY p.customer_id) AS "Average_Price",
           COUNT(address_id) OVER(ORDER BY c.customer_id) AS "Count"
    FROM payment AS p
    INNER JOIN customer AS c
    ON p.customer_id = c.customer_id
), 
my_cte2 AS (
    SELECT *
    FROM customer AS c
    INNER JOIN address AS a
    ON a.address_id = c.address_id
    INNER JOIN country AS cc
    ON cc.city_id = a.city_id
)
SELECT cp.first_name, cp.last_name, ca.city, ca.country, cp.amount 
FROM my_ca as ca, my_cp as cp;

--3. Advance CTEs
WITH my_cte AS (
    SELECT mode, MAX(amount) AS highest_price, SUM(amount) AS total_price
    FROM payment
    GROUP BY mode
)
SELECT payment.*, my.highest_price, my.total_price
FROM payment
JOIN my_cte my ON payment.mode = my.mode
ORDER BY payment.mode;


--Recursive CTEs
/*
	SYNTAX - 
	WITH RECURSIVE cte_name AS(
		CTE_query_definition  		--non recursive term/Base query/anchor member
		UNION ALL
		recursive_query_definition	--recursive term/recursive query/recursive member 
	)
	SELECT * FROM cte_name
*/

--Interview question to write the numbers counting without using functions(Count up until three)
WITH RECURSIVE my_CTE AS(
	SELECT 1 AS n ---base query
	UNION ALL
	SELECT n+1 FROM my_CTE ---recursive query
	WHERE n<3	---condition check
)

SELECT * FROM my_CTE

DROP TABLE employees;

CREATE TABLE employees (
    emp_id serial PRIMARY KEY,
    emp_name VARCHAR NOT NULL,
    manager_id INT
);

INSERT INTO employees (emp_id, emp_name, manager_id)
VALUES
    (1, 'Radhav', NULL),
    (2, 'Sam', 1),
    (3, 'Tom', 2),
    (4, 'Arjun', 6),
    (5, 'Shiva', 4),
    (6, 'Keshav', 1),
    (7, 'Damodar', 5);
	
SELECT * FROM employees

--Finding Bosses and Hierarchical level for All Employees
WITH RECURSIVE EmpCTE AS (
    -- Anchor query (starting point)
    SELECT emp_id, emp_name, manager_id
    FROM employees
    WHERE emp_id = 7
    
    UNION ALL
    
    -- Recursive query (traverses up the hierarchy)
    SELECT e.emp_id, e.emp_name, e.manager_id
    FROM employees e
    JOIN EmpCTE cte ON e.emp_id = cte.manager_id
)
SELECT * FROM EmpCTE;

/*	Other Applications for Recursive CTEs
	1. Finding Routes between Cities
	2. Finding Ancestors
*/
	
--Interview Questions

-- Create the travel table
CREATE TABLE travel (
    source VARCHAR(20),
    destination VARCHAR(20),
    distance INTEGER
);

-- Insert the travel data
INSERT INTO travel (source, destination, distance)
VALUES 
    ('Mumbai', 'Bangalore', 500),
    ('Bangalore', 'Mumbai', 500),
    ('Delhi', 'Mathura', 150),
    ('Mathura', 'Delhi', 150),
    ('Nagpur', 'Pune', 500),
    ('Pune', 'Nagpur', 500);

SELECT * FROM travel;

--Q1: Minimize this table with single values

--Method 1: Using greatest and least values
SELECT least(source,destination) FROM travel;

SELECT greatest(source,destination), least(source,destination), max(distance) 
FROM travel 
GROUP BY greatest(source,destination), least(source,destination);

--least() function will show the least value as input and if inputs are string then alphabetically first value

--Method 2: Using Self Join
With cte AS 
(
SELECT *, row_number() OVER() as Sno 
FROM travel
) 
SELECT t1.* 
FROM cte AS t1 
JOIN cte AS t2 
ON t1.source = t2.destination 
AND t1.Sno < t2.Sno

--Method 3: Using Subquery 

SELECT * 
FROM travel t1 
WHERE NOT EXISTS (
					SELECT * FROM travel t2 
					WHERE t1.source = t2.destination 
					AND t1.destination = t2.source 
					AND t1.destination > t2.destination
				 )
				 
--Q2: Create match table:
CREATE TABLE match ( team varchar(20) ) 
INSERT INTO match (team) VALUES ('India'), ('Pak'), ('Aus'), ('Eng')

SELECT * FROM match;

WITH CTE AS (
	SELECT * ,ROW_NUMBER() OVER(ORDER BY team) AS id 
	FROM match
			) 

SELECT a.team AS "Team-A", b.team AS "Team-B" FROM cte AS a 
JOIN cte AS b 
ON a.team <> b.team 
WHERE a.id < b.id

--Q3: Create emp table:
CREATE TABLE emp ( ID int, NAME varchar(10) ) 
INSERT INTO emp (ID, NAME) 
VALUES (1,'Emp1'), (2,'Emp2'), (3,'Emp3'), (4,'Emp4'), 
(5,'Emp5'), (6,'Emp6'), (7,'Emp7'), (8,'Emp8')

SELECT * FROM emp;

WITH CTE AS (
SELECT *, CONCAT(id,' ', name) AS con, 
NTILE(4) OVER(ORDER BY id) AS groups 
FROM emp
)
SELECT STRING_AGG(con, ', ') AS result, groups 
FROM cte 
GROUP BY groups 
ORDER BY groups;

