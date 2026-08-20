--EASY

--QUERY 1
--Investigated: Find all records where status is failed.
--Importance: Failed status could indicate malicious behavior such as trying to access a
-- resource that is not allowed.
SELECT *
FROM security_logs
WHERE status = 'failed';

--QUERY 2
--Investigated: Find all records where severity is high or critical.
--Importance: High severity is an indicator that a log is related to a condition that
-- warrants investigation for root cause
SELECT *
FROM security_logs sl
         JOIN event_types et on sl.event_type_id = et.id
WHERE severity IN ('high', 'critical');
--NOTE test data has no records with critical status

--QUERY 3
--Investigated: Find all records where account_status is locked.
--Importance: Accounts may be locked due to many authentication requests indicating
-- a malicious user is trying to steal the account. Also, the system may lock
-- accounts that are causing to many alerts.
SELECT *
FROM security_logs sl
         JOIN users u ON sl.user_id = u.id
WHERE account_status = 'locked';

--QUERY 4
--Investigated: Find all records where watchlist_flag is true.
--Importance: Records identified for watching by other analysts or automated security systems
-- are important to investigate further, and to link to related records.
SELECT *
FROM security_logs
WHERE watchlist_flag = true;

--QUERY 5
--Investigated: List all login events ordered by event_time.
--Importance:  Login events can identify accounts targeted by hackers to be stolen when
-- multiple login events happen.
SELECT *
FROM security_logs
ORDER BY event_time;

--QUERY 6
--Investigated: Find the top 10 records with the highest risk_score.
--Importance:  Sorting your logs by risk score allows an analysts to focus their
-- time investigating incidents that are more likely to be malicious and dangerous.
SELECT *
FROM security_logs sl
ORDER BY risk_score DESC
LIMIT 10;

--QUERY 7
--Investigated: Count how many total records exist for each event_type.
--Importance: Understanding how common or rare an event type is can help indicate whether behavior is expected.

SELECT event_type, count(sl.log_id) as count
FROM event_types et
         LEFT JOIN security_logs sl on et.id = sl.event_type_id
GROUP BY event_type
ORDER BY count DESC;

--MEDIUM

--QUERY 8
--Investigated: Count how many failed events each username has.
--Importance: High failed event counts could indicate a username is being used for malicious activity
SELECT username, count(sl.log_id) as count
FROM users u
         LEFT JOIN security_logs sl ON u.id = sl.user_id
GROUP BY username
ORDER BY count DESC;

--QUERY 9
--Investigated: Count how many records exist for each ip_address.
--Importance: Outliers in this count could indicate automated processes or malicious attempts that
-- are not otherwise manually human driven
SELECT ip_address, count(*) as count
FROM security_logs
GROUP BY ip_address
ORDER BY count DESC;

--QUERY 10
--Investigated: Count how many high or critical events exist for each username.
--Importance: High counts of severe events tied to a particluar username could indicate that account is compromised.
SELECT username, count(et.id) as count
FROM users u
         LEFT JOIN security_logs sl on sl.user_id = u.id
         LEFT JOIN event_types et on et.id = sl.event_type_id
    AND severity IN ('high', 'critical')
GROUP BY username
ORDER BY count DESC;

--QUERY 11
--Investigated: Count how many failed events exist for each device_type.
--Importance: Understanding how common failed events are for a particular device type can help an
-- analyst understand a baseline of event rarity or identify more risky device types
SELECT device_type, count(sl.log_id) as count
FROM devices d
         LEFT JOIN security_logs sl on sl.device_id = d.id
    AND sl.status = 'failed'
GROUP BY device_type
ORDER BY count DESC;


--QUERY 12
--Investigated: Count how many suspicious events exist for each location_country.
--Importance: Understanding where risky events are sourced from can help an analyst start to geolocate
-- risky avenues of approach.

SELECT location_country, count(*) as count
FROM locations l
         LEFT JOIN security_logs sl on l.id = sl.location_id
    AND watchlist_flag = true
GROUP BY location_country
ORDER BY count DESC;

--QUERY 13
--Investigated: Find the most common failure_reason values.
--Importance: Understanding the most common failure reasons can help an analyst understand if an event
-- may have multiple false positives as an indicator of compromised or help identify what is being targeted
-- in their environment.

SELECT failure_reason, count(*) as count
FROM security_logs
WHERE failure_reason IS NOT NULL
GROUP BY failure_reason
ORDER BY count DESC;

--QUERY 14
--Investigated: Count how many records exist for each resource_type.
--Importance: Understanding the most common resource types can help an analyst understand if an event
-- may have multiple false positives as an indicator of compromised or help identify what is being targeted
-- in their environment.
SELECT resource_type, count(*) as count
FROM security_logs
GROUP BY resource_type
ORDER BY count DESC;

--QUERY 15
--Investigated: Count how many records exist for each user_role and event_category combination.
--Importance: This can help an analyst profile roles to understand how frequent errors and risky
-- events are expected to be seen.

SELECT  user_role, event_category, count(sl.log_id) as count
FROM users u
         CROSS JOIN event_types et
         LEFT JOIN security_logs sl on et.id = sl.event_type_id and sl.user_id = u.id
GROUP BY user_role, event_category
ORDER BY count DESC;


--HARD

--QUERY 16
--Investigated: Find ip_address values used by more than one username.
--Importance: This could indicate users logging in from multiple locations, or individuals sharing
-- an account, or worse an account that is used legitimately and by a malicious actor.
SELECT ip_address, count(DISTINCT username) AS "count of username"
FROM security_logs
         JOIN users u on security_logs.user_id = u.id
