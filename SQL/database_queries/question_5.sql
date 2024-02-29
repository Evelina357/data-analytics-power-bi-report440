--Which product category generated the most profit for the "Wiltshire, UK" region in 2021?--

SELECT category,
        ROUND(SUM((sale_price - cost_price) * product_quantity)::numeric, 2) AS profit
FROM forview
WHERE full_region = 'Wiltshire, UK' and order_date LIKE '2021%'
GROUP BY category
ORDER BY profit DESC;

--Answer: Homeware (product category) has generated the most profit for the "Wiltshire, UK" region in 2021.