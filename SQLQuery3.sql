USE AdventureWorks2022;

-- 1. NUMBER OF EMPLOYEES IN EACH DEPARTMENT

SELECT HumanResources.Department.Name, COUNT(HumanResources.EmployeeDepartmentHistory.BusinessEntityID) AS 'Number of People'
FROM HumanResources.Employee AS Employee_1 JOIN
	HumanResources.EmployeeDepartmentHistory ON Employee_1.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID JOIN
	HumanResources.Department ON HumanResources.EmployeeDepartmentHistory.DepartmentID = HumanResources.Department.DepartmentID
GROUP BY HumanResources.Department.Name;

-- 2. NUMBER OF PEOPLE PER JOB TITLE

USE AdventureWorks2022;

SELECT JobTitle, COUNT(DISTINCT Employee.BusinessEntityID) AS 'Number of people'
FROM HumanResources.Employee
GROUP BY JobTitle;

-- 3. NUMBER OF CUSTOMERS FROM EVERY COUNTRY

USE AdventureWorks2022;

SELECT Person.CountryRegion.Name, COUNT(DISTINCT Sales.Customer.CustomerID) AS 'Number of Customers'
FROM Sales.Customer JOIN
	Sales.SalesTerritory ON Sales.Customer.TerritoryID = Sales.SalesTerritory.TerritoryID JOIN
	Person.CountryRegion ON Sales.SalesTerritory.CountryRegionCode = Person.CountryRegion.CountryRegionCode
GROUP BY Person.CountryRegion.Name;

-- 4. MOST PROFITABLE COUNTRIES

USE AdventureWorks2022;

SELECT TOP (5) Person.CountryRegion.Name, SUM(Sales.SalesOrderHeader.TotalDue) AS 'Number of Customers'
FROM Sales.Customer JOIN
	Sales.SalesTerritory ON Sales.Customer.TerritoryID = Sales.SalesTerritory.TerritoryID JOIN
	Person.CountryRegion ON Sales.SalesTerritory.CountryRegionCode = Person.CountryRegion.CountryRegionCode JOIN
	Sales.SalesOrderHeader ON Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID
GROUP BY Person.CountryRegion.Name
ORDER BY 'Number of Customers' DESC;

-- 5. AVERAGE REVIEW RATING PER PRODUCT

USE AdventureWorks2022;

SELECT Production.Product.Name, AVG(Rating) AS 'Average Rating' 
FROM Production.ProductReview JOIN
	Production.Product ON Production.ProductReview.ProductID = Production.Product.ProductID
GROUP BY Production.Product.Name;

-- 6. NUMBER OF ADDRESSES BY TYPE

USE AdventureWorks2022;

SELECT Person.AddressType.Name, COUNT(Person.AddressType.AddressTypeID) AS 'Number of Addresses'
FROM Person.BusinessEntityAddress JOIN
	Person.AddressType ON Person.BusinessEntityAddress.AddressTypeID = Person.AddressType.AddressTypeID
GROUP BY Person.AddressType.Name;

-- 7. MOST POPULAR PRODUCT TO BUY WITH PRICE MORE THAN 500

USE AdventureWorks2022;

SELECT Product.Name, COUNT(SalesOrderDetail.ProductID) AS 'Times ordered'
FROM Sales.SalesOrderDetail JOIN
	Production.Product ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
WHERE Product.ListPrice > 500
GROUP BY Product.Name
ORDER BY 'Times ordered' DESC;

-- 8. TOP 10 PRODUCTS BY PRICE AND POPULARITY

USE AdventureWorks2022;

SELECT TOP (10) Product.Name, COUNT(SalesOrderDetail.ProductID) AS 'Times ordered', Product.ListPrice
FROM Sales.SalesOrderDetail JOIN
	Production.Product ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
GROUP BY Product.Name, Product.ListPrice
ORDER BY Product.ListPrice DESC, 'Times ordered' DESC;