
--DELIVERABLE 1

--Needed to create titles table again--previous table was receiving errors and had incorrect keys assigned.
CREATE TABLE new_titles(
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);
DROP TABLE new_titles;

--New table to hold titles for those born between '52 and '55
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN new_titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows and filter those who left the company
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date IN('9999-01-01')
ORDER BY emp_no, title DESC;

--Creating a total count by title
SELECT COUNT (title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count desc;

--DELIVERABLE 2
SELECT DISTINCT ON (emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
LEFT JOIN new_titles as ti
ON (e.emp_no = ti.emp_no)
WHERE(e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND de.to_date IN('9999-01-01')
ORDER BY emp_no;




