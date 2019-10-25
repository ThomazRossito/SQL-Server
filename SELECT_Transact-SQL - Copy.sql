-- SELECT (Transact-SQL)

/*
Recupera linhas do banco de dados e permite a seleção de uma ou várias linhas ou colunas de uma ou várias tabelas no SQL Server.

A cláusula SELECT especifica as colunas da (s) tabela (s) de origem ou visualizações que deseja retornar como o conjunto de resultados da consulta. Além das colunas da tabela de origem, você pode adicionar outras na forma de expressões calculadas.

A cláusula FROM especifica o nome da tabela ou view que é a fonte das colunas na cláusula SELECT. Para evitar erros na tabela ou view, é melhor incluir o nome do esquema e do objeto, no formato SCHEMA.OBJECT por exemplo: Sales.Customer.

Exibição de Colunas

Para exibir colunas em uma consulta, você precisa criar uma lista de colunas delimitadas por vírgulas. A ordem das colunas em sua lista determinará sua exibição na saída.
O SQL Server aceita o uso do (*) para retornar todas as colunas, porem por boas práticas é utilizado especificar as colunas 
*/

--	•	Não é uma boa prática 

	SELECT * 
	FROM Sales.Customers

--	•	Boa prática, especificando o uso das colunas

	SELECT companyname, country 
	FROM Sales.Customers

/*
Usando colunas calculadas na clausula Select

Além de recuperar colunas armazenadas na tabela de origem, uma instrução SELECT pode executar cálculos e manipulações. 
Cálculos e manipulações podem alterar os dados da coluna de origem e usar funções T-SQL incorporadas.

Como os resultados aparecerão em uma nova coluna, repetidos uma vez por linha do conjunto de resultados, 
as expressões calculadas em uma cláusula SELECT devem ser escalares. Devem retornar apenas um único valor.
*/

SELECT unitprice, qty, (unitprice * qty) 
FROM Sales.OrderDetails;

/*
unitprice             qty    
--------------------- ------ ---------------------
14,00                 12     168,00
9,80                  10     98,00
34,80                 5      174,00
18,60                 9      167,40
42,40                 40     1696,00
7,70                  10     77,00
42,40                 35     1484,00
16,80                 15     252,00
...
15,00                 2      30,00
7,75                  4      31,00
13,00                 2      26,00

(2155 rows affected)
*/


-- Mais um exemplo com função na coluna calculada

SELECT empid, lastname, hiredate, YEAR(hiredate) 
FROM HR.Employees;

/*
empid       lastname             hiredate                
----------- -------------------- -----------------------   -----------
1           Davis                2002-05-01 00:00:00.000   2002
2           Funk                 2002-08-14 00:00:00.000   2002
3           Lew                  2002-04-01 00:00:00.000   2002
4           Peled                2003-05-03 00:00:00.000   2003
5           Buck                 2003-10-17 00:00:00.000   2003
6           Suurs                2003-10-17 00:00:00.000   2003
7           King                 2004-01-02 00:00:00.000   2004
8           Cameron              2004-03-05 00:00:00.000   2004
9           Dolgopyatova         2004-11-15 00:00:00.000   2004

(9 rows affected)
*/

