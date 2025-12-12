-- 1.Create DataBase
Create Database Employee;
Use Employee;

-- Create Tables
Create table Employees(
  Employee_id int,
  Employee_Name varchar(50),
  Gender enum('M','F'),
  Age int,
  Hire_Date date,
  Designation varchar(100),
  Department_id int,
  Location__id int,
  Salary decimal(10,2)
  );
  
  Create Table Departments(
    Department_id int,
	Department_name varchar(100)
   ); 
  
  Create Table Location(
   Location_id int,
   location varchar(30)
  ); 
   
-- 2. Table Alteration

Alter Table employees ADD Email varchar(30);

Alter Table employees Modify Designation Varchar(150);

Alter Table employees  Drop age;

Alter Table employees Rename Column Hire_Date to Date_of_Joining;


-- 3. Rename Tables

Rename Table Departments to Departments_Info;

Rename Table Location to Locations;

-- 4. TRUNCATE Employees Table

Truncate Table Employees;

-- DROP Table & Database

Drop table Employees;

Drop Database Employees;

-- Table Date Recreation 

Drop Database if exists employee;

Create Database employee;

Use Employee;

Create Table Departments(
 Department_id int UNIQUE,
 Department_name varchar(100) NOT NULL UNIQUE
 );

 Create Table Locations(
   Location_id int AUTO_INCREMENT,
   location varchar(30) NOT NULL,
   PRIMARY KEY (location_id)
  ); 
  
  Create table Employees(
  Employee_id int UNIQUE PRIMARY KEY,
  Employee_Name varchar(50) NOT NULL,
  Gender enum('M','F'),
  Age int CHECK (age >=18),
  Hire_Date date DEFAULT (CURDATE()),
  Designation varchar(100),
  Department_id int,
  Location_id int,
  Salary decimal(10,2)
  );

  ALTER TABLE Employees
  
ADD CONSTRAINT fk_department
FOREIGN KEY (Department_id) REFERENCES Departments(Department_id),

ADD CONSTRAINT fk_location
FOREIGN KEY (Location__id) REFERENCES Locations(Location_id);










  
  