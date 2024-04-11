-- 1. Create new order ([Purchasing] One or more PurcahseOrderDetail and One PurchaseOrderHeader)

SELECT * FROM [AdventureWorks2022].[Purchasing].[PurchaseOrderHeader]
	WHERE YEAR(ShipDate) >= YEAR('2024-09-10');

SELECT * FROM [AdventureWorks2022].[Purchasing].[PurchaseOrderDetail]
	WHERE YEAR(DueDate) >= YEAR('2024-09-10');

DECLARE @IdToDelete INT;
SET @IdToDelete = 4024;

DELETE FROM [Purchasing].[PurchaseOrderDetail]
	WHERE PurchaseOrderID = @IdToDelete;

DELETE FROM [Purchasing].[PurchaseOrderHeader]
	WHERE PurchaseOrderID = @IdToDelete;

-- 2. Create new address for some person ([Person] BusinessEntiryAddress and Address)

SELECT * FROM [AdventureWorks2022].[Person].[Address]
	WHERE AddressLine1 = 'Foo Bar 4/3';

SELECT * FROM [AdventureWorks2022].[Person].[BusinessEntityAddress]
	WHERE BusinessEntityId = 4 AND AddressTypeID = 3;

DELETE FROM [Person].[BusinessEntityAddress]
	WHERE BusinessEntityID = 4 AND AddressTypeID = 3;

DELETE FROM [Person].[Address]
	WHERE AddressLine1 = 'Foo Bar 4/3';

-- 3. Remove credit card of some person ([Sales] PersonCreditCard and CreditCard)

SELECT * FROM [AdventureWorks2022].[Sales].[CreditCard]
WHERE CreditCardID = 81;

SELECT * FROM [AdventureWorks2022].[Sales].[PersonCreditCard]
WHERE CreditCardID = 81;

SELECT * FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE CreditCardID = 81;

SET IDENTITY_INSERT [Sales].[CreditCard] ON;

INSERT INTO [Sales].[CreditCard] (CreditCardID, CardType, CardNumber, ExpMonth, ExpYear, ModifiedDate)
	VALUES (81, 'Distinguish', 55557892934839, 6, 2007, '2012-11-17');

SET IDENTITY_INSERT [Sales].[CreditCard] OFF;

INSERT INTO [Sales].[PersonCreditCard] (BusinessEntityID, CreditCardID, ModifiedDate)
	VALUES (6959, 81, '2012-11-17');

UPDATE [Sales].[SalesOrderHeader] SET CreditCardId = 81
	WHERE SalesOrderID = 48601;

-- 4. Update order by adding new detail ([Purchasing] PurchaseOrderDetail and PurchaseOrderHeader)

SELECT * FROM [Purchasing].[PurchaseOrderDetail]
	WHERE PurchaseOrderID = 4;

SELECT * FROM [Purchasing].[PurchaseOrderHeader]
	WHERE PurchaseOrderID = 4;

DELETE FROM [Purchasing].[PurchaseOrderDetail]
	WHERE PurchaseOrderID = 4 AND DueDate = '2024-03-04';

UPDATE [Purchasing].[PurchaseOrderHeader] SET ShipMethodID = 5
	WHERE PurchaseOrderID = 4;

-- 5. Create new country and its regions ([Person] StateProvince and CountryRegion)

SELECT * FROM [Person].[CountryRegion]
	WHERE CountryRegionCode = 'SMS'

SELECT * FROM [Person].[StateProvince]
	WHERE CountryRegionCode = 'SMS'

DELETE FROM [Person].[StateProvince]
	WHERE CountryRegionCode = 'SMS'

DELETE FROM [Person].[CountryRegion]
	WHERE CountryRegionCode = 'SMS'

-- 6. Update person name and its email address ([Person] Person, EmailAddress)

SELECT * FROM [Person].[Person]
	WHERE BusinessEntityID = 1;

SELECT * FROM [Person].[EmailAddress]
	WHERE BusinessEntityID = 1 AND EmailAddressID = 1;

UPDATE [Person].[Person] SET FirstName = 'Ken'
	WHERE BusinessEntityID = 1;

