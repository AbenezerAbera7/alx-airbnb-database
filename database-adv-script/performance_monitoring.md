-- performance_monitoring.md
EXPLAIN ANALYZE
SELECT p.property_id, p.name, AVG(r.rating) as avg_rating
FROM property p
LEFT JOIN review r ON p.property_id = r.property_id
WHERE p.location LIKE 'New York%'
AND p.price_per_night BETWEEN 100 AND 300
GROUP BY p.property_id
ORDER BY avg_rating DESC
LIMIT 10;