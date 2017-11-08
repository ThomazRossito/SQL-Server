/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2017 (14.0.1000)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/

USE [DS_TRAINNING]
GO
/****** Object:  StoredProcedure [dbo].[SP_DRV_CLIENTESTRANSACOES]    Script Date: 2017-11-08 3:32:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ===============================================================================
-- Author:		THOMAZ ANTONIO ROSSITO NETO
-- Create date: 20171108
-- Description:	PROCEDURE QUE CRIA A TABELA SP_DRV_CLIENTESTRANSACOES
-- ===============================================================================


ALTER PROCEDURE [dbo].[SP_DRV_CLIENTESTRANSACOES]
AS
BEGIN

-- =========================================================
-- FINALIDADE: VERIFICAR SE A TABELA EXISTE E DROPAR
-- =========================================================

IF OBJECT_ID('DRV_CLIENTESTRANSACOES') IS NOT NULL
	DROP TABLE [dbo].[DRV_CLIENTESTRANSACOES]


-- =========================================================
-- FINALIDADE: CRIAÇÃO DA TABELA
-- =========================================================

CREATE TABLE DRV_CLIENTESTRANSACOES
(
	[RowNumber]			INT IDENTITY(1,1),
	CustomerID			VARCHAR(100), 
	City				VARCHAR(100), 
	ZipCode				VARCHAR(10), 
	Gender				CHAR(1), 
	Age					FLOAT, 
	OrderID				VARCHAR(100), 
    OrderDate			DATE, 
	Region				VARCHAR(100), 
	Rep					VARCHAR(100), 
	Item				VARCHAR(100), 
	Units				NUMERIC, 
	UnitPrice			FLOAT
)

-- =========================================================
-- FINALIDADE: TRUNCATE TABLE
-- =========================================================

TRUNCATE TABLE [dbo].[DRV_CLIENTESTRANSACOES]

-- =========================================================
-- FINALIDADE: INSERÇÃO DOS DADOS
-- =========================================================

INSERT INTO [dbo].[DRV_CLIENTESTRANSACOES]
(
		CustomerID,	
		City,	
		ZipCode,	
		Gender,	
		Age,	
		OrderID,	
		OrderDate,	
		Region,	
		Rep,	
		Item,	
		Units,	
		UnitPrice
)
SELECT 
		dbo.WORK_CLIENTES.CustomerID, 
		dbo.WORK_CLIENTES.City, 
		dbo.WORK_CLIENTES.ZipCode, 
		dbo.WORK_CLIENTES.Gender, 
		dbo.WORK_CLIENTES.Age, 
		dbo.WORK_TRANSACOES.OrderID, 
        dbo.WORK_TRANSACOES.OrderDate, 
		dbo.WORK_TRANSACOES.Region, 
		dbo.WORK_TRANSACOES.Rep, 
		dbo.WORK_TRANSACOES.Item, 
		dbo.WORK_TRANSACOES.Units, 
		dbo.WORK_TRANSACOES.UnitPrice
FROM 
	dbo.WORK_CLIENTES INNER JOIN dbo.WORK_TRANSACOES 
		ON dbo.WORK_CLIENTES.CustomerID = dbo.WORK_TRANSACOES.CustomerID
END
