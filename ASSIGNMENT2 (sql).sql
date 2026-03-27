CREATE DATABASE employees_db;
DELETE DATABASE employees_db;
DROP DATABASE employees_db;

CREATE DATABASE employees_db;

USE employees_db;
CREATE TABLE employees (                          
    emp_id INT PRIMARY KEY, 
    emp_name VARCHAR(50), 
    salary INT, 
    department_id INT 
);

CREATE TABLE departments ( 
    department_id INT PRIMARY KEY, 
    department_name VARCHAR(50), 
    location VARCHAR(50) 
);

CREATE TABLE projects ( 
    project_id INT PRIMARY KEY, 
    project_name VARCHAR(50), 
    emp_id INT 
);

INSERT INTO employees VALUES 
(101, 'Rahul', 60000, 2), 
(102, 'Priya', 50000, 1), 
(103, 'Amit', 75000, 2), 
(104, 'Sneha', 65000, 3), 
(105, 'Karan', 40000, 1); 

INSERT INTO departments VALUES 
(1, 'HR', 'Mumbai'), 
(2, 'IT', 'Delhi'), 
(3, 'Finance', 'Chennai');

INSERT INTO projects VALUES 
(1001, 'Website', 101), 
(1002, 'App Development', 103), 
(1003, 'Recruitment Drive', 102), 
(1004, 'Audit', 104), 
(1005, 'Payroll System', 101);

#Question 1: Show employee name with department name
SELECT e.emp_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

#2:Show all employees with department location:
SELECT e.emp_name, d.location 
FROM employees e 
JOIN departments d 
ON e.department_id = d.department_id;

#3:Show employees working in IT department:
SELECT e.emp_name 
FROM employees e 
JOIN departments d 
ON e.department_id = d.department_id 
WHERE d.department_name = 'IT';

#4:Show all projects with employee names:
SELECT p.project_name, e.emp_name 
FROM projects p 
JOIN employees e 
ON p.emp_id = e.emp_id;

#5:Show employees who are not assigned to any project:
SELECT emp_name 
FROM employees 
WHERE emp_id NOT IN (SELECT emp_id FROM projects);

#6:Count total employees:
SELECT COUNT(*) 
AS total_employees 
FROM employees;

#7Count employees per department:
SELECT department_id, COUNT(*) FROM employees GROUP BY department_id;

#8Find average salary:
SELECT AVG(salary) FROM employees;

#9 Find highest salary:
SELECT MAX(salary) FROM employees;

#10 Find lowest salary:
SELECT MIN(salary) FROM employees;

#11 Total salary paid per department:
SELECT department_id, SUM(salary) 
FROM employees GROUP BY department_id;

#12 Average salary per department:
SELECT department_id, 
AVG(salary) 
FROM employees GROUP BY department_id;

#13 Department with highest average salary:
SELECT department_id, 
AVG(salary) 
FROM employees GROUP BY department_id 
ORDER BY AVG(salary) DESC LIMIT 1; 

#14 Count employees in each location:
SELECT d.location, COUNT(e.emp_id) 
FROM employees e 
JOIN departments d 
ON e.department_id = d.department_id GROUP BY d.location;

#15 Total number of projects:
SELECT COUNT(*) FROM projects;

#16 Count projects per employee:
SELECT emp_id, COUNT(*) 
FROM projects GROUP BY emp_id;

#17 Employee with maximum projects:
SELECT emp_id, COUNT(*) 
FROM projects 
GROUP BY emp_id 
ORDER BY COUNT(*) DESC LIMIT 1;

#18 Department with maximum employees:
SELECT department_id, COUNT(*) 
FROM employees GROUP BY department_id 
ORDER BY COUNT(*) DESC LIMIT 1;

#19 Department generating highest salary expense:
SELECT department_id, SUM(salary) 
FROM employees GROUP BY department_id 
ORDER BY SUM(salary) DESC LIMIT 1;

#20 Average salary of employees working on projects:
SELECT AVG(salary) FROM employees 
WHERE emp_id IN (SELECT emp_id FROM projects);

#21 Employees earning more than department average:
SELECT * FROM employees e1 
WHERE salary > (SELECT AVG(salary) FROM employees e2 
WHERE e1.department_id = e2.department_id);

#22 Departments having more than 1 employee:
SELECT department_id 
FROM employees GROUP BY department_id 
HAVING COUNT(*) > 1;

#23 Employees working on more than 1 project:
SELECT emp_id FROM projects 
GROUP BY emp_id HAVING COUNT(*) > 1;

#24 Total salary of employees working in Delhi location:
SELECT SUM(e.salary) FROM employees e JOIN departments d 
ON e.department_id = d.department_id 
WHERE d.location = 'Delhi';

#25 Project count per department:
SELECT e.department_id, COUNT(p.project_id) 
FROM employees e 
JOIN projects p ON e.emp_id = p.emp_id 
GROUP BY e.department_id;

#26 Employee with highest salary in each department:
SELECT department_id, emp_name, salary 
FROM employees WHERE (department_id, salary) 
IN (SELECT department_id, MAX(salary) 
FROM employees GROUP BY department_id);

#27 Department with no employees:
SELECT * FROM departments 
WHERE department_id 
NOT IN (SELECT DISTINCT department_id FROM employees);

#28 Employees who don't belong to any department:
SELECT * FROM employees WHERE department_id IS NULL;

#29 Projects handled by IT department employees:
SELECT p.project_name FROM projects p 
JOIN employees e ON p.emp_id = e.emp_id 
JOIN departments d ON e.department_id = d.department_id 
WHERE d.department_name = 'IT';

#30 Location with highest total salary payout:
SELECT d.location, SUM(e.salary) 
FROM employees e JOIN departments d 
ON e.department_id = d.department_id 
GROUP BY d.location ORDER BY SUM(e.salary) 
DESC LIMIT 1;


