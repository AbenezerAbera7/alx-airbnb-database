# AirBnB Database Schema

![Database Schema](https://img.shields.io/badge/Schema-3NF-brightgreen)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue)

## Overview

This repository contains the complete SQL schema definition for an AirBnB-like accommodation booking platform. The database is designed to support user management, property listings, bookings, payments, reviews, and messaging functionality.

## Database Design

### Schema Diagram

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