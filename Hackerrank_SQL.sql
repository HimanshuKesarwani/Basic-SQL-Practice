--Good Questions from Hackerrank

/*
Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths 
(i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that
comes first when ordered alphabetically.
The STATION table is described as follows:
Sample Input

For example, CITY has four entries: DEF, ABC, PQRS and WXY.

Sample Output

ABC 3
PQRS 4
*/

SELECT CITY, LENGTH(CITY)
FROM STATION
WHERE LENGTH(CITY) = (SELECT MIN(LENGTH(CITY)) FROM STATION)
ORDER BY CITY
LIMIT 1;

SELECT CITY, LENGTH(CITY)
FROM STATION
WHERE LENGTH(CITY) = (SELECT MAX(LENGTH(CITY)) FROM STATION)
ORDER BY CITY
LIMIT 1;

/*
Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. 
Your result cannot contain duplicates.
*/

SELECT DISTINCT CITY FROM STATION WHERE CITY 
LIKE 'a%' OR CITY LIKE 'o%' OR CITY LIKE 'e%' OR CITY LIKE 'i%' OR CITY LIKE 'u%';

/*
Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. 
Your result cannot contain duplicates.
*/

SELECT DISTINCT CITY FROM STATION WHERE CITY LIKE '%a' OR CITY
LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u';

/*
Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters.
Your result cannot contain duplicates.
*/

SELECT DISTINCT CITY FROM STATION 
WHERE (CITY LIKE 'a%' OR CITY LIKE 'e%' OR CITY LIKE 'i%' OR CITY LIKE 'o%' OR CITY LIKE 'u%')
AND(CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u')
 
/*
Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
*/

SELECT DISTINCT CITY FROM STATION 
WHERE CITY NOT LIKE 'a%' AND CITY NOT LIKE 'e%' AND CITY NOT LIKE 'i%' 
AND CITY NOT LIKE 'o%' AND CITY NOT LIKE 'u%';
 
/*
Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
*/ 

SELECT DISTINCT CITY FROM STATION 
WHERE CITY NOT LIKE '%a' AND CITY NOT LIKE '%e' AND CITY NOT LIKE '%i' 
AND CITY NOT LIKE '%o' AND CITY NOT LIKE '%u';
 
/*
Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. 
Your result cannot contain duplicates.
*/ 

SELECT DISTINCT CITY FROM STATION 
WHERE (CITY NOT LIKE 'a%' AND CITY NOT LIKE 'e%' AND CITY NOT LIKE 'i%' AND CITY NOT LIKE 'o%' AND CITY NOT LIKE 'u%')
OR(CITY NOT LIKE '%a' AND CITY NOT LIKE '%e' AND CITY NOT LIKE '%i' AND CITY NOT LIKE '%o' AND CITY NOT LIKE '%u');

/*
Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. 
Your result cannot contain duplicates.
*/

SELECT DISTINCT CITY FROM STATION WHERE (CITY NOT LIKE 'a%' AND CITY NOT LIKE 'e%' AND CITY NOT LIKE 'i%' AND CITY NOT LIKE 'o%' AND CITY NOT LIKE 'u%')
AND(CITY NOT LIKE '%a' AND CITY NOT LIKE '%e' AND CITY NOT LIKE '%i' AND CITY NOT LIKE '%o' AND CITY NOT LIKE '%u');
 
/*
Query the following two values from the STATION table:
The sum of all values in LAT_N rounded to a scale of  decimal places.
The sum of all values in LONG_W rounded to a scale of 2 decimal places.
*/

SELECT ROUND(SUM(LAT_N),2)as lat,ROUND(SUM(LONG_W),2) as lon FROM STATION;

/*
Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 38.7880 and less than 137.2345. 
Truncate your answer to 4 decimal places.
*/

SELECT ROUND(SUM(LAT_N),4) from STATION WHERE ROUND(LAT_N,4) > 38.7880 AND ROUND(LAT_N,4) < 137.2345;

/*
Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345. 
Truncate your answer to 4 decimal places.
*/

SELECT MAX(ROUND(LAT_N,4)) FROM STATION WHERE ROUND(LAT_N,4) < 137.2345;

/*
Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345. 
Round your answer to 4 decimal places.
*/

SELECT ROUND(LONG_W,4) FROM STATION 
WHERE ROUND(LAT_N,4)=(SELECT MAX(ROUND(LAT_N,4)) FROM STATION WHERE ROUND(LAT_N,4)<137.2345);

/*
Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7780. 
Round your answer to 4 decimal places.
*/

SELECT MIN(ROUND(LAT_N,4)) FROM STATION WHERE LAT_N>38.7780;

/*
Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than 38.7780. 
Round your answer to 4 decimal places.
*/

SELECT ROUND(LONG_W, 4) AS WesternLongitude
FROM STATION
WHERE LAT_N > 38.7780
ORDER BY LAT_N ASC
LIMIT 1;

/*
Query the Name of any student in STUDENTS who scored higher than 75 Marks. 
Order your output by the last three characters of each name. If two or more 
students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), 
secondary sort them by ascending ID.
*/

SELECT NAME FROM STUDENTS WHERE MARKS > 75 ORDER BY SUBSTRING(NAME, LENGTH(NAME) - 2) ASC, ID ASC;

/*
Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. 
Output one of the following statements for each record in the table:

Equilateral: It's a triangle with  sides of equal length.
Isosceles: It's a triangle with  sides of equal length.
Scalene: It's a triangle with  sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle.
*/

SELECT 
    CASE
        WHEN (A + B <= C) OR (B + C <= A) OR (C + A <= B) THEN 'Not A Triangle'
        WHEN A = B AND B = C THEN 'Equilateral'
        WHEN A = B OR B = C OR C = A THEN 'Isosceles'
        ELSE 'Scalene'
    END AS Tri_Type
FROM TRIANGLES;

/*
Query the average population for all cities in CITY, rounded down to the nearest integer.
*/

SELECT FLOOR(AVG(POPULATION)) AS Average_pop FROM CITY;

/*
Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, 
but did not realize her keyboard's 0 key was broken until after completing the calculation. 
She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), 
and the actual average salary.
Write a query calculating the amount of error (i.e.: average - miscalculated average monthly salaries), 
and round it up to the next integer.
*/
SELECT 
    CEIL(AVG(SALARY) - AVG(REPLACE(SALARY, '0', ''))) AS Error
FROM EMPLOYEES;

/*
We define an employee's total earnings to be their monthly salary X months worked, 
and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. 
Write a query to find the maximum total earnings for all employees as well as the total number of employees 
who have maximum total earnings. Then print these values as 2 space-separated integers.
*/

SELECT MAX(salary*months) as max_sal, COUNT(employee_id) as noe  FROM Employee 
WHERE (salary*months)=(SELECT MAX(salary*months) FROM Employee);

/*
P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):

* * * * * 
* * * * 
* * * 
* * 
*
Write a query to print the pattern P(20).
*/

WITH RECURSIVE Numbers AS (
    SELECT 20 AS Number
    UNION ALL
    SELECT Number - 1 FROM Numbers WHERE Number > 0 -- Adjust the limit as needed
)
SELECT REPEAT('* ', Number) AS Pattern
FROM Numbers;

/*
P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):

* 
* * 
* * * 
* * * * 
* * * * *
Write a query to print the pattern P(20).
*/

WITH RECURSIVE Numbers AS (
    SELECT 1 AS Number
    UNION ALL
    SELECT Number + 1 FROM Numbers WHERE Number < 20 -- Adjust the limit as needed
)
SELECT REPEAT('* ', Number) AS Pattern
FROM Numbers;

/*

*/