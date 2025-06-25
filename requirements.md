# AirBnB Database - Entity Relationship Diagram (ERD) Requirements

## Entities and Attributes

### User
- `user_id` (Primary Key, UUID, Indexed)
- `first_name` (VARCHAR, NOT NULL)
- `last_name` (VARCHAR, NOT NULL)
- `email` (VARCHAR, UNIQUE, NOT NULL)
- `password_hash` (VARCHAR, NOT NULL)
- `phone_number` (VARCHAR, NULL)
- `role` (ENUM: guest, host, admin, NOT NULL)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Property
- `property_id` (Primary Key, UUID, Indexed)
- `host_id` (Foreign Key → User.user_id)
- `name` (VARCHAR, NOT NULL)
- `description` (TEXT, NOT NULL)
- `location` (VARCHAR, NOT NULL)
- `pricepernight` (DECIMAL, NOT NULL)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- `updated_at` (TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP)

### Booking
- `booking_id` (Primary Key, UUID, Indexed)
- `property_id` (Foreign Key → Property.property_id)
- `user_id` (Foreign Key → User.user_id)
- `start_date` (DATE, NOT NULL)
- `end_date` (DATE, NOT NULL)
- `total_price` (DECIMAL, NOT NULL)
- `status` (ENUM: pending, confirmed, canceled, NOT NULL)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Payment
- `payment_id` (Primary Key, UUID, Indexed)
- `booking_id` (Foreign Key → Booking.booking_id)
- `amount` (DECIMAL, NOT NULL)
- `payment_date` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- `payment_method` (ENUM: credit_card, paypal, stripe, NOT NULL)

### Review
- `review_id` (Primary Key, UUID, Indexed)
- `property_id` (Foreign Key → Property.property_id)
- `user_id` (Foreign Key → User.user_id)
- `rating` (INTEGER, CHECK: 1-5, NOT NULL)
- `comment` (TEXT, NOT NULL)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Message
- `message_id` (Primary Key, UUID, Indexed)
- `sender_id` (Foreign Key → User.user_id)
- `recipient_id` (Foreign Key → User.user_id)
- `message_body` (TEXT, NOT NULL)
- `sent_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

## Relationships
1. **User to Property**: One-to-Many (One host can have many properties)
2. **User to Booking**: One-to-Many (One user can have many bookings)
3. **Property to Booking**: One-to-Many (One property can have many bookings)
4. **Booking to Payment**: One-to-One (One booking has one payment)
5. **User to Review**: One-to-Many (One user can write many reviews)
6. **Property to Review**: One-to-Many (One property can have many reviews)
7. **User to Message**: One-to-Many (One user can send/receive many messages)

## Constraints
- All primary keys are UUID and indexed
- Foreign key constraints as specified in relationships
- Unique constraint on User.email
- Rating in Review must be between 1-5
- Appropriate NOT NULL constraints on required fields
- ENUM fields have restricted values as specified

## Indexes
- Primary keys automatically indexed
- Additional indexes:
  - User.email
  - Property.property_id
  - Booking.property_id and Booking.booking_id
  - Payment.booking_id


### Relationships

```mermaid
erDiagram
    USER ||--o{ PROPERTY : "hosts"
    USER ||--o{ BOOKING : "makes"
    USER ||--o{ REVIEW : "writes"
    USER ||--o{ MESSAGE : "sends"
    USER ||--o{ MESSAGE : "receives"
    PROPERTY ||--o{ BOOKING : "has"
    PROPERTY ||--o{ REVIEW : "receives"
    BOOKING ||--o{ PAYMENT : "has"