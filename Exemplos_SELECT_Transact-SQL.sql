-- 1 - Usando SELECT para recuperar linhas e colunas
-- Query que retorna somente as linhas de Product que têm uma linha de produto igual a R e que tenham dias para manufatura menores que 4.

	SELECT  Name, 
			ProductNumber,
			ProductLine,
			DaysToManufacture, 
			ListPrice AS Price
	FROM Production.Product 
	WHERE ProductLine = 'R' 
	  AND DaysToManufacture < 4
	ORDER BY Name ASC;
	GO
/*
Name                                               ProductNumber             ProductLine DaysToManufacture Price
-------------------------------------------------- ------------------------- ----------- ----------------- ---------------------
Headlights - Dual-Beam                             LT-H902                   R           0                 34,99
Headlights - Weatherproof                          LT-H903                   R           0                 44,99
HL Road Frame - Black, 44                          FR-R92B-44                R           1                 1431,50
HL Road Frame - Black, 48                          FR-R92B-48                R           1                 1431,50

...
Road Bottle Cage                                   BC-R205                   R           0                 8,99
Road Tire Tube                                     TT-R982                   R           0                 3,99
Taillights - Battery-Powered                       LT-T990                   R           0                 13,99

(57 rows affected)
*/


-- 2 - Usando SELECT com títulos de coluna e cálculos
-- Query retorna o total de vendas e os descontos para cada produto. 

	SELECT  p.Name AS ProductName, 
			NonDiscountSales = (OrderQty * UnitPrice),
			Discounts = ((OrderQty * UnitPrice) * UnitPriceDiscount)
	FROM Production.Product AS p 
	INNER JOIN Sales.SalesOrderDetail AS sod
		ON p.ProductID = sod.ProductID 
	ORDER BY ProductName DESC;
	GO
/*
ProductName                                        NonDiscountSales      Discounts
-------------------------------------------------- --------------------- ---------------------
Women's Tights, S                                  179,976               0,00
Women's Tights, S                                  359,952               0,00
Women's Tights, S                                  224,97                0,00
Women's Tights, S                                  89,988                0,00
Women's Tights, S                                  89,988                0,00
Women's Tights, S                                  179,976               0,00
Women's Tights, S                                  224,97                0,00
Women's Tights, S                                  89,988                0,00
Women's Tights, S                                  618,6675              30,9334
...
All-Purpose Bike Stand                             159,00                0,00
All-Purpose Bike Stand                             159,00                0,00
All-Purpose Bike Stand                             159,00                0,00

(121317 rows affected)
*/

-- Query retorna a receita total que é calculada para cada produto.
	SELECT  'A Reanda total é ', ((OrderQty * UnitPrice) * (1.0 - UnitPriceDiscount)), ' para ',
			p.Name AS ProductName 
	FROM Production.Product AS p 
	INNER JOIN Sales.SalesOrderDetail AS sod
		ON p.ProductID = sod.ProductID 
	ORDER BY ProductName ASC;
	GO
/*
                                                                ProductName
----------------- --------------------------------------- ------ --------------------------------------------------
A Reanda total é  159.000000                               para  All-Purpose Bike Stand
A Reanda total é  159.000000                               para  All-Purpose Bike Stand
A Reanda total é  159.000000                               para  All-Purpose Bike Stand

...
A Reanda total é  134.982000                               para  Women's Tights, S
A Reanda total é  224.970000                               para  Women's Tights, S

(121317 rows affected)
*/



-- 3 - Usando DISTINCT com SELECT
-- O exemplo a seguir usa DISTINCT para impedir a recuperação de títulos duplicados.

-- Exemplo Sem o DISTINCT 
	SELECT  JobTitle
	FROM HumanResources.Employee
	ORDER BY JobTitle;
	GO
/*
JobTitle
--------------------------------------------------
Accountant
Accountant
Accounts Manager
Accounts Payable Specialist
Accounts Payable Specialist
...
Vice President of Engineering
Vice President of Production
Vice President of Sales

(290 rows affected)

*/

