-- FIRST TASK

USE AdventureWorks2022;

SELECT FirstName, LastName, BusinessEntityID AS Employee_id FROM Person.Person
	ORDER BY LastName ASC

-- SECOND TASK

USE AdventureWorks2022;

SELECT p.BusinessEntityID, FirstName, LastName, PhoneNumber FROM Person.PersonPhone ph
	JOIN Person.Person p ON p.BusinessEntityID = ph.BusinessEntityID
	WHERE LastName LIKE 'L%'
	ORDER BY LastName, FirstName

-- THIRD TASK

USE AdventureWorks2022;

--SELECT PostalCode, COUNT(Person.Person.LastName) AS NameNumber, COUNT(Sales.SalesPerson.SalesYTD) AS SalesNumber
SELECT PostalCode, Person.Person.LastName, Sales.SalesPerson.SalesYTD
	FROM Person.[Address] 
	JOIN Person.BusinessEntityAddress ON Person.[Address].AddressID = Person.BusinessEntityAddress.AddressID 
	JOIN Person.Person ON Person.BusinessEntityAddress.BusinessEntityID = Person.Person.BusinessEntityID 
	JOIN Sales.SalesPerson ON Person.BusinessEntityAddress.BusinessEntityID = Sales.SalesPerson.BusinessEntityID
	WHERE TerritoryID IS NOT NULL AND SalesYTD > 0
	GROUP BY PostalCode, LastName
	ORDER BY SalesYTD DESC, PostalCode ASC

-- FOURTH TASK

USE AdventureWorks2022;

SELECT SalesOrderID,
SUM(LineTotal) AS TotalCost 
FROM Sales.SalesOrderDetail
	GROUP BY SalesOrderID
	HAVING SUM(LineTotal) > 100000