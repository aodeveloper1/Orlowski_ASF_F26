--QUERY 1, Target Result 1
--This query will print the zone names from the zone table in alphabetical order (ascending)
SELECT zone_name
FROM zones
ORDER BY zone_name ASC
LIMIT 4;

--QUERY 2, Target Result 2
--This query will print each users' username and their role from the user_profiles table. It will sort
-- by the username.
SELECT username, role
FROM user_profiles
ORDER BY username
LIMIT 7;

--QUERY 3, Target Result 3
--This query will print the users' username and their reputation score sorted by reputation score
-- in descending order
SELECT username, reputation_score
FROM user_profiles
ORDER BY reputation_score DESC
LIMIT 5;

--QUERY 4, Target Result 4
-- This selects each zone with a risk_level equal to "high" and prints it by zone_name in alphabetical order.
SELECT zone_name, zone_type, risk_level
FROM zones
WHERE risk_level = 'high'
ORDER BY zone_name ASC;

--QUERY 5, Target Result 5
--This selects the vendor_name and their status from the vendors table and filters for only those with an active status.
SELECT vendor_name, status
FROM vendors
WHERE status = 'active'
ORDER BY vendor_name
LIMIT 6;

--QUERY 6, Target Result 6
-- This selects the product name, price, and active-status from the products table and filters for non-active products,
-- removes null price values and sorts by price value
SELECT product_name, price, is_active
FROM products
WHERE is_active = 'false' AND price IS NOT NULL
ORDER BY price DESC
LIMIT 8;

--QUERY 7, Target Result 7
--This selects the zone name, required role, and required reputation score from the zones table
-- joined with  the zone access rule by zone id. It sorts by the required role first, then
-- by the reputation score (Descending)
SELECT  zone_name, required_role, required_reputation_score
FROM zones z JOIN zone_access_rules zar ON z.zone_id = zar.zone_id
ORDER BY required_role, required_reputation_score DESC
LIMIT 7;

--QUERY 8, Target Result 8
-- This selects the username and zone name from the user profiles table joined with the zones visits table by user id
-- and joined with the zone table by zone id, and then sorts by zone name, followed by username.
SELECT username, zone_name
FROM user_profiles u JOIN zone_visits zv ON u.user_id = zv.user_id
    JOIN zones z on zv.zone_id = z.zone_id
ORDER BY zone_name, username
LIMIT 9;

--QUERY 9, Target Result 9
-- This selects the username, zone name, and entry time from the zone visits table
-- joined with the user profiles table on user id, and joined with the zones table on
-- zone id and then sorted by entry time (descending).
select username, zone_name, entry_time
FROM zone_visits zv JOIN user_profiles u ON u.user_id = zv.user_id JOIN zones z ON zv.zone_id = z.zone_id
ORDER BY entry_time DESC
LIMIT 6;

--QUERY 10, Target Result 10
-- This selects the zone name, event type, and severity level from the zones table
-- joined with the zone events on zone id and filters for only high and critical severity
-- and then sorts by severity level (descending) and then zone name (ascending)
SELECT zone_name, event_type, severity_level
FROM zones z JOIN zone_events ze ON z.zone_id = ze.zone_id
WHERE severity_level IN ('high', 'critical')
ORDER BY severity_level DESC, zone_name ASC
LIMIT 10;

--QUERY 11, Target Result 11
-- This selects the vendor name, zone name, and reputation score from the
-- vendors table joined with the zones table by zone id
-- and sorts by reputation score descending
SELECT vendor_name, zone_name, reputation_score
FROM vendors v JOIN zones z on v.zone_id = z.zone_id
ORDER BY reputation_score DESC
LIMIT 5;

--QUERY 12, Target Result 12
-- This selects the product name, vendor name, price from the products table
-- joined with the vendors table by vendor id and filters for active products
-- and sorts by vendor name followed by product id (descending)
SELECT product_name, vendor_name, price
FROM products p JOIN vendors v on p.vendor_id = v.vendor_id
WHERE is_active = true
ORDER BY vendor_name, product_id DESC
LIMIT 8;