GROUP BY ip_address
HAVING count(DISTINCT username) > 1;

--QUERY 17
--Investigated: Find usernames with both failed events and high-risk events.
--Importance: A combination of multiple indicators of compromise can help triage which
-- account to investigate first
-- NOTE: I DEFINE HIGH RISK as risk_score > 8
SELECT username,
       count(*) FILTER (WHERE status = 'failed') as failed_count,
       count(*) FILTER ( WHERE risk_score >= 8 )    high_risk_count
FROM security_logs
         JOIN event_types et on security_logs.event_type_id = et.id
         JOIN users u on security_logs.user_id = u.id
GROUP BY username
HAVING count(*) FILTER (WHERE status = 'failed') > 0
   AND count(*) FILTER ( WHERE risk_score >= 8 ) > 0;

--QUERY 18
--Investigated: Find session_id values that contain multiple failed events.
--Importance: Sessiosn with higher counts of failed events are more likely to be malicious
SELECT session_id,
       count(*) FILTER (WHERE status = 'failed') as failed_count
FROM security_logs
         JOIN event_types et on security_logs.event_type_id = et.id
GROUP BY session_id
HAVING count(*) FILTER (WHERE status = 'failed') > 1;


--QUERY 19
--Investigated: Find accounts marked locked or suspended that still show successful activity.
--Importance: Locked accounts that can still complete successful activity could be an indictor of
--misuse
SELECT username, log_id, account_status, status
FROM security_logs sl
         JOIN users u on sl.user_id = u.id
WHERE u.account_status = 'locked'
   or u.account_status = 'suspended'
    AND sl.status = 'success';


--QUERY 20
--Investigated: Find usernames, IP addresses, or sessions where multiple risk indicators appear together (failed status, high severity, watchlist_flag, high risk_score).
--Importance: This query can help an analysts triage which risky identifiers to investigate first based
-- on the total number of risky events.

WITH risky_users AS (SELECT username,
                            NULL                                                                AS ip_address,
                            NUll                                                                AS session_id,
                            count(*) FILTER ( WHERE status = 'failed')                          as failed_status_count,
                            count(*) FILTER ( WHERE severity = 'high' OR severity = 'critical') as high_severity_count,
                            count(*) FILTER ( WHERE watchlist_flag = true)                      as watchlist_flag_count,
                            count(*) FILTER ( WHERE risk_score >= 8)                            as risk_score_count
                     FROM security_logs sl
                              JOIN users u on sl.user_id = u.id
                              JOIN event_types et on sl.event_type_id = et.id
                     GROUP BY username),

     risky_ip_addresses AS (SELECT NULL                                                                AS username,
                                   ip_address                                                          AS ip_address,
                                   NULL                                                                AS session_id,
                                   count(*) FILTER ( WHERE status = 'failed')                          as failed_status_count,
                                   count(*) FILTER ( WHERE severity = 'high' OR severity = 'critical') as high_severity_count,
                                   count(*) FILTER ( WHERE watchlist_flag = true)                      as watchlist_flag_count,
                                   count(*) FILTER ( WHERE risk_score >= 8)                            as risk_score_count
                            FROM security_logs sl
                                     JOIN users u on sl.user_id = u.id
                                     JOIN event_types et on sl.event_type_id = et.id
                            GROUP BY ip_address),

     risky_sessions AS (SELECT NULL                                                                AS username,
                               NULL                                                                AS ip_address,
                               session_id                                                          AS session_id,
                               count(*) FILTER ( WHERE status = 'failed')                          as failed_status_count,
                               count(*) FILTER ( WHERE severity = 'high' OR severity = 'critical') as high_severity_count,
                               count(*) FILTER ( WHERE watchlist_flag = true)                      as watchlist_flag_count,
                               count(*) FILTER ( WHERE risk_score >= 8)                            as risk_score_count
                        FROM security_logs sl
                                 JOIN users u on sl.user_id = u.id
                                 JOIN event_types et on sl.event_type_id = et.id
                        GROUP BY session_id),
     risky_identifiers AS (SELECT *
                           FROM risky_users
                           UNION
                           SELECT *
                           FROM risky_ip_addresses
                           UNION
                           SELECT *
                           FROM risky_sessions)
SELECT *
FROM risky_identifiers
WHERE failed_status_count + high_severity_count + watchlist_flag_count + risk_score_count > 1
ORDER BY username, ip_address, session_id;


-- or more compactly using GROUPING SETS which I just learned about

WITH risky_identifiers AS (SELECT username,
                                  ip_address,
                                  session_id,
                                  count(*) FILTER (WHERE status = 'failed') AS failed_status_count,
                                  count(*) FILTER (
                                      WHERE severity IN ('high', 'critical')
                                      )                                     AS high_severity_count,
                                  count(*) FILTER (WHERE watchlist_flag)    AS watchlist_flag_count,
                                  count(*) FILTER (WHERE risk_score >= 8)   AS risk_score_count
                           FROM security_logs sl
                                    JOIN users u ON sl.user_id = u.id
                                    JOIN event_types et ON sl.event_type_id = et.id
                           GROUP BY GROUPING SETS ( (username),
                                                    (ip_address),
                                                    (session_id)
                               ))
SELECT *,
       failed_status_count
           + high_severity_count
           + watchlist_flag_count
           + risk_score_count AS total_indicators
FROM risky_identifiers
WHERE failed_status_count
          + high_severity_count
          + watchlist_flag_count
          + risk_score_count > 1
ORDER BY total_indicators DESC;
