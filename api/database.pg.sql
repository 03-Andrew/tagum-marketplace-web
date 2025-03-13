-- PostgreSQL version of the database schema

CREATE TABLE brand (
  Brand_ID SERIAL PRIMARY KEY,
  Brand_Name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE customer (
  Customer_ID SERIAL PRIMARY KEY,
  Customer_Name VARCHAR(100) NOT NULL,
  Customer_PhoneNo VARCHAR(15),
  Customer_Address VARCHAR(255)
);

CREATE TABLE employee (
  Employee_ID SERIAL PRIMARY KEY,
  Employee_Name VARCHAR(100) NOT NULL,
  Employee_Gender VARCHAR(10) CHECK(Employee_Gender IN ('Male','Female','Other')),
  Employee_DOB DATE,
  Employee_Address VARCHAR(255),
  Employee_ContactNo VARCHAR(20)
);

CREATE TABLE product (
  Product_ID SERIAL PRIMARY KEY,
  Product_Name VARCHAR(100) NOT NULL UNIQUE,
  Brand_ID INTEGER REFERENCES brand(Brand_ID)
);

CREATE TABLE productvariant (
  Bar_Code VARCHAR(50) PRIMARY KEY,
  Product_ID INTEGER REFERENCES product(Product_ID),
  Unit_Weight DECIMAL(10,2),
  Unit_Size VARCHAR(50),
  Unit_Price DECIMAL(10,2),
  Inventory_Quantity INTEGER NOT NULL
);

CREATE TABLE remarks (
  Remarks_ID SERIAL PRIMARY KEY,
  Remarks VARCHAR(255)
);

CREATE TABLE sales (
  Sales_ID SERIAL PRIMARY KEY,
  Customer_ID INTEGER REFERENCES customer(Customer_ID),
  Employee_ID INTEGER REFERENCES employee(Employee_ID),
  Sales_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE salesdetails (
  Sales_ID INTEGER REFERENCES sales(Sales_ID),
  Bar_Code VARCHAR(50) REFERENCES productvariant(Bar_Code),
  Unit_Price DECIMAL(10,2),
  Quantity INTEGER,
  Subtotal DECIMAL(10,2) GENERATED ALWAYS AS (Unit_Price * Quantity) STORED,
  PRIMARY KEY (Sales_ID, Bar_Code)
);

CREATE TABLE stockoutsupply (
  StockOut_ID SERIAL PRIMARY KEY,
  SupplyDetail_ID INTEGER,
  Employee_ID INTEGER REFERENCES employee(Employee_ID),
  Remarks_ID INTEGER REFERENCES remarks(Remarks_ID),
  StockOut_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE supplier (
  Supplier_ID SERIAL PRIMARY KEY,
  Supplier_Name VARCHAR(100) NOT NULL,
  Supplier_Email VARCHAR(100),
  Supplier_Address VARCHAR(255),
  Supplier_ContactNo VARCHAR(15)
);

CREATE TABLE supply (
  Supply_ID SERIAL PRIMARY KEY,
  Supplier_ID INTEGER REFERENCES supplier(Supplier_ID),
  Employee_ID INTEGER REFERENCES employee(Employee_ID),
  Supply_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE supplydetails (
  SupplyDetail_ID SERIAL PRIMARY KEY,
  Supply_ID INTEGER REFERENCES supply(Supply_ID),
  Bar_Code VARCHAR(50) REFERENCES productvariant(Bar_Code),
  Quantity INTEGER,
  Unit_Price DECIMAL(10,2),
  Expiry DATE,
  Subtotal DECIMAL(10,2) GENERATED ALWAYS AS (Unit_Price * Quantity) STORED
);

CREATE TABLE users (
  Employee_ID INTEGER PRIMARY KEY REFERENCES employee(Employee_ID),
  Username VARCHAR(100) NOT NULL UNIQUE,
  Password VARCHAR(256) NOT NULL,
  Role VARCHAR(10) CHECK(Role IN ('admin','cashier','stockman')) NOT NULL,
  User_DateReg TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert the admin user
INSERT INTO employee (Employee_ID, Employee_Name) VALUES (4, 'Admin');
INSERT INTO users (Employee_ID, Username, Password, Role) 
VALUES (4, 'admin', '$2b$10$J49fC3.1.NFwhtYYrDuqPusz245mhPgqXpfjSFfiZvOTL.ZVMoDm.', 'admin'); 