
/*Exercise 1: Total sum of salary within department against each of employee of that department */

SELECT emp_name,salary,dept_no,
SUM(salary) over (PARTITION BY dept_no ORDER BY emp_name ) As Total_Dept_salary
FROM tutorial.employee;

/*Exercise 2: Cumulative salary within each department */

SELECT emp_name,salary,dept_no,
SUM(salary) over (PARTITION BY dept_no ORDER BY emp_name  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) As Custom_Dept_salary
FROM tutorial.employee; --Window here: all the previous rows  and current row

/* Exercise 3: Total count of employees within department against each of employee of that department. */

SELECT emp_name,salary,dept_no,
COUNT(emp_name) over (PARTITION BY dept_no) As Total_Emps
FROM tutorial.employee;


/* Exercise 4: Find employees whose total department salary is greater than 9000. */

SELECT emp_name,salary,dept_no,
SUM(salary) over (PARTITION BY dept_no ORDER BY emp_name ) As Total_Dept_salary
FROM tutorial.employee
QUALIFY (SUM(salary) over (PARTITION BY dept_no ))>9000;