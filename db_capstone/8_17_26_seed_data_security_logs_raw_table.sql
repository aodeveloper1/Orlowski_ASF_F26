INSERT INTO security_logs_raw (
    event_time, username, user_role, account_status, ip_address,
    port_number, device_type, operating_system, browser_name,
    location_city, location_region, location_country, event_type,
    event_category, action_taken, status, severity, resource_type,
    resource_name, session_id, failure_reason, risk_score, watchlist_flag, notes
)
SELECT
    NOW() - (random() * INTERVAL '30 days') AS event_time,
    ('user_' || floor(random() * 20 + 1))::VARCHAR AS username,
    (ARRAY['Admin', 'Analyst', 'Engineer', 'Auditor', 'Guest'])[floor(random() * 5 + 1)]::VARCHAR AS user_role,
    (ARRAY['Active', 'Locked', 'Suspended', 'Active'])[floor(random() * 4 + 1)]::VARCHAR AS account_status,
    ('192.168.1.' || floor(random() * 254 + 1))::VARCHAR AS ip_address,
    floor(random() * 50000 + 1024)::INTEGER AS port_number,
    (ARRAY['Desktop', 'Laptop', 'Mobile', 'Server'])[floor(random() * 4 + 1)]::VARCHAR AS device_type,
    (ARRAY['Windows 11', 'Ubuntu 22.04', 'macOS Sonoma', 'RHEL 9'])[floor(random() * 4 + 1)]::VARCHAR AS operating_system,
    (ARRAY['Chrome', 'Firefox', 'Safari', 'Edge', 'PostmanRuntime'])[floor(random() * 5 + 1)]::VARCHAR AS browser_name,
    (ARRAY['Austin', 'Dallas', 'Houston', 'San Antonio', 'New York'])[floor(random() * 5 + 1)]::VARCHAR AS location_city,
    (ARRAY['Texas', 'New York', 'California', 'Washington'])[floor(random() * 4 + 1)]::VARCHAR AS location_region,
    'United States'::VARCHAR AS location_country,
    (ARRAY['LOGIN_ATTEMPT', 'FILE_ACCESS', 'PRIVILEGE_ESCALATION', 'CONFIG_CHANGE', 'API_CALL'])[floor(random() * 5 + 1)]::VARCHAR AS event_type,
    (ARRAY['Authentication', 'Authorization', 'System', 'Network'])[floor(random() * 4 + 1)]::VARCHAR AS event_category,
    (ARRAY['Allow', 'Deny', 'Challenge', 'Monitor'])[floor(random() * 4 + 1)]::VARCHAR AS action_taken,
    (ARRAY['Success', 'Failure', 'Warning', 'Blocked'])[floor(random() * 4 + 1)]::VARCHAR AS status,
    (ARRAY['Low', 'Medium', 'High', 'Critical'])[floor(random() * 4 + 1)]::VARCHAR AS severity,
    (ARRAY['Database', 'S3 Bucket', 'API Endpoint', 'Server Node'])[floor(random() * 4 + 1)]::VARCHAR AS resource_type,
    ('res-prod-' || floor(random() * 10 + 1))::VARCHAR AS resource_name,
    md5(random()::text)::VARCHAR(128) AS session_id,
    (ARRAY[NULL, 'Invalid Credentials', 'IP Mismatch', 'Rate Limit Exceeded'])[floor(random() * 4 + 1)]::VARCHAR AS failure_reason,
    round((random() * 10)::numeric, 2) AS risk_score,
    (random() < 0.15) AS watchlist_flag,
    ('Automated security log entry generated for test index validation.')::TEXT AS notes
FROM generate_series(1, 100);

--NOTE: this query uses a generate_series function and a cool combination of arrays and random number generation to make fake data. Easy-peasy
-- but it won't work too great at making data that has an actual thread of logic or story behind it for testing purposes.