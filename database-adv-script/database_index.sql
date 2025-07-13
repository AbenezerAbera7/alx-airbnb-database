-- database_index.sql

-- 1. First, create the indexes
CREATE INDEX idx_user_email ON "user"(email);
CREATE INDEX idx_user_role ON "user"(role);
CREATE INDEX idx_booking_user ON booking(user_id);
CREATE INDEX idx_booking_property ON booking(property_id);
CREATE INDEX idx_booking_dates ON booking(start_date, end_date);
CREATE INDEX idx_booking_status ON booking(status);
CREATE INDEX idx_property_host ON property(host_id);
CREATE INDEX idx_property_price ON property(price_per_night);
CREATE INDEX idx_property_location ON property(location);
CREATE INDEX idx_property_search ON property(location, price_per_night);

-- 2. Performance measurement queries
-- Query 1: Find bookings for a specific user
EXPLAIN ANALYZE 
SELECT * FROM booking WHERE user_id = 'a1b2c3d4-e5f6-7890-g1h2-i3j4k5l6m7n8';

-- Query 2: Find properties in a location within price range
EXPLAIN ANALYZE
SELECT * FROM property 
WHERE location LIKE 'New York%' 
AND price_per_night BETWEEN 100 AND 200;

-- Query 3: Count bookings by status
EXPLAIN ANALYZE
SELECT status, COUNT(*) 
FROM booking 
GROUP BY status;

-- Query 4: Find users by role with their booking count
EXPLAIN ANALYZE
SELECT u.user_id, u.role, COUNT(b.booking_id) as booking_count
FROM "user" u
LEFT JOIN booking b ON u.user_id = b.user_id
WHERE u.role = 'guest'
GROUP BY u.user_id;

-- Query 5: Find properties by host with average rating
EXPLAIN ANALYZE
SELECT p.property_id, p.host_id, AVG(r.rating) as avg_rating
FROM property p
LEFT JOIN review r ON p.property_id = r.property_id
GROUP BY p.property_id;