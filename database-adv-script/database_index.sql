-- User table indexes
CREATE INDEX idx_user_email ON "user"(email);
CREATE INDEX idx_user_role ON "user"(role);

-- Booking table indexes
CREATE INDEX idx_booking_user ON booking(user_id);
CREATE INDEX idx_booking_property ON booking(property_id);
CREATE INDEX idx_booking_dates ON booking(start_date, end_date);
CREATE INDEX idx_booking_status ON booking(status);

-- Property table indexes
CREATE INDEX idx_property_host ON property(host_id);
CREATE INDEX idx_property_price ON property(price_per_night);
CREATE INDEX idx_property_location ON property(location);

-- Composite index for common property search patterns
CREATE INDEX idx_property_search ON property(location, price_per_night);