
-- 1. How many currencies cost more than 1$ on 2011.07.02

USE AdventureWorks2022;

SELECT C.Name FROM [Sales].[Currency] AS C
WHERE C.CurrencyCode IN (
	SELECT CR.ToCurrencyCode FROM [AdventureWorks2022].[Sales].[CurrencyRate] AS CR
	WHERE CR.AverageRate > 1 AND CR.CurrencyRateDate = '2011-07-02'
);

-- 2. Account number of customers which store id is not in the store table

USE AdventureWorks2022;

SELECT C.AccountNumber FROM [Sales].[Customer] AS C
WHERE NOT EXISTS (
	SELECT * FROM [Sales].[Store] AS S
	WHERE C.StoreID = S.BusinessEntityID
) 
AND C.StoreID IS NOT NULL;

-- 3. Abbreviations of existing Credit Card Types with expiracy date due to average year of all records

USE AdventureWorks2022;

SELECT CardAbbreviation = CASE CC1.CardType
	WHEN 'SuperiorCard' THEN 'SC'
	WHEN 'Vista' THEN 'V'
	WHEN 'Distinguish' THEN 'D'
	WHEN 'ColonialVoice' THEN 'CV'
END,
CC1.ExpYear
FROM [Sales].[CreditCard] AS CC1
WHERE CC1.ExpYear > (
	SELECT AVG(CC2.ExpYear) FROM [Sales].[CreditCard] AS CC2
);

-- 4. Employees with maximum sick leave hours

USE AdventureWorks2022;

SELECT P.FirstName, P.LastName FROM [Person].[Person] AS P
WHERE P.BusinessEntityID IN (
	SELECT E1.BusinessEntityID FROM [HumanResources].[Employee] AS E1
	WHERE E1.SickLeaveHours = 
		( SELECT MAX(E2.SickLeaveHours) FROM [HumanResources].[Employee] AS E2 )
);

-- 5. Name and Product Number of every product not having instructions

USE AdventureWorks2022;

SELECT P.Name, P.ProductNumber FROM [Production].[Product] AS P
WHERE P.ProductID IN (
	SELECT PM.ProductModelID FROM [Production].[ProductModel] AS PM
	WHERE PM.Instructions IS NULL
);

-- 6. Show OrderID and Total due for Orders which Ship Method Ship rate more than 1.5

USE AdventureWorks2022;

SELECT POH.PurchaseOrderID, POH.TotalDue FROM [Purchasing].[PurchaseOrderHeader] AS POH
WHERE POH.ShipMethodID IN (
	SELECT SM.ShipMethodID FROM [Purchasing].[ShipMethod] AS SM
	WHERE SM.ShipRate > 1.5
);

-- 7. Employees which email does not end with 0

USE AdventureWorks2022;

SELECT DISTINCT P.FirstName, P.LastName FROM [Person].[Person] AS P
WHERE P.BusinessEntityID NOT IN (
	SELECT EA.BusinessEntityID FROM [Person].[EmailAddress] AS EA
	WHERE EA.EmailAddress LIKE '%0@%'
);

-- 8. Name of of the Store which customers are in Territory ID = 6

USE AdventureWorks2022;

SELECT S.Name FROM [Sales].[Store] AS S
WHERE EXISTS (
	SELECT * FROM [Sales].[Customer] AS C
	WHERE C.StoreID = S.BusinessEntityID AND C.TerritoryID = 6
);