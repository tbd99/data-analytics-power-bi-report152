WITH table_expression AS (SELECT
                      SUM(dim_product.sale_price*orders.product_quantity) AS total_sales,
                      COUNT(orders.order_date_uuid) AS order_count,
                      dim_store.store_type as store_type
                      FROM orders
                      JOIN dim_product ON dim_product.product_code = orders.product_code
                      JOIN dim_store ON dim_store.store_code = orders.store_code
                      GROUP BY dim_store.store_type),
absolute_total_sales AS (SELECT
                     SUM(table_expression.total_sales) AS absolute_total_sales
                     FROM table_expression)
SELECT table_expression.store_type,
       table_expression.total_sales,
       table_expression.order_count,
       ((table_expression.total_sales/(SELECT absolute_total_sales FROM absolute_total_sales))*100) AS percentage_sales
       FROM table_expression
ORDER BY percentage_sales DESC;