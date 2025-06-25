-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Clear existing data (for testing)
TRUNCATE TABLE payment, review, message, booking, property, "user" RESTART IDENTITY CASCADE;

-- Insert sample users
INSERT INTO "user" (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
-- Admins
(uuid_generate_v5(uuid_ns_url(), 'admin1'), 'Sarah', 'Johnson', 'sarah@airbnbadmin.com', crypt('adminpass1', gen_salt('bf')), '+15551234567', 'admin', '2022-01-01 09:00:00'),
(uuid_generate_v5(uuid_ns_url(), 'admin2'), 'Michael', 'Chen', 'michael@airbnbadmin.com', crypt('adminpass2', gen_salt('bf')), '+15552345678', 'admin', '2022-01-02 10:00:00'),

-- Hosts
(uuid_generate_v5(uuid_ns_url(), 'host1'), 'Emma', 'Williams', 'emma@example.com', crypt('hostpass1', gen_salt('bf')), '+15553456789', 'host', '2022-02-01 11:00:00'),
(uuid_generate_v5(uuid_ns_url(), 'host2'), 'James', 'Brown', 'james@example.com', crypt('hostpass2', gen_salt('bf')), '+15554567890', 'host', '2022-02-15 12:00:00'),
(uuid_generate_v5(uuid_ns_url(), 'host3'), 'Olivia', 'Garcia', 'olivia@example.com', crypt('hostpass3', gen_salt('bf')), '+15555678901', 'host', '2022-03-01 13:00:00'),

-- Guests
(uuid_generate_v5(uuid_ns_url(), 'guest1'), 'Noah', 'Martinez', 'noah@example.com', crypt('guestpass1', gen_salt('bf')), '+15556789012', 'guest', '2022-03-15 14:00:00'),
(uuid_generate_v5(uuid_ns_url(), 'guest2'), 'Ava', 'Davis', 'ava@example.com', crypt('guestpass2', gen_salt('bf')), '+15557890123', 'guest', '2022-04-01 15:00:00'),
(uuid_generate_v5(uuid_ns_url(), 'guest3'), 'Liam', 'Rodriguez', 'liam@example.com', crypt('guestpass3', gen_salt('bf')), '+15558901234', 'guest', '2022-04-15 16:00:00');

-- Insert sample properties
INSERT INTO property (property_id, host_id, name, description, location, price_per_night, created_at, updated_at) VALUES
-- Emma's properties
(uuid_generate_v5(uuid_ns_url(), 'property1'), (SELECT user_id FROM "user" WHERE email = 'emma@example.com'), 
'Beachfront Villa', 'Luxury villa with private beach access', 'Malibu, CA', 450.00, '2022-02-05 09:00:00', '2022-06-01 10:00:00'),

(uuid_generate_v5(uuid_ns_url(), 'property2'), (SELECT user_id FROM "user" WHERE email = 'emma@example.com'), 
'Downtown Loft', 'Modern loft in heart of the city', 'New York, NY', 275.00, '2022-02-10 11:00:00', '2022-05-15 12:00:00'),

-- James' properties
(uuid_generate_v5(uuid_ns_url(), 'property3'), (SELECT user_id FROM "user" WHERE email = 'james@example.com'), 
'Mountain Cabin', 'Cozy cabin with stunning mountain views', 'Aspen, CO', 195.00, '2022-02-20 13:00:00', '2022-07-10 14:00:00'),

-- Olivia's properties
(uuid_generate_v5(uuid_ns_url(), 'property4'), (SELECT user_id FROM "user" WHERE email = 'olivia@example.com'), 
'Lake House', 'Peaceful retreat by the lake', 'Lake Tahoe, CA', 320.00, '2022-03-05 15:00:00', '2022-08-20 16:00:00'),

(uuid_generate_v5(uuid_ns_url(), 'property5'), (SELECT user_id FROM "user" WHERE email = 'olivia@example.com'), 
'Urban Apartment', 'Chic apartment in arts district', 'Portland, OR', 180.00, '2022-03-10 17:00:00', '2022-09-05 18:00:00');

-- Insert sample bookings
INSERT INTO booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
-- Noah's bookings
(uuid_generate_v5(uuid_ns_url(), 'booking1'), (SELECT property_id FROM property WHERE name = 'Beachfront Villa'), 
(SELECT user_id FROM "user" WHERE email = 'noah@example.com'), 
'2023-06-15', '2023-06-20', 2250.00, 'confirmed', '2023-01-10 10:00:00'),

(uuid_generate_v5(uuid_ns_url(), 'booking2'), (SELECT property_id FROM property WHERE name = 'Mountain Cabin'), 
(SELECT user_id FROM "user" WHERE email = 'noah@example.com'), 
'2023-12-10', '2023-12-15', 975.00, 'pending', '2023-05-15 11:00:00'),

-- Ava's bookings
(uuid_generate_v5(uuid_ns_url(), 'booking3'), (SELECT property_id FROM property WHERE name = 'Downtown Loft'), 
(SELECT user_id FROM "user" WHERE email = 'ava@example.com'), 
'2023-07-01', '2023-07-05', 1100.00, 'confirmed', '2023-02-20 12:00:00'),

-- Liam's bookings
(uuid_generate_v5(uuid_ns_url(), 'booking4'), (SELECT property_id FROM property WHERE name = 'Lake House'), 
(SELECT user_id FROM "user" WHERE email = 'liam@example.com'), 
'2023-08-12', '2023-08-18', 1920.00, 'confirmed', '2023-03-05 13:00:00'),

(uuid_generate_v5(uuid_ns_url(), 'booking5'), (SELECT property_id FROM property WHERE name = 'Urban Apartment'), 
(SELECT user_id FROM "user" WHERE email = 'liam@example.com'), 
'2023-09-01', '2023-09-03', 360.00, 'canceled', '2023-04-10 14:00:00');

-- Insert sample payments
INSERT INTO payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
(uuid_generate_v5(uuid_ns_url(), 'payment1'), (SELECT booking_id FROM booking WHERE booking_id = uuid_generate_v5(uuid_ns_url(), 'booking1')), 
2250.00, '2023-01-11 09:30:00', 'credit_card'),

(uuid_generate_v5(uuid_ns_url(), 'payment2'), (SELECT booking_id FROM booking WHERE booking_id = uuid_generate_v5(uuid_ns_url(), 'booking3')), 
1100.00, '2023-02-21 10:45:00', 'paypal'),

(uuid_generate_v5(uuid_ns_url(), 'payment3'), (SELECT booking_id FROM booking WHERE booking_id = uuid_generate_v5(uuid_ns_url(), 'booking4')), 
1920.00, '2023-03-06 14:20:00', 'stripe');

-- Insert sample reviews
INSERT INTO review (review_id, property_id, user_id, rating, comment, created_at) VALUES
(uuid_generate_v5(uuid_ns_url(), 'review1'), (SELECT property_id FROM property WHERE name = 'Beachfront Villa'), 
(SELECT user_id FROM "user" WHERE email = 'noah@example.com'), 
5, 'Absolutely stunning views and perfect location!', '2023-06-25 16:00:00'),

(uuid_generate_v5(uuid_ns_url(), 'review2'), (SELECT property_id FROM property WHERE name = 'Downtown Loft'), 
(SELECT user_id FROM "user" WHERE email = 'ava@example.com'), 
4, 'Great space with amazing city views', '2023-07-10 17:30:00'),

(uuid_generate_v5(uuid_ns_url(), 'review3'), (SELECT property_id FROM property WHERE name = 'Lake House'), 
(SELECT user_id FROM "user" WHERE email = 'liam@example.com'), 
5, 'Perfect getaway with everything we needed', '2023-08-20 18:45:00');

-- Insert sample messages
INSERT INTO message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
-- Guest to Host
(uuid_generate_v5(uuid_ns_url(), 'message1'), 
(SELECT user_id FROM "user" WHERE email = 'noah@example.com'), 
(SELECT user_id FROM "user" WHERE email = 'emma@example.com'), 
'Hi Emma, is the beach villa pet friendly?', '2023-01-05 11:20:00'),

(uuid_generate_v5(uuid_ns_url(), 'message2'), 
(SELECT user_id FROM "user" WHERE email = 'emma@example.com'), 
(SELECT user_id FROM "user" WHERE email = 'noah@example.com'), 
'Hi Noah! Yes, we allow small pets with a $50 cleaning fee.', '2023-01-05 14:35:00'),

-- Host to Guest
(uuid_generate_v5(uuid_ns_url(), 'message3'), 
(SELECT user_id FROM "user" WHERE email = 'olivia@example.com'), 
(SELECT user_id FROM "user" WHERE email = 'liam@example.com'), 
'Hi Liam, just confirming your check-in time for the lake house', '2023-08-10 09:15:00'),

-- Guest to Guest
(uuid_generate_v5(uuid_ns_url(), 'message4'), 
(SELECT user_id FROM "user" WHERE email = 'ava@example.com'), 
(SELECT user_id FROM "user" WHERE email = 'noah@example.com'), 
'Noah, how was your stay at the beach villa? Thinking of booking it!', '2023-07-15 16:40:00');