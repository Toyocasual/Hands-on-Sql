-- use employees_db
use employees_db
--select all tables in employees_dp
select * from COUNTRIES
select * from departments
select * from employees
select * from job_history
select * from jobs
select * from [LOCATIONS]
select * from REGIONS

--Display the minimum salary.
select min(salary) 'minimum salary' from employees
--Display the highest salary.
select max(salary) 'maximum salary' from employees
--Display the total salary of all employees. 
select sum(salary) 'sum of salary' from employees
--Display the average salary of all employees.
select avg(salary) 'average salary' from employees


--1.Issue a query to count the number of rows in the employee table. The result should be just one row.
select count(employee_id) from employees
--2.Issue a query to count the number of employees that make commission. The result should be just one row.
 select count(commission_pct) 
from employees
where commission_pct is not null
--3.Issue a query to count the number of employees’ first name column. The result should be just one row.
select count(first_name) from employees
--4.Display all employees that make less than Peter Hall.
select CONCAT(first_name, ' ',last_name) 'Name', salary from employees
where salary < (select salary from employees where first_name = 'peter' and last_name = 'hall')
--5.Display all the employees in the same department as Lisa Ozer.
select concat(first_name,' ',last_name), department_id from employees
where department_id = (select department_id from employees where first_name = 'lisa' and last_name = 'ozer')
--6.Display all the employees in the same department as Martha Sullivan and that make more than TJ Olson.
select employee_id, concat(first_name,' ',last_name) as 'name', department_id, salary
from employees
where department_id = (select department_id from employees where first_name = 'martha' and last_name = 'sullivan'
)
and salary > (select salary from employees where first_name = 'tj' and last_name = 'olson'
)
--7.Display all the departments that exist in the departments table that are not in the employees’ table. Do not use a where clause.
select department_id from departments
except 
select department_id from employees
--8.Display all the departments that exist in department tables that are also in the employees’ table. Do not use a where clause.
select department_id from departments
intersect
select department_id from employees
--9.Display all the departments name, street address, postal code, city, and state of each department. Use the departments and locations table for this query.
select department_name, street_address,postal_code,city,state_province
from departments dept
join LOCATIONS loc
on dept.location_id = loc.location_id
--10.Display the first name and salary of all the employees in the accounting departments. 
select first_name, salary, department_name
from employees emp
join departments dept
on dept.department_id = emp.department_id
where dept.department_id = (Select department_id from departments 
where department_name = 'accounting')
--11.Display all the last name of all the employees whose department location id are 1700 and 1800.
select last_name, location_id
from employees emp
join departments dept
on emp.department_id = dept.department_id
where location_id in (1700,1800)

--12.Display the phone number of all the employees in the Marketing department.
select phone_number
from employees
where department_id = (select department_id from departments where department_name = 'marketing')

--13.Display all the employees in the Shipping and Marketing departments who make more than 3100.
select concat(first_name,' ',last_name) 'Name',employee_id, salary
from employees
where department_id in (select department_id from departments 
where department_name in ('shipping','marketing')) and salary > 3100

--14.Write an SQL query to print the first three characters of FIRST_NAME from employee’s table.
select left(first_name,3) from employees
--15.Display all the employees who were hired before Tayler Fox.
select concat(first_name,' ',last_name)
from employees
where hire_date < (select hire_date from employees
where first_name = 'tayler' and last_name = 'fox')
--16.Display names and salary of the employees in executive department. 
select concat(first_name,' ',last_name),salary
from employees
where department_id = (select department_id from departments
where department_name = 'executive')
--17.Display the employees whose job ID is the same as that of employee 141.
select concat(first_name,' ',last_name) 'Name', job_id
from employees
where job_id = (select job_id from employees where employee_id = 141)
--18. For each employee, display the employee number, last name, salary, and salary increased by 15% and expressed as a whole number. Label the column New Salary.
select employee_id, last_name, salary, cast(salary+(salary*0.15) as int) as new_salary
from employees
--19.Write an SQL query to print the FIRST_NAME and LAST_NAME from employees table into a single column COMPLETE_NAME. A space char should separate them.
select concat(first_name,' ',last_name) Complete_name
from employees
--20.Display all the employees and their salaries that make more than Abel.
select employee_id, salary 
from employees
where salary > (select salary from employees 
where first_name = 'abel' or last_name = 'abel')
--21.Create a query that displays the employees’ last names and commission amounts. If an employee does not earn commission, put “no commission”. Label the column COMM.
select last_name, 
(case when commission_pct is null then 'no commission'
else convert(varchar, commission_pct)end) COMM
FROM employees
--22.Create a unique listing of all jobs that are in department 80. Include the location of department in the output.
select distinct job_id, emp.department_id, dept.location_id, street_address,state_province
from employees emp
join departments dept
on dept.department_id = emp.department_id
join locations loc
on dept.location_id = loc.location_id
where dept.department_id = 80
--23.Write a query to display the employee’s last name, department name, location ID, and city of all employees who earn a commission.
select last_name, department_name, dept.location_id, city 
from employees emp
join departments dept
on emp.department_id = dept.department_id
join LOCATIONS loc 
on dept.location_id = loc.location_id
where commission_pct is not null
--24.Create a query to display the name and hire date of any employee hired after employee Davies.
select concat(first_name,' ',last_name), hire_date
from employees
where hire_date > (select hire_date from employees where first_name = 'davies' or last_name = 'davies')
--25.Write an SQL query to show one row twice in results from a table.
select *  from employees 
union all
select * from employees
order by employee_id