-- Com o DISTINCT 
	SELECT DISTINCT JobTitle
	FROM HumanResources.Employee
	ORDER BY JobTitle;
	GO
/*
JobTitle
--------------------------------------------------
Accountant
Accounts Manager
Accounts Payable Specialist
Accounts Receivable Specialist
...
Tool Designer
Vice President of Engineering
Vice President of Production
Vice President of Sales

(67 rows affected)

*/


-- 4 - Criando tabelas com SELECT INTO
-- Cria uma tabela temporária denominada #Bicycles em tempdb.
	SELECT * 
	INTO #Bicycles
	FROM Production.Product
	WHERE ProductNumber LIKE 'BK%';
	GO

-- (97 rows affected)

	SELECT  ProductID,
			Name,                                               
			ProductNumber
	FROM #Bicycles
/*
ProductID   Name                                               ProductNumber
----------- -------------------------------------------------- -------------------------
749         Road-150 Red, 62                                   BK-R93R-62
750         Road-150 Red, 44                                   BK-R93R-44
751         Road-150 Red, 48                                   BK-R93R-48
...
998         Road-750 Black, 48                                 BK-R19B-48
999         Road-750 Black, 52                                 BK-R19B-52

(97 rows affected)
*/



-- 5 -Usando subconsultas correlacionadas
-- Query semanticamente equivalentes e ilustra a diferença entre o uso da palavra-chave EXISTS e da palavra-chave IN. Ambos são exemplos de uma subconsulta válida que recupera uma instância de cada nome de produto para o qual o modelo do produto é uma camisa de marca de manga longa e os números de ProductModelID são correspondentes entre as tabelas Product e ProductModel.

	SELECT DISTINCT Name
	FROM Production.Product AS p 
	WHERE EXISTS
		(SELECT *
		 FROM Production.ProductModel AS pm 
		 WHERE p.ProductModelID = pm.ProductModelID
			   AND pm.Name LIKE 'Long-Sleeve Logo Jersey%');
	GO
/*
Name
--------------------------------------------------
Long-Sleeve Logo Jersey, S
Long-Sleeve Logo Jersey, M
Long-Sleeve Logo Jersey, L
Long-Sleeve Logo Jersey, XL

(4 rows affected)
*/

-- OU

	SELECT DISTINCT Name
	FROM Production.Product
	WHERE ProductModelID IN
		(SELECT ProductModelID 
		 FROM Production.ProductModel
		 WHERE Name LIKE 'Long-Sleeve Logo Jersey%');
	GO
/*
Name
--------------------------------------------------
Long-Sleeve Logo Jersey, S
Long-Sleeve Logo Jersey, M
Long-Sleeve Logo Jersey, L
Long-Sleeve Logo Jersey, XL

(4 rows affected)
*/

-- Subconsulta correlata ou repetitiva. Trata-se de uma consulta que depende da consulta externa para obter seus valores. A consulta é executada repetidamente, uma vez para cada linha que pode ser selecionada pela consulta externa. Essa consulta recupera uma instância do nome e sobrenome de cada funcionário para os quais o bônus da tabela SalesPerson seja 5000.00 e para os quais existam números de identificação de funcionário correspondentes nas tabelas Employee e SalesPerson.
	SELECT DISTINCT 
				p.LastName, 
				p.FirstName 
	FROM Person.Person AS p 
	JOIN HumanResources.Employee AS e
		ON e.BusinessEntityID = p.BusinessEntityID WHERE 5000.00 IN
		(SELECT Bonus
		 FROM Sales.SalesPerson AS sp
		 WHERE e.BusinessEntityID = sp.BusinessEntityID);
	GO
/*
LastName                    FirstName
--------------------------- -------------------
Ansman-Wolfe                Pamela
Saraiva                     José

(2 rows affected)
*/


