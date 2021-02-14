-- Perform a join on employees and titles tables and sort and filter results
SELECT employees.emp_no, 
	   employees.first_name,
	   employees.last_name, 
	   titles.title, 
	   titles.from_date,
	   titles.to_date
INTO retirement_titles
FROM employees
Left JOIN titles ON employees.emp_no=titles.emp_no
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no;

-- Check the table
SELECT * FROM retirement_titles;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON(retirement_titles.emp_no)
       retirement_titles.emp_no,
	   retirement_titles.first_name,
	   retirement_titles.last_name,
	   retirement_titles.title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Check the table
SELECT * FROM unique_titles;


--Count number of employees by most recent title who are about to retire
SELECT COUNT(title) as "count", title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY "count" DESC;

-- Check the table
SELECT * FROM retiring_titles;


--Deliverable 2 create a mentorship eligiblity table
SELECT DISTINCT ON(employees.emp_no) 
	employees.emp_no,
	employees.first_name,
	employees.last_name,
	employees.birth_date,
	employee_dept.from_date,
	employee_dept.to_date,
	titles.title
INTO mentorship_eligibilty
FROM employees
INNER JOIN employee_dept
ON (employees.emp_no = employee_dept.emp_no)
INNER JOIN titles 
ON (employees.emp_no = titles.emp_no)
WHERE (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (employee_dept.to_date = '9999-01-01')
ORDER BY emp_no;

-- Check the table
SELECT * FROM mentorship_eligibilty;