--26.Display the highest, lowest, sum, and average salary of all employees. 
select min(salary),max(salary),sum(salary), avg(salary) from employees
--27.Label the columns Maximum, Minimum, Sum, and Average, respectively. Round your results to the nearest whole number.
select cast(max(salary) as int) maximum, cast(min(salary) as int) minimum, cast(sum(salary) as int) 'Sum', cast(avg(salary) as int) Average
from employees
--28.Write an SQL query to show the top n (say 10) records of a table.
select top 10 * from employees
--29.Display the MINIMUN, MAXIMUM, SUM AND AVERAGE salary of each job type. 
select job_id, cast(min(salary) as int) min_salary, cast(max(salary) as int) max_salary, cast(sum(salary) as int) sum_salary, cast(avg(salary) as int) avg_salary
from employees
group by job_id
--30.Display all the employees and their managers from the employees’ table.
select emp.employee_id, emp.first_name, emp.last_name, emp.manager_id, man.first_name, man.last_name
from employees emp
join employees man 
on emp.manager_id = man.employee_id
--31.Determine the number of managers without listing them. Label the column NUMBER of managers. Hint: use manager_id column to determine the number of managers
select count(manager_id) NUMBER_OF_MANAGER 
from employees
--32.Write a query that displays the difference between the HIGHEST AND LOWEST salaries. Label the column DIFFERENCE.
select max(salary)-min(salary) 'Difference'
from employees
--33.Display the sum salary of all employees in each department.
select sum(salary) sum_of_salary, department_id
from employees
group by department_id
order by sum_of_salary
--34.Write a query to display each department's name, location, number of employees, and 
--the average salary of employees in the department. Label the column NAME, LOCATION, NUMBER OF PEOPLE, respectively.
select department_name 'NAME', location_id 'LOCATION', count(employee_id) NUMBER_OF_PEOPLE, cast(avg(salary) as int) Average_salary
from employees emp
join departments dept
on emp.department_id = dept.department_id
group by department_name,location_id
--35.Write an SQL query to find the position of the alphabet (‘J’) in the first name column ‘Julia’ from employee’s table.
select CHARINDEX('j','julia')
--36.Create a query to display the employee number and last name of all employees who earns more than the average salary. Sort the result in ascending order of salary.
select employee_id, last_name,salary
from employees
where salary > (select AVG(salary) from employees)
order by salary
--37.Write a query that displays the employee number and last names of all employees who work in a department with any employees whose last name contains a letter U.
select employee_id, last_name
from employees
where department_id in (select department_id from employees where last_name like '%u%')
--38.Display the last name, department number and job id of all employees whose department location ID is 1700.
select last_name, emp.department_id,job_id
from employees emp
join departments dept
on emp.department_id = dept.department_id
where location_id = 1700
--39.Display the last name and salary of every employee who reports to king.
select last_name, salary from employees
where manager_id in (select employee_id from employees where first_name = 'king' or last_name = 'king')
--40.Display the department number, last name, job ID of every employee in Executive department.
select emp.department_id, last_name, job_id 
from employees emp
join departments dept
on emp.department_id = dept.department_id
where department_name = 'executive'
--41.Display all last name, their department name and id from employees and department tables.
select last_name, department_name, emp.department_id 
from employees emp
join departments dept
on emp.department_id = dept.department_id
--42.Display all the last name department name, id and location from employees, department, and locations tables.
select last_name, department_name, emp.department_id, dept.location_id
from employees emp
join departments dept
on emp.department_id = dept.department_id
join LOCATIONS loc
on dept.location_id = loc.location_id
--43.Write an SQL query to print all employee details from the employees table order by DEPARTMENT Descending.
select * from employees
order by department_id desc
--44.Write a query to determine who earns more than Mr. Tobias:
select first_name, last_name, employee_id, salary
from employees
where salary > (select salary from employees where first_name = 'tobias' or last_name = 'tobias')
order by salary desc
--45.Write a query to determine who earns more than Mr. Taylor:
select first_name, last_name, salary
from employees
where salary > (select max(salary) from employees where first_name = 'taylor' or last_name = 'taylor')
order by salary desc
--46.Find the job with the highest average salary.
select top 2 job_id, salary
from employees
order by salary desc;

