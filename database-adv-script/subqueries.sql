SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS booking_count
FROM 
    "user" u
JOIN 
    booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id
HAVING 
    COUNT(b.booking_id) > 3
ORDER BY 
    booking_count DESC;