--QUERY 13, Target Result 13
-- This selects the username, zone name, and amount from the user profiles table joined
-- with the transactions table on user id and joined with the zones table on zone id
-- it then sorts by amount (descending) and then username
SELECT username, zone_name, amount
FROM user_profiles u JOIN transactions t ON u.user_id = t.user_id
    JOIN zones z ON t.zone_id = z.zone_id
ORDER BY amount DESC, username
LIMIT 7;

--QUERY 14, Target Result 14
-- This selects the username, product name, zone name, and transaction time from the
-- user profiles table joined with the transactions table on user id joined with the products
-- table on product id and joined with the zones table on zone id. It then orders by transaction
--time
SELECT username, product_name, zone_name, transaction_time
FROM user_profiles u JOIN transactions t on u.user_id = t.user_id
    JOIN products p ON t.product_id = p.product_id
    JOIN zones z ON t.zone_id = z.zone_id
ORDER BY transaction_time
LIMIT 9;

--QUERY 15, Target Result 15
--This selects the username, alert type, and zone name from the user profiles table joined
-- with the alerts table on user id and the zones table on zone id. It then filters for anomaly
-- type alerts and orders by username
SELECT username, alert_type, zone_name
FROM user_profiles u JOIN alerts a ON u.user_id = a.user_id
    JOIN zones z on a.zone_id = z.zone_id
WHERE alert_type = 'anomaly'
ORDER BY username, zone_name DESC
LIMIT 10;

--QUERY 16, Target Result 16
-- This selects the zone name and count total zone visits from the zones table
-- joined with the zone visits table on zone id. The grouping enables the count by zone name and
-- we sort by the total number of visits (descending) and then zone name
SELECT zone_name, COUNT(*) as total_visits
FROM zones z JOIN zone_visits zv ON z.zone_id = zv.zone_id
GROUP BY zone_name
ORDER BY total_visits DESC, zone_name ASC
LIMIT 6;

--QUERY 17, Target Result 17
--This selects the zone name and count of total events from the zones table joined
-- with the zone events table on zone id. We group the records by zone name to get the
-- total count of events and sort by the zone name.
SELECT zone_name, COUNT(*) as total_events
FROM zones z JOIN zone_events ze on z.zone_id = ze.zone_id
GROUP BY zone_name
ORDER BY zone_name;

--QUERY 18, Target Result 18
-- This selects the zone name and a rounded average transaction amount from the zones table joined with the
-- transactions table on zone id. We group the records by zone name so we can find the average
-- transaction amount by zone name. We order by the average amount (descending).
SELECT zone_name, ROUND(AVG(amount),2)::DECIMAL(10,2) as avg_amount
FROM zones z JOIN transactions t ON z.zone_id = t.zone_id
GROUP BY zone_name
ORDER BY avg_amount DESC
LIMIT 8;

--QUERY 19, Target Result 19
-- This selects the user name and count of total user alerts from the user profiles table
-- joined with the alerts table on user id. We group by username so we can count how many
-- alerts each user has and then sort by the total alert count (descending)
SELECT username, COUNT (*) as total_alerts
FROM user_profiles u JOIN alerts a ON u.user_id = a.user_id
GROUP BY username
ORDER BY total_alerts DESC
LIMIT 4;

--QUERY 20, Target Result 20
-- This selects the user name, zone name, and count of total visits from the user profiles
-- table joined with the zone visits table on user id and zones table on zone id. We group
-- by username and zone name so we can count total visits of each user to each zone and sort
-- by total visits (descending) and then user name.
SELECT username, zone_name, COUNT(*) as total_visits
FROM user_profiles u JOIN zone_visits zv ON u.user_id = zv.user_id
    JOIN zones z ON z.zone_id = zv.zone_id
GROUP BY username, zone_name
ORDER BY  total_visits DESC, username
LIMIT 6;

