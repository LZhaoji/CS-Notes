-- LINK : https://en.wikibooks.org/wiki/SQL_Exercises/Employee_management
-- ---------------------------------------
-- Build the Schema
-- ---------------------------------------

CREATE TABLE Departments (
                             Code INTEGER PRIMARY KEY,
                             Name varchar(255) NOT NULL ,
                             Budget decimal NOT NULL
);

CREATE TABLE Employees (
                           SSN INTEGER PRIMARY KEY,
                           Name varchar(255) NOT NULL ,
                           LastName varchar(255) NOT NULL ,
                           Department INTEGER NOT NULL ,
                           foreign key (department) references Departments(Code)
);

INSERT INTO Departments(Code,Name,Budget) VALUES(14,'IT',65000);
INSERT INTO Departments(Code,Name,Budget) VALUES(37,'Accounting',15000);
INSERT INTO Departments(Code,Name,Budget) VALUES(59,'Human Resources',240000);
INSERT INTO Departments(Code,Name,Budget) VALUES(77,'Research',55000);

INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('123234877','Michael','Rogers',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('152934485','Anand','Manikutty',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('222364883','Carol','Smith',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('326587417','Joe','Stevens',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332154719','Mary-Anne','Foster',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332569843','George','ODonnell',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('546523478','John','Doe',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('631231482','David','Smith',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('654873219','Zacary','Efron',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('745685214','Eric','Goldsmith',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657245','Elizabeth','Doe',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657246','Kumar','Swamy',14);

-- 2.1 Select the last name of all employees.
select LastName from Employees;
-- 2.2 Select the last name of all employees, without duplicates.
select distinct LastName from Employees;
-- 2.3 Select all the data of employees whose last name is "Smith".
select SSN,Name,LastName,Department from Employees where LastName = 'Smith';
-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
select SSN,Name,LastName,Department from Employees where LastName = 'Smith' or LastName = 'Doe';
-- 2.5 Select all the data of employees that work in department 14.
select SSN,Name,LastName,Department from Employees where Department = 14;
-- 2.6 Select all the data of employees that work in department 37 or department 77.
select SSN,Name,LastName,Department from Employees where Department = 37 or Department = 77;
-- 2.7 Select all the data of employees whose last name begins with an "S".
select SSN,Name,LastName,Department from Employees where LastName like 'S%';
-- 2.8 Select the sum of all the departments' budgets.
select sum(Departments.Budget) from Departments;
-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).
select Departments.Name,count(LastName)
from Employees, Departments
where Employees.Department = Departments.Code
group by Departments.Name;
-- 2.10 Select all the data of employees, including each employee's department's data.
select e.SSN,e.Name,e.LastName,e.Department,d.Name,d.Budget
from Employees e, Departments d
where e.Department = d.Code;
-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.
select e.Name,e.LastName,d.Name,d.Budget
from Employees e,Departments d
where e.Department = d.Code;
-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.
select e.Name,e.LastName
from Employees e,Departments d
where e.Department = d.Code
and d.Budget > 60000;
-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
select name
from Departments
where
Budget > (select avg(Budget) from Departments);
-- 2.14 Select the names of departments with more than two employees.
select d.Name,count(e.Name) count
from Employees e,Departments d
where e.Department = d.Code
group by d.Name
having count > 2;
-- 2.15 Very Important - Select the name and last name of employees working for departments with second lowest budget.
select Name,LastName
from Employees
where Department =
(select Code
from (select code, name, budget
      from Departments
      order by Budget
      limit 2) as sub
order by sub.Budget desc limit 1);
-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11.
insert into Departments
values (11,'Quality Assurance',40000);
-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
insert into Employees
values (847219811,'Mary','Moore',11);
-- 2.17 Reduce the budget of all departments by 10%.
update Departments
set Budget = Budget * 0.9;
-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).
update Employees
set Department = 14
where Department = 77;
-- 2.19 Delete from the table all employees in the IT department (code 14).
delete from Employees
where Department = 14;
-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
delete
from Employees e
where Department
in (select Code from Departments where Budget >= 60000);
-- 2.21 Delete from the table all employees.
delete from Employees;
