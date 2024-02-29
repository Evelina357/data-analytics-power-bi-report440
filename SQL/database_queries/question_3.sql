--Which German store type had the highest revenue for 2022?--

SELECT ROUND(SUM(forview.product_quantity * forview.sale_price)::numeric,2) AS total_revenue,
        forview.store_type
FROM 
        forview
INNER JOIN 
        dim_store ON forview.country = dim_store.country
WHERE 
        order_date LIKE '2022%' AND forview.country = 'Germany'
GROUP BY 
        forview.store_type
ORDER BY 
        total_revenue DESC;

--Answer: Out of all the German store types, it was the local stores that generated the highest revenue in 2022. 
