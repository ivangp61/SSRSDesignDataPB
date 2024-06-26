-- Main Report Query
SELECT fs.[City Key] AS CityKey
     , dd.[Calendar Year] AS DeliveryYear
     , du.[Customer] AS CustomerName
     , du.[Primary Contact] AS PrimaryContact
     , dc.[City]
     , dc.[State Province] AS StateProvince
     , de.[Employee] AS SalesPerson
     , SUM(fs.[Total Excluding Tax]) AS TotalExcludingTax
  FROM [Fact].[Sale] fs
  JOIN [Dimension].[City] dc
    ON fs.[City Key] = dc.[City Key]
  JOIN [Dimension].[Date] dd
    ON fs.[Delivery Date Key] = dd.[Date]
  JOIN [Dimension].[Customer] du
    ON fs.[Bill To Customer Key] = du.[Customer Key]
  JOIN [Dimension].[Employee] de 
    ON fs.[Salesperson Key] = de.[Employee Key]
 GROUP BY
       fs.[City Key] 
     , dd.[Calendar Year] 
     , du.[Customer] 
     , du.[Primary Contact] 
     , dc.[City]
     , dc.[State Province] 
     , de.[Employee]
 ORDER BY 
       du.[Customer] 
     , dc.[City]
     , dc.[State Province] 
     , dd.[Calendar Year] 
     , de.[Employee]


-- Populate the Year parameter
SELECT DISTINCT  
       [Calendar Year]
  FROM [Dimension].[Date]
 ORDER BY [Calendar Year]

-- Get the most recent 4 years
SELECT DISTINCT  
       [Calendar Year]
  FROM [Dimension].[Date]
 WHERE [Calendar Year] > YEAR(GETDATE()) - 4 
 ORDER BY [Calendar Year]

-- Populate the Salesperson Parameter
SELECT DISTINCT 
       [Employee] AS [SalespersonName]
  FROM [Dimension].[Employee]
 WHERE [Is Salesperson] = 1
 ORDER BY [Employee]
