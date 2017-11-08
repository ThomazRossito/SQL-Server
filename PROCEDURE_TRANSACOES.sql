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

/****** Object:  StoredProcedure [dbo].[SP_WORK_TRANSACOES]    Script Date: 2017-11-07 10:46:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =========================================================
-- Author:		THOMAZ ANTONIO ROSSITO NETO
-- Create date: 20171107
-- Description:	PROCEDURE QUE CRIA A TABELA WORK TRANSACOES
-- =========================================================


CREATE OR ALTER PROCEDURE [dbo].[SP_WORK_TRANSACOES]
AS
BEGIN

-- =========================================================
-- FINALIDADE: VERIFICAR SE A TABELA EXISTE E DROPAR
-- =========================================================

IF OBJECT_ID('WORK_TRANSACOES') IS NOT NULL
	DROP TABLE [dbo].[WORK_TRANSACOES]


-- =========================================================
-- FINALIDADE: CRIAÇÃO DA TABELA
-- =========================================================

CREATE TABLE WORK_TRANSACOES
(
	[RowNumber]			INT IDENTITY(1,1),
	[OrderID]			VARCHAR(100),
	[OrderDate]			DATE,
	[CustomerID]		VARCHAR(100),
    [Region]			VARCHAR(100),
    [Rep]				VARCHAR(100),
    [Item]				VARCHAR(100),
    [Units]				NUMERIC,
    [UnitPrice]			FLOAT
)

-- =========================================================
-- FINALIDADE: TRUNCATE TABLE
-- =========================================================

TRUNCATE TABLE [dbo].[WORK_TRANSACOES]

-- =========================================================
-- FINALIDADE: INSERÇÃO DOS DADOS
-- =========================================================

INSERT INTO [dbo].[WORK_TRANSACOES]
(
 	   [OrderID]
      ,[OrderDate]
      ,[CustomerID]
      ,[Region]
      ,[Rep]
      ,[Item]
      ,[Units]
      ,[UnitPrice]
)
SELECT [Order ID]
      ,[Order Date]
      ,[Customer ID]
      ,[Region]
      ,[Rep]
      ,[Item]
      ,[Units]
      ,[Unit Price]
  FROM [DS_TRAINNING].[dbo].[RAW_Transacoes_20171107]
END
GO