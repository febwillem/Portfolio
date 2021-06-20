
-- Count the number of users per country

SELECT country
, COUNT(country) AS CountUser_perCountry
FROM PortfolioProject..user_tab
GROUP BY country


-- Count the number of orders per country

SELECT u.country
, COUNT(o.orderid) AS CountOrder_perCountry
FROM PortfolioProject..order_tab o
JOIN PortfolioProject..user_tab u
	ON o.userid = u.userid
GROUP BY u.country


-- First order date of each user

SELECT userid
, MIN(order_time) AS FirstOrder
FROM PortfolioProject..order_tab
GROUP BY userid
ORDER BY userid


-- Find the number of users who made their first order in each country, each day

SELECT u.country
, o.order_time
, COUNT(DISTINCT (u.userid)) AS counter
FROM PortfolioProject..user_tab u 
JOIN (
  SELECT userid
  , MIN(order_time) AS order_time 
  FROM PortfolioProject..order_tab
  GROUP BY userid) o 
	ON o.userid = u.userid
GROUP BY u.country, o.order_time


-- Find the first order GMV of each user. If there is a tie, use the order with the lower orderid

SELECT o.userid
, o.gmv
, x.order_time
FROM PortfolioProject..order_tab o
INNER JOIN
	(SELECT userid, MIN(order_time) AS order_time
	FROM PortfolioProject..order_tab
	GROUP BY userid) x
	ON o.userid = x.userid
ORDER BY o.userid

SELECT userid
, gmv
, order_time
FROM PortfolioProject..order_tab
WHERE order_time IN 
	(SELECT MIN(order_time)
	FROM PortfolioProject..order_tab o
	GROUP BY o.userid)
ORDER BY userid