-- Optimized query
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    py.payment_id,
    py.amount,
    py.payment_date,
    py.payment_method
FROM 
    booking b
JOIN 
    "user" u ON b.user_id = u.user_id
JOIN 
    property p ON b.property_id = p.property_id
LEFT JOIN 
    payment py ON b.booking_id = py.booking_id
WHERE 
    b.start_date > CURRENT_DATE - INTERVAL '1 year'
ORDER BY 
    b.start_date DESC
LIMIT 1000;