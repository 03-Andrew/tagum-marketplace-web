-- SQLite version of the database schema

CREATE TABLE brand (
  Brand_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  Brand_Name TEXT NOT NULL UNIQUE
);

CREATE TABLE customer (
  Customer_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  Customer_Name TEXT NOT NULL,
  Customer_PhoneNo TEXT,
  Customer_Address TEXT
);

CREATE TABLE employee (
  Employee_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  Employee_Name TEXT NOT NULL,
  Employee_Gender TEXT CHECK(Employee_Gender IN ('Male','Female','Other')),
  Employee_DOB DATE,
  Employee_Address TEXT,
  Employee_ContactNo TEXT
);

CREATE TABLE product (
  Product_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  Product_Name TEXT NOT NULL UNIQUE,
  Brand_ID INTEGER,
  FOREIGN KEY (Brand_ID) REFERENCES brand(Brand_ID)
);

CREATE TABLE productvariant (
  Bar_Code TEXT PRIMARY KEY,
  Product_ID INTEGER,
  Unit_Weight REAL,
  Unit_Size TEXT,
  Unit_Price REAL,
  Inventory_Quantity INTEGER NOT NULL,
  FOREIGN KEY (Product_ID) REFERENCES product(Product_ID)
);

CREATE TABLE remarks (
  Remarks_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  Remarks TEXT
);

CREATE TABLE sales (
  Sales_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  Customer_ID INTEGER,
  Employee_ID INTEGER,
  Sales_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (Customer_ID) REFERENCES customer(Customer_ID),
  FOREIGN KEY (Employee_ID) REFERENCES employee(Employee_ID)
);

CREATE TABLE salesdetails (
  Sales_ID INTEGER,
  Bar_Code TEXT,
  Unit_Price REAL,
  Quantity INTEGER,
  Subtotal REAL GENERATED ALWAYS AS (Quantity * Unit_Price) STORED,
  PRIMARY KEY (Sales_ID, Bar_Code),
  FOREIGN KEY (Sales_ID) REFERENCES sales(Sales_ID),
  FOREIGN KEY (Bar_Code) REFERENCES productvariant(Bar_Code)
);

CREATE TABLE stockoutsupply (
  StockOut_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  SupplyDetail_ID INTEGER,
  Employee_ID INTEGER,
  Remarks_ID INTEGER,
  StockOut_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (SupplyDetail_ID) REFERENCES supplydetails(SupplyDetail_ID),
  FOREIGN KEY (Employee_ID) REFERENCES employee(Employee_ID),
  FOREIGN KEY (Remarks_ID) REFERENCES remarks(Remarks_ID)
);

CREATE TABLE supplier (
  Supplier_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  Supplier_Name TEXT NOT NULL,
  Supplier_Email TEXT,
  Supplier_Address TEXT,
  Supplier_ContactNo TEXT
);

CREATE TABLE supply (
  Supply_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  Supplier_ID INTEGER,
  Employee_ID INTEGER,
  Supply_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (Supplier_ID) REFERENCES supplier(Supplier_ID),
  FOREIGN KEY (Employee_ID) REFERENCES employee(Employee_ID)
);

CREATE TABLE supplydetails (
  SupplyDetail_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  Supply_ID INTEGER,
  Bar_Code TEXT,
  Quantity INTEGER,
  Unit_Price REAL,
  Expiry DATE,
  Subtotal REAL GENERATED ALWAYS AS (Quantity * Unit_Price) STORED,
  FOREIGN KEY (Supply_ID) REFERENCES supply(Supply_ID),
  FOREIGN KEY (Bar_Code) REFERENCES productvariant(Bar_Code)
);

CREATE TABLE users (
  Employee_ID INTEGER PRIMARY KEY,
  Username TEXT NOT NULL UNIQUE,
  Password TEXT NOT NULL,
  Role TEXT CHECK(Role IN ('admin','cashier','stockman')) NOT NULL,
  User_DateReg TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (Employee_ID) REFERENCES employee(Employee_ID)
);

-- Insert the admin user
INSERT INTO employee (Employee_ID, Employee_Name) VALUES (4, 'Admin');
INSERT INTO users (Employee_ID, Username, Password, Role) 
VALUES (4, 'admin', '$2b$10$J49fC3.1.NFwhtYYrDuqPusz245mhPgqXpfjSFfiZvOTL.ZVMoDm.', 'admin'); 