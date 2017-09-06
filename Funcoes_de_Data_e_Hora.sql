
Funções de Data e Hora no SQL Server 


-- Retornar a Data e Hora do sistema 
SELECT
	GETDATE()			AS [GetDate],
	CURRENT_TIMESTAMP	AS [Current_Timestamp], -- ANSI 
	GETUTCDATE()		AS [GetUTCDate],
	SYSDATETIME()		AS [SYSDateTime],
	SYSUTCDATETIME()	AS [SYSUTCDateTime],
	SYSDATETIMEOFFSET()	AS [SYSDateTimeOffset];
	

-- SYSDATETIME e SYSUTCDATETIME têm mais precisão de segundos fracionados do que GETDATE e GETUTCDATE. 
-- SYSDATETIMEOFFSET inclui o deslocamento do fuso horário do sistema. 
-- SYSDATETIME, SYSUTCDATETIME e SYSDATETIMEOFFSET podem ser atribuídos a uma variável de qualquer tipo de data e hora.



SELECT DATENAME(weekday,CURRENT_TIMESTAMP) AS 'NOME DO DIA ATUAL', 
	   DAY(CURRENT_TIMESTAMP) AS 'DIA ATUAL',
	   MONTH(CURRENT_TIMESTAMP) AS 'MÊS ATUAL',
	   YEAR(CURRENT_TIMESTAMP) AS 'ANO ATUAL',
	   DATEPART(WEEKDAY,CURRENT_TIMESTAMP) AS 'DIA DA SEMANA',
	   DATEPART(WEEK,CURRENT_TIMESTAMP)AS 'TOTAL DE SEMANAS ATÉ DATA ATUAL';

	

-- Retorna um datetime valor da data e hora especificada
-- sintaxy = DATETIMEFROMPARTS ( year, month, day, hour, minute, seconds, milliseconds )  
SELECT DATETIMEFROMPARTS(2012,2,12,8,30,0,0) AS Result; --7 arguments
SELECT DATETIME2FROMPARTS(2012,2,12,8,30,00,0,0) AS Result; -- 8 arguments
SELECT DATEFROMPARTS(2012,2,12) AS Result; -- 3 arguments
SELECT DATETIMEOFFSETFROMPARTS(2012,2,12,8,30,0,0,-7,0,0) AS Result;  -- 10 arguments



-- Demonstrar DATEDIFF
SELECT  DATEDIFF(millisecond, GETDATE(), SYSDATETIME()) AS 'diferença de precisão',
		DATEDIFF(DD, '20170101', GETDATE()) AS 'Diferença em dias do início do ano até data atual',
		DATEDIFF(MM, '20170101', GETUTCDATE()) AS 'Diferença em meses do início do ano até data atual',
		DATEDIFF(YYYY, '20100101',GETUTCDATE()) AS 'Diferença em meses do início do ano até data atual';  


-- Modificar data-hora com EOMONTH e DATEADD:
SELECT  DATEADD(day,-2,CURRENT_TIMESTAMP) AS '2 dias a mais da data atual', 
		EOMONTH(GETDATE()) AS 'Retornar o final do mês referente a data atual',
		EOMONTH(SYSDATETIME(),2) AS 'Retornar o final de dois meses após a data atual';



-- Função ISDATE 
SELECT  ISDATE('20170904') AS 'Data valida', 
		ISDATE('20170230') AS 'Fevereiro não existe dia 30'; 



-- Função PARSE 
SELECT PARSE('05/09/2017' AS DATETIME2 USING 'en-US') AS 'us - data e tempo',
	   PARSE('05/09/2017' AS DATE USING 'en-US') AS 'us - data';

SELECT  PARSE('Saturday, 08 June 2013' AS DATETIME) AS 'Saturday' ,
		PARSE('Sat, 08 June 2013' AS DATETIME) AS 'Sat';

 

-- Utilizando Linguagem diferente
set nocount on
DECLARE @Hoje DATETIME
SET @Hoje = SYSDATETIME()

