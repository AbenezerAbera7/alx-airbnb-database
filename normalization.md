erDiagram
    USER ||--o{ PROPERTY : "hosts"
    USER ||--o{ BOOKING : "makes"
    USER ||--o{ REVIEW : "writes"
    USER ||--o{ MESSAGE : "sends"
    USER ||--o{ MESSAGE : "receives"
    PROPERTY ||--o{ BOOKING : "has"
    PROPERTY ||--o{ REVIEW : "receives"
    BOOKING ||--o{ PAYMENT : "has"
    
    USER {
        uuid user_id PK
        string first_name
        string last_name
        string email
        string password_hash
        string phone_number
        enum role
        timestamp created_at
    }
    
    PROPERTY {
        uuid property_id PK
        uuid host_id FK
        string name
        text description
        string location
        decimal pricepernight
        timestamp created_at
        timestamp updated_at
    }
    
    BOOKING {
        uuid booking_id PK
        uuid property_id FK
        uuid user_id FK
        date start_date
        date end_date
        decimal total_price
        enum status
        timestamp created_at
    }
    
    PAYMENT {
        uuid payment_id PK
        uuid booking_id FK
        decimal amount
        timestamp payment_date
        enum payment_method
    }
    
    REVIEW {
        uuid review_id PK
        uuid property_id FK
        uuid user_id FK
        integer rating
        text comment
        timestamp created_at
    }
    
    MESSAGE {
        uuid message_id PK
        uuid sender_id FK
        uuid recipient_id FK
        text message_body
        timestamp sent_at
    }