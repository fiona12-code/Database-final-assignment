-- Create database
CREATE DATABASE contact_book;

-- Use the database
USE contact_book;

-- create Contacts table
CREATE TABLE contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20)
);

-- Create Addresses table (One contact can have multiple addresses)
CREATE TABLE addresses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    contact_id INT,
    address_line VARCHAR(255) NOT NULL,
    city VARCHAR(100),
    zip_code VARCHAR(20),
    FOREIGN KEY (contact_id) REFERENCES contacts(id) ON DELETE CASCADE
);

-- Insert sample contacts
INSERT INTO contacts (name, email, phone)
VALUES 
('Fiona Atieno', 'fiona@example.com', '0712345678'),
('James Mwangi', 'james@example.com', '0723456789');

-- Insert sample addresses
INSERT INTO addresses (contact_id, address_line, city, zip_code)
VALUES 
(1, '123 Elm Street', 'Nairobi', '00100'),
(1, '456 Garden Ave', 'Kisumu', '40100'),
(2, '789 River Rd', 'Mombasa', '80100');
