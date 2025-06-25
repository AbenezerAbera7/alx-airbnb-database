# Database Normalization Diagram (3NF)

```mermaid
erDiagram
    USER ||--o{ PROPERTY : "hosts"
    USER ||--o{ BOOKING : "makes"
    USER ||--o{ REVIEW : "writes"
    USER ||--o{ MESSAGE : "sends"
    USER ||--o{ MESSAGE : "receives"
    PROPERTY ||--o{ BOOKING : "has"
    PROPERTY ||--o{ REVIEW : "receives"
    BOOKING ||--|| PAYMENT : "has"

    USER {
        uuid user_id PK "1NF, 2NF, 3NF"
        string first_name
        string last_name
        string email "Unique"
        string password_hash
        string phone_number
        enum role "guest/host/admin"
        timestamp created_at
    }
    
    PROPERTY {
        uuid property_id PK "1NF, 2NF, 3NF"
        uuid host_id FK "→ User"
        string name
        text description
        string location
        decimal pricepernight
        timestamp created_at
        timestamp updated_at
    }
    
    BOOKING {
        uuid booking_id PK "1NF, 2NF, 3NF"
        uuid property_id FK "→ Property"
        uuid user_id FK "→ User"
        date start_date
        date end_date
        decimal total_price "Derived but stored"
        enum status "pending/confirmed/canceled"
        timestamp created_at
    }
    
    PAYMENT {
        uuid payment_id PK "1NF, 2NF, 3NF"
        uuid booking_id FK "→ Booking"
        decimal amount
        timestamp payment_date
        enum payment_method "credit_card/paypal/stripe"
    }
    
    REVIEW {
        uuid review_id PK "1NF, 2NF, 3NF"
        uuid property_id FK "→ Property"
        uuid user_id FK "→ User"
        integer rating "1-5"
        text comment
        timestamp created_at
    }
    
    MESSAGE {
        uuid message_id PK "1NF, 2NF, 3NF"
        uuid sender_id FK "→ User"
        uuid recipient_id FK "→ User"
        text message_body
        timestamp sent_at
    }