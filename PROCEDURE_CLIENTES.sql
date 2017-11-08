SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

USE DS_TRAINNING
GO

-- =========================================================
-- Author:		THOMAZ ANTONIO ROSSITO NETO
-- Create date: 20171107
-- Description:	PROCEDURE QUE CRIA A TABELA WORK CLIENTES
-- =========================================================


CREATE OR ALTER PROCEDURE SP_WORK_CLIENTES
AS
BEGIN

-- =========================================================
-- FINALIDADE: VERIFICAR SE A TABELA EXISTE E DROPAR
-- =========================================================

IF OBJECT_ID('WORK_CLIENTES') IS NOT NULL
	DROP TABLE [dbo].[WORK_CLIENTES]


-- =========================================================
-- FINALIDADE: CRIAÇÃO DA TABELA
-- =========================================================

CREATE TABLE WORK_CLIENTES
(
	[RowNumber]		INT IDENTITY(1,1),
	[CustomerID]		VARCHAR(100),
  	[City]			VARCHAR(100),
    	[ZipCode]		VARCHAR(10),
    	[Gender]		CHAR(1),
    	[Age]			FLOAT
)

-- =========================================================
-- FINALIDADE: TRUNCATE TABLE
-- =========================================================

TRUNCATE TABLE [dbo].[WORK_CLIENTES]

-- =========================================================
-- FINALIDADE: INSERÇÃO DOS DADOS
-- =========================================================

INSERT INTO [dbo].[WORK_CLIENTES]
(
 	 [CustomerID]
	,[City]
	,[ZipCode]
	,[Gender]
	,[Age]
)
SELECT [Customer ID]
      ,[City]
      ,[ZipCode]
      ,[Gender]
      ,[Age]
  FROM [DS_TRAINNING].[dbo].[RAW_Clientes_20171107]
END
GO

-- =========================================================
-- (43 linhas afetadas)
-- =========================================================
