CREATE TABLE titles (
	title_id VARCHAR(10) PRIMARY KEY,
	title VARCHAR(255)
);



CREATE TABLE employees(
	emp_no INT PRIMARY KEY,
	emp_title VARCHAR(10),
	FOREIGN KEY (emp_title) REFERENCES titles(title_id),
	birth_date DATE,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	sex VARCHAR(10),
	hire DATE
);


CREATE TABLE departments(
	dept_no VARCHAR(10) PRIMARY KEY,
	dept_name VARCHAR(255)
);


CREATE TABLE salaries(
	emp_no INT PRIMARY KEY,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT
);


CREATE TABLE dept_emp(
	emp_no INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR(255),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY(emp_no, dept_no)
);


CREATE TABLE dept_manager(
	dept_no VARCHAR(10),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	emp_no INT PRIMARY KEY,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-----------------------------------------------------------------------------------------------------------------------------

1)
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no;

2)
SELECT e.first_name, e.last_name, e.hire
FROM employees AS e
WHERE EXTRACT(YEAR FROM hire) = 1986;

3)
SELECT d.dept_no AS department_number, d.dept_name AS department_name, dm.emp_no AS manager_employee_number, e.last_name AS manager_last_name, e.first_name AS manager_first_name
FROM dept_manager dm
JOIN departments d ON dm.dept_no = d.dept_no
JOIN employees e ON dm.emp_no = e.emp_no;

4)
SELECT e.emp_no AS employee_number, e.last_name, e.first_name, de.dept_no AS department_number,d.dept_name AS department_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no;


5)
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

6)
SELECT e.emp_no AS employee_number, e.last_name, e.first_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

7)
SELECT e.emp_no AS employee_number, e.last_name, e.first_name, d.dept_name AS department_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

8)
SELECT last_name, COUNT(*) AS name_count
FROM employees
GROUP BY last_name
ORDER BY name_count DESC;