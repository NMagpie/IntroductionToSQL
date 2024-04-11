USE AdventureWorks2022;

-- 1. Create new order ([Purchasing] One or more PurcahseOrderDetail and One PurchaseOrderHeader)

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN TRANSACTION

BEGIN TRY

INSERT INTO [Purchasing].[PurchaseOrderHeader] (RevisionNumber, [Status], EmployeeID, VendorID, ShipMethodID, OrderDate, ShipDate)
VALUES (4, 4, 251, 1580, 2, '2024-08-11', '2024-09-10');

DECLARE @FirstTaskId INT;
SET @FirstTaskId = SCOPE_IDENTITY();

INSERT INTO [Purchasing].[PurchaseOrderDetail] (PurchaseOrderID, DueDate, OrderQty, ProductID, UnitPrice, ReceivedQty, RejectedQty)
VALUES (@FirstTaskId, '2024-10-10', 2, 1, 500, 3, 0);

INSERT INTO [Purchasing].[PurchaseOrderDetail] (PurchaseOrderID, DueDate, OrderQty, ProductID, UnitPrice, ReceivedQty, RejectedQty)
VALUES (@FirstTaskId, '2024-10-10', 1, 2, 499, 5, 0);

COMMIT TRANSACTION;
END TRY

BEGIN CATCH
	ROLLBACK TRANSACTION;

	SELECT ERROR_MESSAGE();
END CATCH


-- 2. Create new address for person with Id = 4 ([Person] BusinessEntityAddress and Address)

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN TRANSACTION

BEGIN TRY

INSERT INTO [Person].[Address] (AddressLine1, City, StateProvinceID, PostalCode)
VALUES ('Foo Bar 4/3', 'Cirodyl', 4, '228-1337');

DECLARE @SecondTaskId INT;
SET @SecondTaskId = SCOPE_IDENTITY();

INSERT INTO [Person].[BusinessEntityAddress] (BusinessEntityID, AddressID, AddressTypeID)
VALUES (4, @SecondTaskId, 3);

COMMIT TRANSACTION;
END TRY

BEGIN CATCH
	ROLLBACK TRANSACTION;

	SELECT ERROR_MESSAGE();
END CATCH

-- 3. Remove credit card of some person ([Sales] PersonCreditCard and CreditCard, and maybe SalesOrderHeader)

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN TRANSACTION

BEGIN TRY

DELETE FROM [Sales].[PersonCreditCard]
	WHERE CreditCardID = 81;

UPDATE [Sales].[SalesOrderHeader] SET CreditCardID = NULL
	WHERE CreditCardID = 81;

DELETE FROM [Sales].[CreditCard]
	WHERE CreditCardID = 81;

COMMIT TRANSACTION;
END TRY

BEGIN CATCH
	ROLLBACK TRANSACTION;

	SELECT ERROR_MESSAGE();
END CATCH

-- 4. Update order by adding new detail and updating ShipMethodID ([Purchasing] PurchaseOrderDetail and PurchaseOrderHeader)

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN TRANSACTION

BEGIN TRY

INSERT INTO [Purchasing].[PurchaseOrderDetail] (PurchaseOrderID, DueDate, OrderQty, ProductID, UnitPrice, ReceivedQty, RejectedQty)
	VALUES (4, '2024-03-04', 3, 1, 55, 5, 0);

-- For example, the product cannot be shipped via previous Shipment method. Thus, there's need to update it.

UPDATE [Purchasing].[PurchaseOrderHeader] SET ShipMethodID = 4
	WHERE PurchaseOrderID = 4;

COMMIT TRANSACTION;
END TRY

BEGIN CATCH
	ROLLBACK TRANSACTION;

	SELECT ERROR_MESSAGE();
END CATCH

-- 5. Create new country and its regions ([Person] StateProvince and CountryRegion)

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN TRANSACTION

BEGIN TRY

INSERT INTO [Person].[CountryRegion] (CountryRegionCode, [Name])
	VALUES ('SMS', 'Summerset');

INSERT INTO [Person].[StateProvince] (StateProvinceCode, CountryRegionCode, IsOnlyStateProvinceFlag, Name, TerritoryID)
	VALUES('AL', 'SMS', 0, 'Alinor', 7),
	('AU', 'SMS', 0, 'Auridon', 7);

COMMIT TRANSACTION;
END TRY

BEGIN CATCH
	ROLLBACK TRANSACTION;

	SELECT ERROR_MESSAGE();
END CATCH

-- 6. Update person name and its email address ([Person] Person, EmailAddress)

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN TRANSACTION

BEGIN TRY

UPDATE [Person].[Person] SET FirstName = 'Ivan'
	WHERE BusinessEntityID = 1;

UPDATE [Person].[EmailAddress] SET EmailAddress = 'ivan0@adventure-works.com'
	WHERE BusinessEntityID = 1 AND EmailAddressID = 1;

COMMIT TRANSACTION;
END TRY

BEGIN CATCH
	ROLLBACK TRANSACTION;

	SELECT ERROR_MESSAGE();
END CATCH

-- 7. Remove order and its details ([Sales] SalesOrderHeader, SalesOrderDetail)

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN TRANSACTION

BEGIN TRY

DELETE FROM [Sales].[SalesOrderDetail]
	WHERE SalesOrderID = 43663;

DELETE FROM [Sales].[SalesOrderHeader]
	WHERE SalesOrderID = 43663;

COMMIT TRANSACTION;
END TRY

BEGIN CATCH
	ROLLBACK TRANSACTION;

	SELECT ERROR_MESSAGE();
END CATCH

-- 8. Remove one store and move its customers to other store ([Sales] Store and customer)

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN TRANSACTION

BEGIN TRY

UPDATE [Sales].[Customer] SET StoreID = 20778
	WHERE StoreID = 340;

DELETE FROM [Sales].[Store]
	WHERE BusinessEntityID = 340;

COMMIT TRANSACTION;
END TRY

BEGIN CATCH
	ROLLBACK TRANSACTION;

	SELECT ERROR_MESSAGE();
END CATCH