select job_id, salary from employees 
where salary = (select max(salary) from employees);
--47.Find the employees that make more than Taylor and are in department 80. 
select first_name, last_name, salary
from employees
where salary > (select max(salary) from employees where first_name = 'taylor' or last_name = 'taylor') and 
department_id = 80
--48.Display all department names and their full street address.
select department_name, street_address
from departments dept
join LOCATIONS loc
on dept.location_id = loc.location_id
--49.Write an SQL query to fetch “FIRST_NAME” from employees table in upper case.
select upper(first_name) as FIRST_NAME
from employees
--50.Display the full name and salary of the employee that makes the most in departments 50 and 80.
select concat(first_name,' ',last_name), salary, department_id
from employees 
where salary in ((select max(salary) from employees where department_id = 50), 
(select max(salary) from employees where department_id = 80)) 
--51.Display the department names for the departments 10, 20 and 30.
select department_name, department_id 
from departments
where department_id in (10,20,30)
--52.Display all the manager id and department names of all the departments in United Kingdom (UK).
select manager_id, department_name, country_id
from departments dept
join LOCATIONS loc
on dept.location_id = loc.location_id
where country_id = 'uk'
--53.Display the full name and phone numbers of all employees who are not in location id 1700. 
select concat(first_name,' ',last_name) 'Name', phone_number, location_id
from employees emp
join departments dept
on emp.department_id = dept.department_id
where location_id = 1700
--54.Display the full name, department name and hire date of all employees that were hired after Shelli Baida.
select concat(first_name,' ',last_name), hire_date
from employees
where hire_date > (select hire_date from employees where first_name = 'shelli' and last_name = 'baida')
--55.Display the full name and salary of all employees who make the same salary as Janette King.
select concat(first_name,' ',last_name) 'Name', salary
from employees 
where salary > (select salary from employees where first_name = 'janette' and last_name = 'king')
--56.Display the full name hire date and salary of all employees who were hired in 2007 and make more than Elizabeth Bates.
select concat(first_name,' ',last_name),hire_date, salary
from employees 
where year(hire_date) = 2007 and salary > (SELECT salary from employees where first_name = 'elizabeth' and last_name = 'bates');
--57.Issue a query to display all departments whose average salary is greater than $8000. 

 with cte as
(select  emp.department_id,department_name, cast(avg(salary) as int) avg_salary
from employees emp
join departments dept
on emp.department_id = dept.department_id
group by emp.department_id, dept.department_name)
select department_id, department_name,avg_salary from cte 
where avg_salary > 8000;
--58.Issue a query to display all departments whose maximum salary is greater than 10000.
with toyo as
(select department_id, max(salary) as max_salary	 from employees
group by department_id)
select  department_id, max_salary from toyo
where max_salary > 10000;

--59.Issue a query to display the job title and total monthly salary for each job that has a total salary exceeding $13,000.
-- Exclude any job title that looks like rep and sort the result by total monthly salary.
with toyo as
(select job_title, sum(salary) sum_salary 
from jobs job
join employees emp
on job.job_id = emp.job_id
group by job_title)

select job_title, sum_salary from toyo
where sum_salary > 13000 and job_title not like '%rep%'
order by sum_salary desc

--60.Issue a query to display the department id, department name, location id and city of departments 20 and 50.
select department_id, department_name, dept.location_id, city
from departments dept
join LOCATIONS loc
on dept.location_id = loc.location_id
where department_id in (20,30)

--61.Issue a query to display the city and department name that are having a location id of 1400. 
select city, department_name, dept.location_id
from departments dept
join locations loc
on dept.location_id = loc.location_id
where dept.location_id = 1400

--62.Display the salary of last name, job id and salary of all employees whose salary is equal to the minimum salary.
select last_name, job_id, salary 
from employees
where salary = (select min(salary) from employees);

--63.Display the departments who have a minimum salary greater that of department 50.
 with toyo as
 (select department_id, min(salary) min_salary
 from employees
 group by department_id) 
 select department_id, min_salary 
 from toyo
 where min_salary > (select min_salary from toyo where department_id = 50)

 --64.Issue a query to display all employees who make more than Timothy Gates and less than Harrison Bloom.
 select employee_id from employees 
 where salary > (select salary from employees where first_name = 'timothy' and last_name = 'gates')
 and salary < (select salary from employees where first_name = 'harrison' and last_name = 'Bloom')

 --65.Issue a query to display all employees who are in Lindsey Smith or Joshua Patel department, who make more than Ismael Sciarra and were hired in 2007 and 2008.
 select employee_id, department_id
 from employees
 where department_id in (select department_id from employees 
 where (first_name = 'lindsey' and last_name = 'smith') or (first_name = 'joshua' and last_name = 'patel'))
 and salary > (select salary from employees where first_name = 'ismael' and last_name = 'sciarra') and year(hire_date) in (2007,2008) 

 --66.Issue a query to display the full name, 10-digit phone number, salary, department name, street address, postal code, city, and state province of all employees.

select concat(first_name,' ',last_name), phone_number, salary, department_name, street_address, postal_code, city, state_province
from employees emp
join departments dept
on emp.department_id = dept.department_id
join locations loc
on dept.location_id = loc.location_id

--67.Write an SQL query that fetches the unique values of DEPARTMENT from employees table and prints its length.
select distinct department_name, len(department_name) 'lenght of departent_name'
from departments

--68.Write an SQL query to print all employee details from the Worker table order by FIRST_NAME Ascending.
select * from employees
order by first_name asc