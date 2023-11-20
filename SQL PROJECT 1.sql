--query 1: looking at the top states that made income from their sales ;
SELECT *
FROM Orders$

SELECT TOP 10 State,Category,[Product Name],Sales,Profit,SUM(sales + profit) as Total_Income
FROM Orders$
 GROUP BY State,Category,[Product Name],Sales,Profit
 ORDER BY Sales desc;
  
--query 2: Applying ranks to each product 
 SELECT [Product Name],Quantity,[Product ID],[Ship Mode],
 RANK () OVER (ORDER BY [Product Name],Quantity,[Product ID],[Ship Mode]) AS RANKS
 FROM Orders$
 GROUP BY [Product Name],Quantity,[Product ID],[Ship Mode]
 ORDER BY [Product ID] desc;
  
--query 3: calculate the total sales that was made in each month of the year
 with monthly_sales as(
SELECT  [Customer ID],Sales, SUM(Sales/12) as Monthly_sales 
FROM Orders$
GROUP BY  [Customer ID],Sales
)--ORDER BY Sales desc;
SELECT SUM(Monthly_sales) as Total_Monthly_Income
FROM monthly_sales

--query 4: identifying the date difference from the order date to the shipping date 
 SELECT TOP 10 [Order Date],[Ship Date],
 (SELECT DATEDIFF(DAYOFYEAR, 1,31))AS DAYDIFFK,
 (SELECT DATEDIFF(WEEKDAY, 1,4))AS WEEKDIFFK,
 (SELECT DATEDIFF(MONTH, 1,31))AS MONTHDIFFK,
 (SELECT DATEDIFF(YEAR, '2014','2015'))AS YEARDIFF
  FROM Orders$
   
--query 5: Calculate sum of sales plus profit to get the annual revenue
--(using CTE)
 with Total_Income as(
 SELECT [Customer ID],[Order Date],SUM(Sales + Profit) AS Total_Income
 FROM Orders$
  GROUP BY  [Customer ID],[Order Date]
 )
  SELECT SUM(Total_Income) AS Total_Revenue 
 FROM Total_Income