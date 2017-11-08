UPDATE [DS_TRAINNING].[dbo].[WORK_CLIENTES]
SET [CustomerID] = REPLICATE('0', 7 - LEN([CustomerID])) + RTrim([CustomerID])