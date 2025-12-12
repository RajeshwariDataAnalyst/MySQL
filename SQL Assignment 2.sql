
USE employees;

Select * from employees;


-- 1. DISTINCT Values

Select Distinct salary from employees;

-- 2. ALIAS (AS) Operation

Select Age AS Employee_age, Salary AS Employee_Salary from Employees;

-- 3. WHERE CLAUSE & Operators

Select salary, hire_date from employees
WHERE salary > 50000 AND hire_date < '2016-01-01';

--  REPLACING DESIGNATION NULL VALUE TO 'DATA SCIENTIST'

Set Sql_safe_updates =0;

UPDATE Employees 
SET Designation = 'Data Scientist'
WHERE Designation IS NULL;

-- SORTING & GROUPING DATA 

-- ORDER BY OPERATION

Select * from Employees
 ORDER BY Department_id ASC, Salary DESC;

-- LIMIT BY OPERATION

Select * from employees 
WHERE hire_date >='2018-01-01'
ORDER BY hire_date
LIMIT 5;

-- AGGRIGATE FUNCTION

-- Sum of Finance Dept Salary 

Select sum(salary) AS Ttl_Finance_dept
from employees
WHERE Department_id = 7;

-- MINIMUM AGE 

-- Aggrigation view of min age

Select min(age) AS MIN_AGE
from employees;

-- full Table view of min age  

Select * from employees
ORDER BY age 
LIMIT 1;

-- GROUP BY OPERATION

-- BY USING LOCATION_ID AS A REFERENCE OF LOCATION 

Select location_id, max(salary) AS Max_salary
From Employees
GROUP BY Location_id;  


-- BY USING JOIN FUNCTION TO DISPLAY LOCATION NAME INSTEAD OF LOCATION_ID

Select l.Location, Max(e.salary) AS Max_salary
from employees AS e
JOIN locations AS l
ON e.location_id = l.location_id
GROUP BY location; 

-- CALCULATE 'ANALYST' AVERAGE SALARY 

Select designation, avg(salary) AS Avg_Salary
From employees
WHERE Designation like '%Analyst%'
GROUP BY designation;

-- HAVING FUNCTION 

-- LESS THEN 3 EMPLOYEE

Select department_id , count(*) AS ttl_count_of_emp
from employees
GROUP BY department_id
HAVING ttl_count_of_emp < 3;

-- FEMALE EMPLOYEE WHOSE HAVE AVERAGE AGE BELOW 30

SELECT location_id, AVG(age) AS avg_age
FROM employees
WHERE gender = 'F'
GROUP BY location_id
HAVING AVG(age) < 30;

-- INNER JOIN FUNCTION

SELECT e.Employee_Name, e.Designation, d.Department_Name
FROM Employees  e
INNER JOIN Departments  d
  ON e.Department_id = d.Department_id;
  
  -- LEFT JOIN FUNCTION
  
SELECT d.department_name,
       COUNT(e.employee_id) AS total_employees
FROM employees e 
LEFT JOIN departments d
       ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;

-- RIGHT JOIN FUNCTION

SELECT l.location,
       e.employee_name
FROM employees e
RIGHT JOIN locations l
       ON e.location_id = l.location_id;

