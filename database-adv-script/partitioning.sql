-- partitioning.sql

-- Step 1: Create the partitioned table structure
CREATE TABLE booking_partitioned (
    booking_id UUID DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(10) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);

-- Step 2: Create partitions for different time periods
-- Historical data
CREATE TABLE booking_historical PARTITION OF booking_partitioned
    FOR VALUES FROM (MINVALUE) TO ('2023-01-01');

-- 2023 data
CREATE TABLE booking_2023 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

-- 2024 data
CREATE TABLE booking_2024 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- Current year data
CREATE TABLE booking_2025 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Future bookings
CREATE TABLE booking_future PARTITION OF booking_partitioned
    FOR VALUES FROM ('2026-01-01') TO (MAXVALUE);

-- Step 3: Migrate data from original table
INSERT INTO booking_partitioned
SELECT * FROM booking;

-- Step 4: Create indexes on partitioned table
CREATE INDEX idx_booking_partitioned_user ON booking_partitioned(user_id);
CREATE INDEX idx_booking_partitioned_property ON booking_partitioned(property_id);
CREATE INDEX idx_booking_partitioned_dates ON booking_partitioned(start_date, end_date);
CREATE INDEX idx_booking_partitioned_status ON booking_partitioned(status);

-- Step 5: Test query performance on partitioned table
EXPLAIN ANALYZE
SELECT * FROM booking_partitioned
WHERE start_date BETWEEN '2024-06-01' AND '2024-12-31'
AND status = 'confirmed';