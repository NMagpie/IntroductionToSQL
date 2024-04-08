-- FIRST TASK:

USE AdventureWorksLT2022;

SELECT FirstName, LastName, CompanyName AS Company FROM SalesLT.Customer
	ORDER BY LastName ASC;

-- SECOND TASK

USE AdventureWorksLT2022;

SELECT FirstName, LastName, AddressLine1 FROM SalesLT.Customer JOIN 
	SalesLT.CustomerAddress ON Customer.CustomerID = CustomerAddress.CustomerID JOIN
	SalesLT.[Address] ON SalesLT.CustomerAddress.AddressID = [Address].AddressID
	WHERE SalesLT.Customer.LastName LIKE 'L%'
	ORDER BY LastName, FirstName

-- THIRD TASK

USE AdventureWorksLT2022;

SELECT CountryRegion, StateProvince, COUNT(SalesLT.Customer.CustomerID) AS CustomersN FROM SalesLT.Customer JOIN 
	SalesLT.CustomerAddress ON Customer.CustomerID = CustomerAddress.CustomerID JOIN
	SalesLT.[Address] ON SalesLT.CustomerAddress.AddressID = [Address].AddressID
	GROUP BY CountryRegion, StateProvince
	ORDER BY StateProvince ASC

-- FOURTH TASK

USE AdventureWorksLT2022;

SELECT SalesOrderID, SUM(LineTotal) AS Total FROM SalesLT.SalesOrderDetail
	GROUP BY SalesOrderID