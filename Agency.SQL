  -- DATA QUERY LANGUAGE (DQL)

  -- SELECT STATEMENT

  -- Write an SQL query to display all the agents’ names with their phone numbers from the agents table.

  SELECT [agent_name],
         [phone_number]
  FROM [dbo].[agents]

  -- Write a query to display the names of all the customers whose working area is Leeds from the customer table.

  SELECT [cust_name],
         [working_area]
  FROM [dbo].[customer]
  WHERE [working_area] = 'Leeds'

  -- Write a query to display the order number and order amount where the order description is shoe from the orders table.

  SELECT [order_num],
         [order_amount],
         [order_description]
  FROM [dbo].[orders]
  WHERE [order_description] = 'shoe'
 
  -- Write a query to display the agent code, order amount and order description where order amount = 3000 and order description is shirt.

  SELECT [agent_code],
         [order_amount],
         [order_description]
  FROM [dbo].[orders]
  WHERE [order_amount] = '3000' AND [order_description] = 'shirt'
 
  -- Write a query to display all the details from the table order where the order amount is more than 2000.

  SELECT * FROM [dbo].[orders]
  WHERE [order_amount] > '2000'

  -- Write a query to display customer name and customer phone number that have alphabet "e" in their name.

  SELECT [cust_name],
         [phone_number]
  FROM [dbo].[customer]
  WHERE [cust_name] LIKE '%e%'

  -- Write a query to display all the details from the orders table with the minimum order amount.

  SELECT *
  FROM [dbo].[orders]
  WHERE [order_amount] = (SELECT MIN([order_amount]) FROM [dbo].[orders])

  -- Write a query to display the total order amount from the orders table.
  SELECT SUM([order_amount]) AS Total_Order_Amount
  FROM [dbo].[orders]
 
  -- Write a query to find the number of agents currently listing for all of their customers from the orders table.

  SELECT COUNT(DISTINCT [agent_code]) AS Number_of_Agents
  FROM [dbo].[orders]

  -- Write a query to find the highest purchase amount ordered by each customer code and the highest order amount.

  SELECT [cust_code],
         MAX([order_amount]) AS Highest_Purchase_Amount,
         (SELECT MAX([order_amount]) FROM [dbo].[orders]) AS Highest_Order_Amount
  FROM [dbo].[orders]
  GROUP BY [cust_code]

   -- Write a query to find the highest order amount on a date '2022-07-13' with agent code.

  SELECT [agent_code],
         [order_amount] AS Highest_Order_Amount
  FROM [dbo].[orders]
  WHERE [order_date] = '2022-07-13'
  AND [order_amount] = (SELECT MAX([order_amount]) FROM [dbo].[orders]  WHERE [order_date] = '2022-07-13')
 
  -- Write a query to find the name and customer city of those customers and agents who work in the same city.

  SELECT
    c.[cust_name],
    a.[agent_name],
    c.[cust_city]
  FROM
    [customer] c
  INNER JOIN
    [agents] a
  ON
    c.[cust_city] = a.[working_area]

  -- Write a query to find the names of all the customers along with the agent names who work for them.

  SELECT
    c.[cust_name] AS Customer_Name,
    a.[agent_name] AS Agent_Name
  FROM
    [customer] c
  INNER JOIN
    [agents] a
  ON
    c.[agent_code] = a.[agent_code]

  -- Write a query to display all those orders by the customers not located in the same cities as their agents' working area.

  SELECT
    o.[order_num],
    o.[order_amount],
    c.[cust_name],
    c.[cust_city],
    a.[agent_name],
    a.[working_area]
  FROM
    [orders] o
  INNER JOIN
    [customer] c ON o.[cust_code] = c.[cust_code]
  INNER JOIN
    [agents] a ON o.[agent_code] = a.[agent_code]
  WHERE
    c.[cust_city] <> a.[working_area]
 
  -- Write a query to display all the orders issued by the agent 'Rickey' from the orders table.

  SELECT
    o.*,
    a.[agent_name]
  FROM
    [orders] o
  INNER JOIN
    [agents] a
  ON
    o.[agent_code] = a.[agent_code]
  WHERE
    a.[agent_name] = 'Rickey'
