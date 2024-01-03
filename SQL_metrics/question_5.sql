-- Which product category generated the most profit for the "Wiltshire, UK" region in 2021?

-- calculate profit by subtracting cost from sale price 
SELECT SUM(sale_price - cost_price) AS profit, category
FROM forquerying2
WHERE full_region = 'Wiltshire, UK'
GROUP BY category
ORDER BY profit DESC
LIMIT 1;