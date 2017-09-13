USE TSQL;
GO

GO
DROP TABLE DESTINO; 
GO

CREATE TABLE DESTINO 
(
		COD_PRODUTO_DEST		INT PRIMARY KEY,
		NOME_PRODUTO_DEST		VARCHAR(50),
		PRECO_PRODUTO_DEST		DEC (9,2)
);

ALTER TABLE DESTINO 
ADD  UP VARCHAR(10);

DROP TABLE FONTE
CREATE TABLE FONTE 
(
		COD_PRODUTO_FONTE		INT PRIMARY KEY IDENTITY(1,1),
		NOME_PRODUTO_FONTE		VARCHAR(50),
		PRECO_PRODUTO_FONTE		DEC (9,2)
);

/*
INSERT INTO FONTE (NOME_PRODUTO_FONTE, PRECO_PRODUTO_FONTE)
	SELECT TOP 10 productname, unitprice FROM Production.Products

INSERT INTO DESTINO (COD_PRODUTO_DEST, NOME_PRODUTO_DEST, PRECO_PRODUTO_DEST)
	SELECT TOP 2 productid, productname, unitprice FROM Production.Products
*/

SELECT * 
FROM FONTE
--UPDATE FONTE SET PRECO_PRODUTO_FONTE = PRECO_PRODUTO_FONTE / 2.09

SELECT * 
FROM DESTINO
--TRUNCATE TABLE DESTINO

SELECT * 
FROM FONTE F
JOIN DESTINO D
ON F.COD_PRODUTO_FONTE = D.COD_PRODUTO_DEST

SET IDENTITY_INSERT FONTE ON

MERGE  
	INTO DESTINO AS D USING FONTE AS F
			ON	(D.COD_PRODUTO_DEST = F.COD_PRODUTO_FONTE)
	WHEN MATCHED THEN 
		UPDATE 
			SET D.COD_PRODUTO_DEST = F.COD_PRODUTO_FONTE,
				D.NOME_PRODUTO_DEST = F.NOME_PRODUTO_FONTE,
				D.PRECO_PRODUTO_DEST = F.PRECO_PRODUTO_FONTE,
				D.UP = 'Update'
	WHEN  NOT MATCHED THEN 
		INSERT
			VALUES(F.COD_PRODUTO_FONTE, F.NOME_PRODUTO_FONTE, F.PRECO_PRODUTO_FONTE,'Insert');
--OUTPUT $Action, INSERTED.*, DELETED.*;