-- HR & Payroll Management System (SQL-Only)

CREATE DATABASE hr_payroll_db;
USE hr_payroll_db;

CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    dept_id INT,
    join_date DATE,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE attendance (
    att_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    att_date DATE,
    status ENUM('P','A'),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

CREATE TABLE salary (
    emp_id INT PRIMARY KEY,
    basic DECIMAL(10,2),
    hra DECIMAL(10,2),
    bonus DECIMAL(10,2),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

CREATE TABLE deductions (
    emp_id INT,
    tax DECIMAL(10,2),
    pf DECIMAL(10,2),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

CREATE TABLE payroll (
    payroll_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    pay_month INT,
    pay_year INT,
    net_salary DECIMAL(10,2),
    generated_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    action VARCHAR(100),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO departments (dept_name) VALUES ('IT'), ('HR');

INSERT INTO employees (emp_name, email, dept_id, join_date)
VALUES ('Amit Kumar', 'amit@gmail.com', 1, '2024-01-10');

INSERT INTO salary VALUES (1, 30000, 10000, 5000);
INSERT INTO deductions VALUES (1, 3000, 2000);

DELIMITER //

CREATE PROCEDURE generate_payroll(p_month INT, p_year INT)
BEGIN
    INSERT INTO payroll (emp_id, pay_month, pay_year, net_salary)
    SELECT s.emp_id, p_month, p_year,
           (s.basic + s.hra + s.bonus - d.tax - d.pf)
    FROM salary s
    JOIN deductions d ON s.emp_id = d.emp_id;
END //

CREATE TRIGGER payroll_audit
AFTER INSERT ON payroll
FOR EACH ROW
BEGIN
    INSERT INTO audit_log(action)
    VALUES ('Payroll Generated');
END //

DELIMITER ;

CREATE VIEW payroll_report AS
SELECT e.emp_name, p.pay_month, p.pay_year, p.net_salary
FROM payroll p
JOIN employees e ON p.emp_id = e.emp_id;
