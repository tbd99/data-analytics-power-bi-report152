-- Which German store type had the highest revenue for 2022?

SELECT SUM(sale_price), store_type
FROM forquerying2
WHERE country = 'Germany'
GROUP BY store_type
ORDER BY SUM(sale_price) DESC
LIMIT 1;