SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    avg_rating.average_rating
FROM 
    property p
JOIN (
    SELECT 
        property_id, 
        AVG(rating) AS average_rating
    FROM 
        review
    GROUP BY 
        property_id
    HAVING 
        AVG(rating) > 4.0
) avg_rating ON p.property_id = avg_rating.property_id
ORDER BY 
    avg_rating.average_rating DESC;


SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    (SELECT COUNT(*) 
     FROM booking b 
     WHERE b.user_id = u.user_id) AS booking_count
FROM 
    "user" u
WHERE 
    (SELECT COUNT(*) 
     FROM booking b 
     WHERE b.user_id = u.user_id) > 3
ORDER BY 
    booking_count DESC;