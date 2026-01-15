# 🧑‍💼 HR & Payroll Management System (SQL-Only)

## 📌 Project Overview
The **HR & Payroll Management System** is a **SQL-only database project** designed to manage core HR operations such as employee records, departments, attendance, salary structure, deductions, and automated payroll generation.

This project demonstrates strong **SQL fundamentals** including:
- Database design
- Table relationships
- Stored procedures
- Triggers
- Views
- Data integrity using foreign keys

This project is ideal for **SQL Developer / Database roles** and technical interviews.

---

## 🎯 Objectives
- Manage employee and department data
- Store salary components and deductions
- Automatically generate payroll
- Maintain audit logs for payroll actions
- Generate payroll reports using SQL views

---

## 🛠️ Technologies Used
- **Database:** MySQL / MariaDB  
- **Language:** SQL only  
- **Tools:**  
  - XAMPP  
  - MySQL CLI  
  - VS Code  

> ❌ No frontend  
> ❌ No backend language  
> ✅ Pure SQL Project

---

## 🗂️ Database Structure

### 📁 Tables
| Table Name | Description |
|-----------|------------|
| `departments` | Stores department details |
| `employees` | Stores employee information |
| `attendance` | Tracks employee attendance |
| `salary` | Stores salary components |
| `deductions` | Stores tax and PF deductions |
| `payroll` | Stores generated payroll |
| `audit_log` | Logs payroll generation actions |

---

## 🔗 Relationships
- One **Department** → Many **Employees**
- One **Employee** → One **Salary**
- One **Employee** → One **Deduction**
- One **Employee** → Multiple **Payroll records**

---

## ⚙️ Key Features

### ✅ Stored Procedure – Payroll Generation
Payroll is generated using a stored procedure:

```sql
CALL generate_payroll(1, 2025);