UPDATE [Person].[EmailAddress] SET EmailAddress = 'ken0@adventure-works.com'
	WHERE BusinessEntityID = 1 AND EmailAddressID = 1;

-- 7. Remove order and its details ([Sales] SalesOrderHeader, SalesOrderDetail)

SELECT * FROM [Sales].[SalesOrderDetail]
	WHERE SalesOrderID = 43663;

SELECT * FROM [Sales].[SalesOrderHeader]
	WHERE SalesOrderID = 43663;

SET IDENTITY_INSERT [Sales].[SalesOrderHeader] ON;

INSERT INTO [Sales].[SalesOrderHeader] (SalesOrderID, RevisionNumber, OrderDate, DueDate, ShipDate, Status, OnlineOrderFlag, PurchaseOrderNumber, AccountNumber, CustomerID, SalesPersonID, TerritoryID, BillToAddressID, ShipToAddressID, ShipMethodID, CreditCardID, CreditCardApprovalCode, CurrencyRateID, SubTotal, TaxAmt, Freight, Comment, rowguid, ModifiedDate)
	VALUES (43663, 8, '2011-05-31', '2011-06-12', '2011-06-07', 5, 0, 'PO18009186470', '10-4020-000510', 29565, 276, 4, 1073, 1073, 5, 4322, '45303Vi22691', NULL, 419.4589, 40.2681, 12.5838, NULL, '9B1E7A40-6AE0-4AD3-811C-A64951857C4B', '2011-06-07');

SET IDENTITY_INSERT [Sales].[SalesOrderHeader] OFF;

SET IDENTITY_INSERT [Sales].[SalesOrderDetail] ON;

INSERT INTO [Sales].[SalesOrderDetail] (SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount, rowguid, ModifiedDate)
	VALUES (43663, 52, '1E90-4FBF-B6', 1, 760, 1, 419.4589, 0.00, 'BA432515-892B-445D-B9A7-97F593A24687', '2011-05-31');

SET IDENTITY_INSERT [Sales].[SalesOrderDetail] OFF;

-- 8. Delete one store and move its customers to other store ([Sales] Store and customer)

-- Creation of new BusinessEntity

--INSERT INTO [Person].[BusinessEntity] (rowguid, ModifiedDate)
--	VALUES (NEWID(), GETDATE());

--DECLARE @BusinessEntityID INT;
--	SET @BusinessEntityID = SCOPE_IDENTITY();

--SELECT * FROM [Person].[BusinessEntity]
--	WHERE BusinessEntityID = @BusinessEntityID;

-- Creation of new store with corresponding BusinessEntity

--SELECT * FROM [Person].[BusinessEntity]
--	WHERE BusinessEntityID = 20778;

--INSERT INTO [Sales].[Store] (BusinessEntityID, Name, SalesPersonID, Demographics)
--	VALUES(20778, 'Another store', 279, NULL);

SELECT * FROM [Sales].[Store]
WHERE BusinessEntityID = 20778;

SELECT * FROM [Sales].[Customer]
WHERE StoreID = 20778;

SELECT * FROM [Sales].[Store]
	WHERE BusinessEntityID = 340;

SELECT * FROM [Sales].[Customer]
	WHERE StoreID = 340;

INSERT INTO [Sales].[Store] (BusinessEntityID, Name, SalesPersonID, Demographics, rowguid, ModifiedDate)
	VALUES(340, 'eCommerce Bikes', 279, '<StoreSurvey xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"><AnnualSales>3000000</AnnualSales><AnnualRevenue>300000</AnnualRevenue><BankName>Guardian Bank</BankName><BusinessType>OS</BusinessType><YearOpened>1999</YearOpened><Specialty>Mountain</Specialty><SquareFeet>69000</SquareFeet><Brands>2</Brands><Internet>DSL</Internet><NumberEmployees>58</NumberEmployees></StoreSurvey>',
		'1EC47823-4B39-4609-AAEC-6EE68CC74F81', '2014-09-12 11:15:07.497');

UPDATE [Sales].[Customer] SET StoreID = 340
	WHERE StoreID = 20778;