-- ACUMULADO POR ANO
SELECT
	YEAR(o.orderdate) as orderyear, 
	SUM(d.qty * d.unitprice) AS totalsales,
	(
		SELECT SUM(d2.qty * d2.unitprice)
		FROM Sales.Orders AS o2
		INNER JOIN Sales.OrderDetails AS d2 
			ON d2.orderid = o2.orderid
		WHERE YEAR(o2.orderdate) <= YEAR(o.orderdate)
	) AS runsales
FROM Sales.Orders AS o
INNER JOIN Sales.OrderDetails AS d 
	ON d.orderid = o.orderid
GROUP BY YEAR(o.orderdate)
ORDER BY orderyear;