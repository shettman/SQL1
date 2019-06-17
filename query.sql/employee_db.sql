-- Exported from QuickDBD: https://www.quickdatatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/ffjxAi
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Employee Databse

DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;


CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

SELECT * FROM departments LIMIT 10
SELECT * FROM dept_emp LIMIT 10;
SELECT * FROM dept_manager LIMIT 10;
SELECT * FROM employees LIMIT 10;
SELECT * FROM salaries LIMIT 10;
SELECT * FROM titles LIMIT 10;


--1.List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no AS employee_number, 
		employees.last_name, 
		employees.first_name, 
		employees.gender, 
		salaries.salary
FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no
ORDER BY employee_number ASC;


--2.List employees who were hired in 1986.
SELECT first_name, last_name, hire_date FROM employees 
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date ASC;
SE

--3.List the manager of each department with the following information: department number, department name, the manager's employee number,
--last name, first name, and start and end employment dates.
SELECT departments.dept_no AS department_number, 
		departments.dept_name AS department_name, 
		dept_manager.emp_no AS employee_number, 
		employees.last_name, 
		employees.first_name, 
		dept_manager.from_date AS employment_start, 
		dept_manager.to_date AS employment_end
FROM dept_manager
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no
ORDER BY department_number ASC;


--4.List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT dept_emp.emp_no AS employee_number, 
		employees.last_name, 
		employees.first_name, 
		departments.dept_name AS department_name
FROM dept_emp
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
ORDER BY department_name ASC;


--5.List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'
ORDER BY last_name ASC;


--6.List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no AS employee_number, 
		employees.last_name, 
		employees.first_name, 
		departments.dept_name AS department_name
FROM dept_emp
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales'
ORDER BY employee_number ASC;


--7.List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no AS employee_number, 
		employees.last_name, 
		employees.first_name, 
		departments.dept_name AS department_name
FROM dept_emp
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development'
ORDER BY employee_number ASC;


--8.In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(*) As frequency_count
FROM employees
GROUP BY last_name
ORDER BY frequency_count DESC;





