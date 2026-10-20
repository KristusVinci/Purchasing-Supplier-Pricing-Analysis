WITH average AS (
SELECT material, supplier, AVG(unit_price) AS average_price, COUNT(*) AS purchase_count, SUM(quantity) AS total_quantity
FROM purchases
WHERE status = 'Completed' AND material = 'Downlight'
GROUP BY material, supplier
), max_unit_price AS (
SELECT material, supplier, total_quantity, average_price, MIN(average_price) OVER (PARTITION BY material) AS lowest_average_price, MAX(average_price) OVER (PARTITION BY material) AS highest_average_price
FROM average)
SELECT material, supplier, total_quantity, average_price,
	highest_average_price - average_price AS price_gap_per_unit,
	(average_price - lowest_average_price) * total_quantity AS potential_savings
FROM max_unit_price
ORDER BY average_price;
