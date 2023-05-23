CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

create type cart_status as enum ('OPEN', 'ORDERED');

-- Create and fulfill Carts Table
create table carts (
	id uuid primary key default uuid_generate_v4(),
    user_id uuid not null,
    created_at DATE default current_date not null,
    updated_at DATE not null,
    status cart_status not null
)

-- Change defaults of a column for already created table
ALTER TABLE carts ALTER COLUMN updated_at SET DEFAULT current_date;

-- Test defaults
INSERT INTO carts (user_id, status)
VALUES
    (uuid_generate_v4(), 'OPEN');

INSERT INTO carts (user_id, created_at, updated_at, status)
VALUES
    (uuid_generate_v4(), '2023-03-03', '2023-03-05', 'OPEN'),
    (uuid_generate_v4(), '2023-05-15', '2023-06-01', 'ORDERED');

-- Create and fulfill Cart Items table
create table cart_items (
	product_id uuid primary key default uuid_generate_v4(),
    cart_id uuid not null,
    count integer,
    foreign key ("cart_id") references "carts" ("id")
)

INSERT INTO cart_items (cart_id, count)
VALUES
    ('94a8a4f9-29bc-4cbc-bba9-4e4d12cc9912', '1'),
    ('1cf31e97-584f-4658-9b49-6f3aa42fb84c', '2'),
    ('b0912ac2-3a29-45ce-96ae-9b620d0b055d', '3');

-- drop table cart_items cascade
