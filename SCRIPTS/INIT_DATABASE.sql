/*
PURPOSE:
    This script initializes the DATAWAREHOUSE environment.
    It checks whether the database already exists and recreates it
    to ensure a clean and consistent setup for development.

    The database follows a layered schema approach to organize
    data at different processing stages:
        - BRONZE : Raw ingested data
        - SILVER : Cleaned and transformed data
        - GOLD   : Analytics-ready data

IMPORTANT:
    Executing this script will permanently remove the existing
    DATAWAREHOUSE database along with all stored data.
*/



USE master;
Go

-- DROP AND RECREATE THE 'DATAWAREHOUSE' DATABASE

IF EXISTS (SELECT 1 FROM sys.databases where name = 'DataWarehouse')
BEGIN 
     ALTER DATABASE DATAWAREHOUSE SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	 DROP DATABASE DATAWAREHOUSE;
END;
GO

-- CREATE THE 'DATAWAREHOUSE' DATABASE

CREATE DATABASE DATAWAREHOUSE;
Go

USE DATAWAREHOUSE;
GO

-- CREATE SCHEMAS
CREATE SCHEMA Bronze;
GO

CREATE SCHEMA Silver;
Go

CREATE SCHEMA Gold;
Go
