# Query Performance Before and After Indexing

## Test Query 1: Find bookings for a specific user
```sql
EXPLAIN ANALYZE 
SELECT * FROM booking WHERE user_id = 'a1b2c3d4-e5f6-7890-g1h2-i3j4k5l6m7n8';