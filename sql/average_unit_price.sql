SELECT
    material,
    supplier,
    AVG(unit_price) AS average_price,
    COUNT(*) AS purchase_count
FROM purchases
WHERE status = 'Completed'
GROUP BY material, supplier
ORDER BY material, average_price;