SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM 
    booking b
INNER JOIN 
    "user" u ON b.user_id = u.user_id;


SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date
FROM 
    property p
LEFT JOIN 
    review r ON p.property_id = r.property_id
ORDER BY 
    p.name ASC, 
    r.created_at DESC;


SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status
FROM 
    "user" u
FULL OUTER JOIN 
    booking b ON u.user_id = b.user_id;