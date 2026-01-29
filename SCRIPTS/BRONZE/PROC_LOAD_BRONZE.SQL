/*
============================================================
STORED PROCEDURE: LOAD BRONZE DATA (SOURCE → BRONZE)
============================================================

OVERVIEW:
    This stored procedure is responsible for loading raw data into the BRONZE layer from external CSV source files.

    It is designed as the first step in the data pipeline, ensuring that the BRONZE layer always contains a fresh and consistent snapshot of source data.

PROCESS DETAILS:
    - Clears existing data from all BRONZE tables
    - Loads data from CSV files using BULK INSERT
    - No transformations or validations are applied at this stage

PARAMETERS:
    This procedure does not accept input parameters and does not return any values.

USAGE:
    EXEC bronze.load_bronze;
============================================================
*/


CREATE OR ALTER PROCEDURE [Bronze].[LOAD_BRONZE] AS
BEGIN
        DECLARE @START_TIME DATETIME, @END_TIME DATETIME, @BATCHSTARTTIME DATETIME, @BATCHENDTIME DATETIME
		BEGIN TRY
		SET @BATCHSTARTTIME = GETDATE();
						PRINT'=========================================='
						PRINT 'LOADING BRONZE LAYER'
						PRINT'=========================================='

						PRINT'-------------------------------------------'
						PRINT ' LOADING CRM TABLES'
						PRINT'-------------------------------------------'
						SET @START_TIME = GETDATE();
						PRINT 'TRUNCATING TABLE: [BRONZE].[CRM_CUST_INFO]';
						TRUNCATE TABLE [BRONZE].[CRM_CUST_INFO];

						PRINT 'INSERTING INTO: [BRONZE].[CRM_CUST_INFO]';
						BULK INSERT [BRONZE].[CRM_CUST_INFO]
						FROM 'C:\Users\gurra\OneDrive\Desktop\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
						with (
							FIRSTROW = 2,
							FIELDTERMINATOR = ',',
							TABLOCK
						);

						SET @END_TIME = GETDATE();
						PRINT ' -- LOAD DURATION:' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + 'SECONDS';
						PRINT '------------------'

				        SET @START_TIME = GETDATE();
						PRINT 'TRUNCATING TABLE: [BRONZE].[CRM_PROD_INFO]';
						TRUNCATE TABLE [BRONZE].[CRM_PROD_INFO];

						PRINT 'INSERTING INTO: [BRONZE].[CRM_PROD_INFO]';
						BULK INSERT [Bronze].[CRM_PROD_INFO]
						FROM 'C:\Users\gurra\OneDrive\Desktop\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
						with (
							FIRSTROW = 2,
							FIELDTERMINATOR = ',',
							TABLOCK
						);
						SET @END_TIME = GETDATE();
						PRINT ' -- LOAD DURATION:' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + 'SECONDS';
						PRINT '------------------'


						SET @START_TIME = GETDATE();
						PRINT 'TRUNCATING TABLE: [BRONZE].[CRM_SALES_DETAILS]';
						TRUNCATE TABLE [BRONZE].CRM_SALES_DETAILS;

						PRINT 'INSERTING INTO: [BRONZE].[CRM_SALES_DETAILS]';
						BULK INSERT [Bronze].[CRM_SALES_DETAILS]
						FROM 'C:\Users\gurra\OneDrive\Desktop\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
						with (
							FIRSTROW = 2,
							FIELDTERMINATOR = ',',
							TABLOCK
						);
						SET @END_TIME = GETDATE();
						PRINT ' -- LOAD DURATION:' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + 'SECONDS';
						PRINT '------------------';

						PRINT'-------------------------------------------';
						PRINT ' LOADING ERP TABLES';
						PRINT'-------------------------------------------';

						SET @START_TIME = GETDATE();
						PRINT 'TRUNCATING TABLE: [Bronze].[ERP_CUST_AZ12]';
						TRUNCATE TABLE [Bronze].[ERP_CUST_AZ12];

						PRINT 'INSERTING INTO: [Bronze].[ERP_CUST_AZ12]';
						BULK INSERT [Bronze].[ERP_CUST_AZ12]
						FROM 'C:\Users\gurra\OneDrive\Desktop\SQL\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
						with (
							FIRSTROW = 2,
							FIELDTERMINATOR = ',',
							TABLOCK
						);
						SET @END_TIME = GETDATE();
						PRINT ' -- LOAD DURATION:' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + 'SECONDS';
						PRINT '------------------';


						SET @START_TIME = GETDATE();
						PRINT 'TRUNCATING TABLE: [BRONZE].[ERP_LOC_A101]';
						TRUNCATE TABLE [BRONZE].[ERP_LOC_A101];

						PRINT 'INSERTING INTO: [BRONZE].[ERP_LOC_A101]';
						BULK INSERT [Bronze].[ERP_LOC_A101]
						FROM 'C:\Users\gurra\OneDrive\Desktop\SQL\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
						with (
							FIRSTROW = 2,
							FIELDTERMINATOR = ',',
							TABLOCK
						);
						SET @END_TIME = GETDATE();
						PRINT ' -- LOAD DURATION:' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + 'SECONDS';
						PRINT '------------------';


						SET @START_TIME = GETDATE();
						PRINT 'TRUNCATING TABLE: [BRONZE].[ERP_PX_CAT_G1V2]';
						TRUNCATE TABLE [BRONZE].[ERP_PX_CAT_G1V2];

						PRINT 'INSERTING INTO: [BRONZE].[ERP_PX_CAT_G1V2]';
						BULK INSERT[Bronze].[ERP_PX_CAT_G1V2]
						FROM 'C:\Users\gurra\OneDrive\Desktop\SQL\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
						with (
							FIRSTROW = 2,
							FIELDTERMINATOR = ',',
							TABLOCK
						);
						SET @END_TIME = GETDATE();
						PRINT ' -- LOAD DURATION:' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + 'SECONDS';
						PRINT '------------------';
		SET @BATCHENDTIME = GETDATE();
		PRINT'===================================';
		PRINT 'LOADING BRONZE LAYER IS COMPLETED'
		PRINT ' --TOTAL TIME DURATION: ' + CAST(DATEDIFF(SECOND, @BATCHSTARTTIME, @BATCHENDTIME) AS NVARCHAR) + 'SECONDS';
		PRINT'===================================';
		END TRY
		BEGIN CATCH
		     PRINT'==========================================='
			 PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
			 PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
			 PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS  NVARCHAR(MAX));
			 PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR(MAX));
			 PRINT'==========================================='
		END CATCH
END
GO



