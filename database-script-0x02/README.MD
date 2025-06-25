# AirBnB Database Sample Data

![Sample Data](https://img.shields.io/badge/Data-Sample-blue)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue)

## Overview

This repository contains sample data for the AirBnB database schema, providing realistic test data for development and testing purposes.

## Database Sample Contents

### User Accounts
- **3 Admin users**: System administrators
- **3 Host users**: Property owners
- **3 Guest users**: Travelers making bookings

### Property Listings
- 5 diverse properties across different locations:
  - Beachfront Villa (Malibu, CA)
  - Downtown Loft (New York, NY)
  - Mountain Cabin (Aspen, CO)
  - Lake House (Lake Tahoe, CA)
  - Urban Apartment (Portland, OR)

### Bookings
- 5 bookings with different statuses:
  - 3 confirmed bookings
  - 1 pending booking
  - 1 canceled booking

### Additional Data
- 3 completed payments
- 3 property reviews
- 4 sample messages between users

## Installation

1. First set up the database schema using the schema.sql file
2. Load the sample data:

```bash
psql -U username -d airbnb -f seed.sql