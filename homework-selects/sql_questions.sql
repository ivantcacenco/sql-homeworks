-- Write a query to display: 
-- 1. the first name, last name, salary, and job grade for all employees.
SELECT first_name, last_name, salary, job_title
FROM employees
         LEFT JOIN jobs USING (job_id);
-- 2. the first and last name, department, city, and state province for each employee.
SELECT first_name, last_name, department_name as Department, city, state_province
FROM employees
    LEFT JOIN departments USING (department_id)
    LEFT JOIN locations USING (location_id);
-- 3. the first name, last name, department number and department name, for all employees for departments 80 or 40.
SELECT first_name, last_name, department_id as "Department Number", department_name
FROM employees
    LEFT JOIN departments USING (department_id)
    WHERE department_id IN (40, 80);
-- 4. those employees who contain a letter z to their first name and also display their last name, department, city, and state province.
SELECT first_name, last_name, department_name as Department, city, state_province
FROM employees
    LEFT JOIN departments USING (department_id)
    LEFT JOIN locations USING (location_id)
    WHERE first_name LIKE '%z%';
-- 5. the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
SELECT first_name, last_name, salary
FROM employees
WHERE salary < (SELECT salary
                FROM employees
                WHERE employee_id = 182);
-- 6. the first name of all employees including the first name of their manager.
SELECT e1.first_name as employee, e2.first_name as manager
FROM employees e1, employees e2
WHERE e1.manager_id = e2.employee_id;
-- 7. the first name of all employees and the first name of their manager including those who does not working under any manager.
SELECT e1.first_name as employee, e2.first_name as manager
FROM employees e1
    LEFT JOIN employees e2 ON (e1.manager_id = e2.employee_id);
-- 8. the details of employees who manage a department.
SELECT first_name, last_name, email, phone_number
FROM employees
    JOIN departments ON (employees.employee_id = departments.manager_id);
-- 9. the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor.
SELECT first_name, last_name, department_id as "Department Number"
FROM employees
WHERE department_id IN
    (SELECT department_id
    FROM employees
    WHERE last_name = 'Taylor');
--10. the department name and number of employees in each of the department.
SELECT department_name, COUNT(employee_id)
FROM departments
    LEFT JOIN employees USING (department_id)
GROUP BY department_name;
--11. the name of the department, average salary and number of employees working in that department who got commission.
SELECT department_name, AVG(salary), COUNT(employee_id)
FROM departments
    LEFT JOIN employees USING (department_id)
WHERE commission_pct IS NOT NULL
GROUP BY department_name;
--12. job title and average salary of employees.
SELECT job_title, AVG(salary)
FROM JOBS
    LEFT JOIN employees USING (job_id)
GROUP BY job_title;
--13. the country name, city, and number of those departments where at least 2 employees are working.
SELECT country_name, city, department_id
FROM countries
    LEFT JOIN locations USING (country_id)
    LEft JOIN departments USING (location_id)
WHERE department_id IN
    (SELECT department_id
    FROM departments
        LEFT JOIN employees USING (department_id)
    GROUP BY department_id
    HAVING COUNT(employee_id) > 1);
--14. the employee ID, job name, number of days worked in for all those jobs in department 80.
SELECT employee_id, job_title, end_date - start_date as "Number of Days Worked"
FROM job_history
    LEFT JOIN jobs USING (job_id)
WHERE department_id = 80;
--15. the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163.
SELECT CONCAT(first_name, CONCAT(' ', last_name)) as Name
FROM employees
WHERE salary > (SELECT salary
                FROM employees
                WHERE employee_id = 163);
--16. the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.
SELECT employee_id, CONCAT(first_name, CONCAT(' ', last_name)) as Name
FROM employees
WHERE salary > (SELECT AVG(salary)
                FROM employees);
--17. the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.
SELECT CONCAT(first_name, CONCAT(' ', last_name)) as Name, employee_id, salary
FROM employees
WHERE manager_id = (SELECT employee_id
                    FROM employees
                    WHERE first_name = 'Payam');
--18. the department number, name ( first name and last name ), job and department name for all employees in the Finance department.
SELECT department_id as "Department Number", CONCAT(first_name, CONCAT(' ', last_name)) as Name, job_title as Job, department_name
FROM departments
    LEFT JOIN employees USING (department_id)
    LEFT JOIN jobs USING (job_id)
WHERE department_name = 'Finance';
--19. all the information of an employee whose id is any of the number 134, 159 and 183.
SELECT * FROM employees
WHERE employee_id IN (134, 159, 183);
--20. all the information of the employees whose salary is within the range of smallest salary and 2500.
SELECT * FROM employees
WHERE salary BETWEEN (SELECT MIN(salary) FROM employees) AND 2500;
--21. all the information of the employees who does not work in those departments where some employees works whose id within the range 100 and 200.
SELECT *
FROM employees
WHERE department_id NOT IN (SELECT DISTINCT department_id
                            FROM employees
                            WHERE employee_id BETWEEN 100 AND 200);
