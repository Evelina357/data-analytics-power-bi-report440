/**Create a view where the rows are the store types and 
the columns are the total sales, percentage of total sales and the count of orders**/

WITH cte AS 
        (SELECT 
            ROUND(SUM(dim_product.sale_price * orders.product_quantity)::numeric,2) AS total_sales,
            COUNT(orders.order_date_uuid) AS count_orders,
            dim_store.store_type AS store_type
        FROM orders
        JOIN dim_product ON dim_product.product_code = orders.product_code
        JOIN dim_store ON dim_store.store_code = orders.store_code
        GROUP BY dim_store.store_type)
,
sum_total_sales AS 
        (SELECT SUM(cte.total_sales) AS sum_total_sales
        FROM cte)
SELECT 
    cte.store_type,
    cte.total_sales,
    ROUND((cte.total_sales/(SELECT sum_total_sales FROM sum_total_sales))*100::numeric,2) AS perc_total_sales,
    cte.count_orders
FROM cte;

--Answer: Run the sql query above to see the desired table--