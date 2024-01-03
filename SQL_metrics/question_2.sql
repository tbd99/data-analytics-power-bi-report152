-- Which month in 2022 has had the highest revenue?

SELECT SUM(sale_price), month_name
FROM forquerying2
GROUP BY month_name 
ORDER BY SUM(sale_price) DESC
LIMIT 1;