-- 6 - Usando GROUP BY
-- Localiza o total de cada ordem de vendas no banco de dados.
	SELECT  SalesOrderID, 
			SUM(LineTotal) AS SubTotal
	FROM Sales.SalesOrderDetail
	GROUP BY SalesOrderID
	ORDER BY SalesOrderID;
	GO
/*
SalesOrderID SubTotal
------------ ---------------------------------------
43659        20565.620600
43660        1294.252900
43661        32726.478600
...
75121        74.980000
75122        30.970000
75123        189.970000

(31465 rows affected)
*/


-- Localiza o preço médio e a soma das vendas do ano até a data atual, agrupadas por ID de produto e ID de oferta especial
	SELECT  ProductID, 
			SpecialOfferID, 
			AVG(UnitPrice) AS [Average Price], 
			SUM(LineTotal) AS SubTotal
	FROM Sales.SalesOrderDetail
	GROUP BY ProductID, SpecialOfferID
	ORDER BY ProductID;
	GO
/*
ProductID   SpecialOfferID Average Price         SubTotal
----------- -------------- --------------------- ---------------------------------------
707         11             15,7455               2971.175850
707         8              16,8221               2452.662180
707         3              18,9272               2191.058910
...
998         1              439,98                540097.998000
998         3              296,9945              24264.450650
999         2              527,3902              76871.032436
999         1              428,3185              438795.874000

(484 rows affected)
*/


-- Agrupa a tabela SalesOrderDetail por ID de produto e somente inclui os grupos de produtos que têm pedidos totalizando mais de $1000000.00 e cujas quantidades médias do pedido são inferiores a 3.

	SELECT  ProductID, 
			AVG(OrderQty) AS AverageQuantity, 
			SUM(LineTotal) AS Total
	FROM Sales.SalesOrderDetail
	GROUP BY ProductID
	HAVING  SUM(LineTotal) > $1000000.00
		AND AVG(OrderQty) < 3;
	GO
/*
ProductID   AverageQuantity Total
----------- --------------- ---------------------------------------
779         2               3693678.025272
793         2               2516857.314918
750         1               1340419.942000
...
798         2               1071291.781192
778         2               1234276.030375
790         2               1348759.497540

(38 rows affected)
*/


-- Produtos que tiveram vendas totais maiores que $2000000.00, use esta consulta:
	SELECT  ProductID, 
			Total = SUM(LineTotal)
	FROM Sales.SalesOrderDetail
	GROUP BY ProductID
	HAVING SUM(LineTotal) > $2000000.00;
	GO
/*
ProductID   Total
----------- ---------------------------------------
779         3693678.025272
793         2516857.314918
782         4400592.800400
780         3438478.860423
794         2347655.953454
783         4009494.761841
795         2012447.775000
781         3434256.941928
784         3309673.216908

(9 rows affected)
*/


-- 7 - Consulta UNION
-- Retorna todas as linhas da tabela, inclusive registros duplicados
SELECT country, region, city 
FROM HR.Employees

UNION ALL 

SELECT country, region, city 
FROM Sales.Customers;
/*
country         region          city
--------------- --------------- ---------------
USA             WA              Seattle
USA             WA              Tacoma
USA             WA              Kirkland
USA             WA              Redmond
UK              NULL            London
UK              NULL            London
UK              NULL            London
...
Brazil          SP              Resende
USA             WA              Seattle
Finland         NULL            Helsinki
Poland          NULL            Warszawa

(100 rows affected)
*/


--Retorna as linhas da tabela excluindo registros duplicados
SELECT country, region, city 
FROM HR.Employees

UNION 

SELECT country, region, city 
FROM Sales.Customers;
/*
country         region          city
--------------- --------------- ---------------
Argentina       NULL            Buenos Aires
Austria         NULL            Graz
Austria         NULL            Salzburg
Belgium         NULL            Bruxelles
Belgium         NULL            Charleroi
...
USA             WY              Lander
Venezuela       DF              Caracas
Venezuela       Lara            Barquisimeto
Venezuela       Nueva Esparta   I. de Margarita
Venezuela       Táchira         San Cristóbal

(71 rows affected)
*/