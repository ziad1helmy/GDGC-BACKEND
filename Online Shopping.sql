CREATE DATABASE Online_Shopping ;
USE Online_Shopping;

CREATE TABLE Customer(
	Customer_Id INT IDENTITY PRIMARY KEY,
	Customer_Name NVARCHAR(50) UNIQUE NOT NULL,
	Phone NVARCHAR(20) UNIQUE NOT NULL,
	Adderss NVARCHAR(100) NOT NULL,
);

CREATE TABLE Orders(
	Order_Id INT IDENTITY PRIMARY KEY,
	Order_Date DATETIME DEFAULT GETUTCDATE(),
	Total_Amount DECIMAL(10,2) NOT NULL,
	Order_Status NVARCHAR(20) CHECK(Order_Status IN 
('Pending','Shipped','Deliverd','Canceld'))DEFAULT 'Pending' ,
	OrderCustomer_ID INT NOT NULL,
	FOREIGN KEY (OrderCustomer_ID) REFERENCES Customer(Customer_Id),
	Order_Details_Id INT UNIQUE NOT NULL,
	Quantity INT NOT NULL,
	Price DECIMAL(15,2)
);

CREATE TABLE Products(
	Product_Id INT IDENTITY PRIMARY KEY ,
	Category NVARCHAR(30) UNIQUE NOT NULL,
	Product_Name NVARCHAR(50) NOT NULL,
	Discription NVARCHAR(100) NOT NULL,
	Product_Price DECIMAL(15,2) NOT NULL,
	Product_Order_Details_Id INT UNIQUE NOT NULL,
);
CREATE TABLE Suppliers(
	Suppliers_Id INT IDENTITY PRIMARY KEY ,
	Contact_Info NVARCHAR (20) UNIQUE NOT NULL,
	Suppliers_Name NVARCHAR (50) UNIQUE NOT NULL,
	);

CREATE TABLE Product_Order(
	Product_Id INT  NOT NULL,
	Order_Id INT  NOT NULL,
	FOREIGN KEY (Product_Id) REFERENCES Products(Product_Id),
	FOREIGN KEY (Order_Id) REFERENCES Orders(Order_Id),
	PRIMARY KEY (Product_Id, Order_Id)
);
CREATE TABLE Product_Supply(
	Product_Id INT  NOT NULL,
	Supp_Id INT  NOT NULL,
	FOREIGN KEY (Product_Id) REFERENCES Products(Product_Id),
	FOREIGN KEY (Supp_Id) REFERENCES Suppliers(Suppliers_Id),
	PRIMARY KEY (Product_Id, Supp_Id)
);

--DATA FROM CHATGPT
	INSERT INTO Customer (Customer_Name, Phone, Adderss)
	VALUES ('John Doe', '1234567890', '123 Main St, New York'),
('Jane Smith', '0987654321', '456 Elm St, Los Angeles');
	INSERT INTO Products (Category, Product_Name, Discription, Product_Price)
	VALUES ('Electronics', 'Smartphone', 'Latest model with high-end features', 699.99),
('Clothing', 'Jeans', 'Comfortable blue denim jeans', 49.99);
	INSERT INTO Suppliers (Contact_Info, Suppliers_Name)
	VALUES ('1112223333', 'TechSuppliers Inc.'),('4445556666', 'FashionTrends Ltd.');
	INSERT INTO Orders (Total_Amount, Order_Status, OrderCustomer_ID)
	VALUES (749.98, 'Pending', 1),(99.99, 'Shipped', 2);
	INSERT INTO Product_Order (Product_Id, Order_Id)
	VALUES (1, 1),(2, 2);
	INSERT INTO Product_Supply (Product_Id, Supp_Id)
	VALUES (1, 1),(2, 2);

ALTER TABLE Products ADD rating DECIMAL(5,5) DEFAULT 0;
ALTER TABLE Products ADD CONSTRAINT DEFAULT_Category DEFAULT 'new' FOR Category;
ALTER TABLE Products DROP COLUMN rating;

UPDATE Orders SET Order_Date = GETDATE() WHERE Order_Id > 0;
DELETE FROM Products WHERE Product_Name IS NOT NULL AND Product_Name != 'Null';