--22. all the information for those employees whose id is any id who earn the second highest salary.
SELECT * FROM employees
WHERE employee_id IN (SELECT employee_id
                      FROM employees
                      WHERE salary = (SELECT MAX(salary)
                                      FROM employees
                                      WHERE employee_id <>(SELECT employee_id
                                                           FROM employees
                                                           WHERE salary = (SELECT MAX(salary)
                                                                           FROM employees))));
--23. the employee name( first name and last name ) and hiredate for all employees in the same department as Clara. Exclude Clara.
SELECT CONCAT(first_name, CONCAT(' ', last_name)) as Name, hire_date
FROM employees
WHERE department_id = (SELECT department_id
                        FROM employees
                        WHERE first_name = 'Clara')
AND first_name != 'Clara';
--24. the employee number and name( first name and last name ) for all employees who work in a department with any employee whose name contains a T.
SELECT employee_id, CONCAT(first_name, CONCAT(' ', last_name)) as Name
FROM employees
WHERE department_id IN (SELECT department_id
                        FROM employees
                        WHERE first_name LIKE '%T%' OR last_name LIKE '%T%');
--25. full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.
SELECT CONCAT(first_name, CONCAT(' ', last_name)) as Name, job_title, start_date, end_date
FROM employees
    JOIN job_history USING (employee_id)
    JOIN jobs ON jobs.job_id = job_history.job_id
WHERE start_date IN (SELECT start_date FROM job_history j1
                     WHERE END_DATE = (SELECT MAX(END_DATE)
                                       FROM job_history j2
                                       WHERE j1.employee_id = j2.employee_id))
AND commission_pct IS NULL;
--26. the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.
SELECT employee_id, CONCAT(first_name, CONCAT(' ', last_name)) as Name, salary
FROM employees
WHERE salary > (SELECT AVG(salary)
                FROM employees)
AND department_id IN (SELECT department_id
                      FROM employees
                      WHERE first_name LIKE '%J%' OR last_name LIKE '%J%');
--27. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.
SELECT employee_id, CONCAT(first_name, CONCAT(' ', last_name)) as Name, job_title
FROM employees
    JOIN jobs USING (job_id)
WHERE salary < (SELECT MIN(salary)
                FROM employees
                WHERE job_id = 'MK_MAN');
--28. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.
SELECT employee_id, CONCAT(first_name, CONCAT(' ', last_name)) as Name, job_title
FROM employees
    JOIN jobs USING (job_id)
WHERE salary < (SELECT MIN(salary)
                FROM employees
                WHERE job_id = 'MK_MAN')
AND job_id != 'MK_MAN';
--29. all the information of those employees who did not have any job in the past.
SELECT * FROM employees
WHERE employee_id NOT IN (SELECT employee_id
                          FROM job_history);
--30. the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.
SELECT * FROM employees e where e.salary > (
SELECT AVG(salary)
FROM employees
WHERE department_id = e.department_id);
--31. the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.
--32. the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
--33. the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees)
    -- and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than
    -- the average salary of all employees.
--34. all the employees who earn more than the average and who work in any of the IT departments.
--35. who earns more than Mr. Ozer.
--36. which employees have a manager who works for a department based in the US.
--37. the names of all employees whose salary is greater than 50% of their department's total salary bill.
--38. the employee id, name ( first name and last name ), salary, department name and city for all
--the employees who gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003.  
--39. the first and last name, salary, and department ID for all those employees who earn more than the average salary and arrange the list in descending order on salary.
--40. the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.
--41. the department name and Id for all departments where they located, that Id is equal to the Id for the location where department number 30 is located.
--42. the first and last name, salary, and department ID for all those employees who work in that department where the employee works who hold the ID 201.
--43. the first and last name, salary, and department ID for those employees whose salary is equal to the salary of the employee who works in that department which ID is 40.
--44. the first and last name, salary, and department ID for those employees who earn more than the minimum salary of a department which ID is 40.
--45. the first and last name, salary, and department ID for those employees who earn less than the minimum salary of a department which ID is 70.
--46. the first and last name, salary, and department ID for those employees who earn less than the average salary, and also work at the department where the employee Laura is working as a first name holder.
--47. the full name (first and last name) of manager who is supervising 4 or more employees.
--48. the details of the current job for those employees who worked as a Sales Representative in the past.
--49. all the infromation about those employees who earn second lowest salary of all the employees.
--50. the department ID, full name (first and last name), salary for those employees who is highest salary drawar in a department.