SET LANGUAGE brazilian
SELECT DATENAME(dw, @Hoje-1) AS 'Ontem', DATENAME(dw, @Hoje) AS 'Hoje', DATENAME(dw, @Hoje+1) AS 'Amanhã'
SELECT DATEPART(dw, @Hoje-1) AS 'Ontem', DATEPART(dw, @Hoje) AS 'Hoje', DATEPART(dw, @Hoje+1) AS 'Amanhã'

SET LANGUAGE us_english
SELECT DATENAME(dw, @Hoje-1) AS 'Yesterday', DATENAME(dw, @Hoje) AS 'Today', DATENAME(dw, @Hoje+1) AS 'Tomorrow'
SELECT DATEPART(dw, @Hoje-1) AS 'Yesterday', DATEPART(dw, @Hoje) AS 'Today', DATEPART(dw, @Hoje+1) AS 'Tomorrow'
GO



-- SYSDATETIME e SYSUTCDATETIME têm mais precisão de segundos fracionados do que GETDATE e GETUTCDATE. 
-- SYSDATETIMEOFFSET inclui o deslocamento do fuso horário do sistema. 
-- SYSDATETIME, SYSUTCDATETIME e SYSDATETIMEOFFSET podem ser atribuídos a uma variável de qualquer tipo de data e hora.


-- Função CONVERT 

-- Retornando somente a Data atual do sistema
SELECT	CONVERT (date, SYSDATETIME()) AS 'SYSDATETIME',  
		CONVERT (date, SYSDATETIMEOFFSET()) AS 'SYSDATETIMEOFFSET',  
		CONVERT (date, SYSUTCDATETIME()) AS 'SYSUTCDATETIME',  
		CONVERT (date, CURRENT_TIMESTAMP) AS 'CURRENT_TIMESTAMP',  
		CONVERT (date, GETDATE()) AS 'GETDATE',  
		CONVERT (date, GETUTCDATE()) AS 'GETUTCDATE'; 


-- Retornando somente o Tempo do Sistema
SELECT  CONVERT (time, SYSDATETIME()) AS 'SYSDATETIME',  
		CONVERT (time, SYSDATETIMEOFFSET()) AS 'SYSDATETIMEOFFSET',  
		CONVERT (time, SYSUTCDATETIME()) AS 'SYSUTCDATETIME',  
		CONVERT (time, CURRENT_TIMESTAMP) AS 'CURRENT_TIMESTAMP',  
		CONVERT (time, GETDATE()) AS 'GETDATE',  
		CONVERT (time, GETUTCDATE()) AS 'GETUTCDATE';  


-- Função CAST

-- Retornando somente a Data atual do sistema
SELECT	CAST (SYSDATETIME() AS DATE) AS 'SYSDATETIME',  
		CAST (SYSDATETIMEOFFSET() AS DATE) AS 'SYSDATETIMEOFFSET',  
		CAST (SYSUTCDATETIME() AS DATE) 'SYSUTCDATETIME',  
		CAST (CURRENT_TIMESTAMP AS DATE) AS 'CURRENT_TIMESTAMP',  
		CAST (GETDATE() AS DATE) AS 'CURRENT_TIMESTAMP',  
		CAST (GETUTCDATE() AS DATE) AS 'GETUTCDATE'; 


-- Retornando somente o Tempo atual do Sistema
SELECT  CAST (SYSDATETIME() AS TIME) AS 'SYSDATETIME',  
		CAST (SYSDATETIMEOFFSET()AS TIME) AS 'SYSDATETIMEOFFSET',  
		CAST (SYSUTCDATETIME()AS TIME) AS 'SYSUTCDATETIME',  
		CAST (CURRENT_TIMESTAMP AS TIME) AS 'CURRENT_TIMESTAMP',  
		CAST (GETDATE() AS TIME) AS 'GETDATE',  
		CAST (GETUTCDATE() AS TIME) AS 'GETUTCDATE'; 


