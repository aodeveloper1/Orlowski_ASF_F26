# Tables

## accounts
- id (PK)
- username
- display_name
- role
- password_hash
- recovery_email

## products
- id (PK)
- name
- description
- hologram
- price
- stock_qty
- account_id (FK) -> id (PK) in **accounts**

## sessions
- id (PK)
- account_id (FK) -> id (PK) in **accounts**
- token
- created_at
- expires_at

## orders
- id (PK)
- account_id (FK) -> id (PK) in **accounts**
- status
- created_at
- updated_at

## order_items
- id (PK)
- order_id (FK) -> id (PK) in **orders**
- product_id (FK) -> id (PK) in **products**
- purchase_price
- qty

## reviews
- id (PK)
- product_id (FK) -> id (PK) in **products**
- account_id (FK) -> id (PK) in **accounts**
- title
- body
- rating
- created_at
- updated_at
- is_anonymous