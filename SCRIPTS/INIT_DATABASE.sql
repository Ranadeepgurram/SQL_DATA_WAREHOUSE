/*
============================================================
Create Database and Schemas
============================================================

Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists.
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
    within the database: 'bronze', 'silver', and 'gold'.

WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists.
    All data in the database will be permanently deleted. Proceed with caution
    and ensure weu have proper backups before running this script.
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