SELECT  CONVERT(VARCHAR(30),GETDATE(),101) AS '101', --mm/dd/aaaa
		CONVERT(VARCHAR(30),GETDATE(),102) AS '102', --aa.mm.dd
		CONVERT(VARCHAR(30),GETDATE(),103) AS '103', --dd/mm/aaaa
		CONVERT(VARCHAR(30),GETDATE(),104) AS '104', --dd.mm.aa
		CONVERT(VARCHAR(30),GETDATE(),105) AS '105', --dd-mm-aa
		CONVERT(VARCHAR(30),GETDATE(),106) AS '106', --dd mês aa
		CONVERT(VARCHAR(30),GETDATE(),107) AS '107', --Mês dd, aa
		CONVERT(VARCHAR(30),GETDATE(),108) AS '108', --hh:mi:ss
		CONVERT(VARCHAR(30),GETDATE(),109) AS '109', --mês dd aaaa hh:mi:ss:mmmAM (ou PM)
		CONVERT(VARCHAR(30),GETDATE(),110) AS '110', --mm-dd-aa
		CONVERT(VARCHAR(30),GETDATE(),111) AS '111', --aa/mm/dd
		CONVERT(VARCHAR(30),GETDATE(),112) AS '112', --aammdd
		CONVERT(VARCHAR(30),GETDATE(),113) AS '113', --dd mês aaaa hh:mi:ss:mmm (24h)
		CONVERT(VARCHAR(30),GETDATE(),114) AS '114', --hh:mi:ss:mmm(24h)
		CONVERT(VARCHAR(30),GETDATE(),120) AS '120', --aaaa-mm-dd hh:mi:ss(24h)
		CONVERT(VARCHAR(30),GETDATE(),121) AS '121' --aaaa-mm-dd hh:mi:ss.mmm(24h)

-- Pode Truncar 
SELECT  CONVERT(VARCHAR(17),GETDATE(),109) AS '109', --mês dd aaaa hh:mi:ss:mmmAM (ou PM)
		CONVERT(VARCHAR(16),GETDATE(),121) AS '121' --aaaa-mm-dd hh:mi:ss.mmm(24h)


-- Função SUBSTR
SELECT  SUBSTRING(CONVERT(VARCHAR(10),GETDATE(),120),9,10) +'/'+ 
		SUBSTRING(CONVERT(VARCHAR(7),GETDATE(),120),6,7)   +'/'+ 
		SUBSTRING(CONVERT(VARCHAR(4),GETDATE(),120),1,4)   +' '+
		SUBSTRING(CONVERT(VARCHAR(16),GETDATE(),120),12,17) AS 'DATA TIME',

		SUBSTRING(CONVERT(VARCHAR(10),GETDATE(),120),9,10) +'/'+ 
		SUBSTRING(CONVERT(VARCHAR(7),GETDATE(),120),6,7)   +'/'+ 
		SUBSTRING(CONVERT(VARCHAR(4),GETDATE(),120),1,4) AS 'DATA',

		SUBSTRING(CONVERT(VARCHAR(16),GETDATE(),120),12,17) AS 'TIME'


--  Função FORMAT 

-- Função CAST 
SELECT  FORMAT(CAST(GETDATE() AS DATETIME), 'dd/MM/yyyy hh:mm') AS 'DATA TIME',
		FORMAT(CAST(GETDATE() AS DATETIME), 'dd/MM/yyyy') AS 'DATA',
		FORMAT(CAST(GETDATE() AS DATETIME), 'hh:mm') AS 'TIME'

-- Função CONVERT
SELECT  FORMAT(CONVERT(DATETIME, GETDATE()), 'dd/MM/yyyy hh:mm') AS 'DATA TIME',
		FORMAT(CONVERT(DATETIME, GETDATE()), 'dd/MM/yyyy') AS 'DATA',
		FORMAT(CONVERT(DATETIME, GETDATE() ), 'hh:mm') AS 'TIME'