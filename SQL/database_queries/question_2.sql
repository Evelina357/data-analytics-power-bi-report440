--Which month in 2022 has had the highest revenue?--

SELECT month_name,
        SUM(product_quantity * sale_price) AS total_revenue
FROM forview
WHERE order_date LIKE '2022%'
GROUP BY month_name
ORDER BY total_revenue DESC;

--Answer: August was the month during which the highest revenue was achieved in 2022.--

