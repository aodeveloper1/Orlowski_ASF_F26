-- =========================================
-- NEON MARKET - ZONE FOCUSED DATABASE
-- Create tables in an order that avoids
-- foreign key problems
-- =========================================
-- =========================================
-- Drop tables first if they already exist
-- This helps when testing and rerunning code
-- Drop child tables before parent tables
-- =========================================

DROP TABLE IF EXISTS alerts;

DROP TABLE IF EXISTS transactions;

DROP TABLE IF EXISTS products;

DROP TABLE IF EXISTS vendors;

DROP TABLE IF EXISTS zone_events;

DROP TABLE IF EXISTS zone_visits;

DROP TABLE IF EXISTS zone_access_rules;

DROP TABLE IF EXISTS user_profiles;

DROP TABLE IF EXISTS zones;

-- =========================================
-- TABLE 1: zones
-- Stores the main areas of the Neon Market
-- =========================================

CREATE TABLE zones (

                       zone_id SERIAL PRIMARY KEY,         -- unique id for each zone

                       zone_name VARCHAR(100) NOT NULL,      -- name of the zone

                       zone_type VARCHAR(50) NOT NULL,      -- public, restricted, underground, experimental

                       risk_level VARCHAR(20) NOT NULL,      -- low, medium, high

                       description TEXT              -- optional longer explanation

);

-- =========================================
-- TABLE 2: user_profiles
-- Stores users with role and reputation
-- =========================================

CREATE TABLE user_profiles (

                               user_id SERIAL PRIMARY KEY,        -- unique id for each user

                               username VARCHAR(50) NOT NULL UNIQUE,   -- username must be unique

                               reputation_score INT DEFAULT 0,      -- simple reputation number

                               role VARCHAR(30) NOT NULL,         -- buyer, vendor, observer, admin

                               account_status VARCHAR(20) DEFAULT 'active'-- active, suspended, inactive

);

-- =========================================
-- TABLE 3: zone_access_rules
-- Defines what is needed to enter a zone
-- =========================================

CREATE TABLE zone_access_rules (

                                   rule_id SERIAL PRIMARY KEY,        -- unique id for each rule

                                   zone_id INT NOT NULL REFERENCES zones(zone_id), -- links rule to a zone

                                   required_reputation_score INT DEFAULT 0,  -- minimum reputation needed

                                   required_role VARCHAR(30),         -- required role, if any

                                   is_vr_required BOOLEAN DEFAULT TRUE    -- whether VR access is required

);

-- =========================================
-- TABLE 4: zone_visits
-- Tracks when a user enters and leaves a zone
-- =========================================

CREATE TABLE zone_visits (

                             visit_id SERIAL PRIMARY KEY,        -- unique id for each visit

                             user_id INT NOT NULL REFERENCES user_profiles(user_id), -- which user visited

                             zone_id INT NOT NULL REFERENCES zones(zone_id),     -- which zone was visited

                             entry_time TIMESTAMP NOT NULL,       -- when user entered

                             exit_time TIMESTAMP            -- when user left, can be NULL

);

-- =========================================
-- TABLE 5: zone_events
-- Stores events that happen inside a zone
-- =========================================

CREATE TABLE zone_events (

                             event_id SERIAL PRIMARY KEY,        -- unique id for each event

                             zone_id INT NOT NULL REFERENCES zones(zone_id), -- zone where event happened

                             event_type VARCHAR(50) NOT NULL,      -- trade, scan, alert, upload

                             event_time TIMESTAMP NOT NULL,       -- time of event

                             severity_level VARCHAR(20)         -- low, medium, high, critical

);

-- =========================================
-- TABLE 6: vendors
-- Stores sellers connected to a specific zone
-- =========================================

CREATE TABLE vendors (

                         vendor_id SERIAL PRIMARY KEY,       -- unique id for each vendor

                         vendor_name VARCHAR(100) NOT NULL,     -- vendor name

                         zone_id INT NOT NULL REFERENCES zones(zone_id), -- vendor belongs to a zone

                         reputation_score NUMERIC(3,1) DEFAULT 0.0, -- vendor score like 4.5

                         status VARCHAR(20) DEFAULT 'active'    -- active, inactive, suspended

);

-- =========================================
-- TABLE 7: products
-- Stores items sold by vendors
-- =========================================

CREATE TABLE products (

                          product_id SERIAL PRIMARY KEY,       -- unique id for each product

                          vendor_id INT NOT NULL REFERENCES vendors(vendor_id), -- vendor selling product

                          product_name VARCHAR(100) NOT NULL,    -- product name

                          price NUMERIC(10,2),            -- price with 2 decimal places

                          is_active BOOLEAN DEFAULT TRUE       -- whether product is active

);

-- =========================================
-- TABLE 8: transactions
-- Stores purchases made in zones
-- =========================================

CREATE TABLE transactions (

                              transaction_id SERIAL PRIMARY KEY,     -- unique id for each transaction

                              user_id INT NOT NULL REFERENCES user_profiles(user_id), -- buyer

                              product_id INT NOT NULL REFERENCES products(product_id),-- product bought

                              zone_id INT NOT NULL REFERENCES zones(zone_id),     -- zone where purchase happened

                              amount NUMERIC(10,2) NOT NULL,       -- amount paid

                              transaction_time TIMESTAMP NOT NULL    -- when purchase happened

);

-- =========================================
-- TABLE 9: alerts
-- Stores suspicious activity tied to zones/users
-- =========================================

CREATE TABLE alerts (

                        alert_id SERIAL PRIMARY KEY,        -- unique id for each alert

                        zone_id INT NOT NULL REFERENCES zones(zone_id), -- zone where alert happened

                        user_id INT REFERENCES user_profiles(user_id), -- user involved, can be NULL

                        alert_type VARCHAR(50) NOT NULL,      -- intrusion, fraud, anomaly

                        alert_time TIMESTAMP NOT NULL       -- when alert happened

);