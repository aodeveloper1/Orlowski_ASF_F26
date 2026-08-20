
-- ============================================================
-- TEST DATA FOR SECURITY LOGGING DATABASE
-- ============================================================
-- Creates:
--   12 users
--   11 devices
--   10 locations
--    7 event types
--  100 security logs
--
-- ============================================================


-- ============================================================
-- 1. USERS
-- ============================================================

INSERT INTO users
(id, username, user_role, account_status)
    OVERRIDING SYSTEM VALUE
VALUES (1, 'alice_vendor', 'vendor', 'active'),
       (2, 'bob_buyer', 'buyer', 'active'),
       (3, 'carol_admin', 'admin', 'active'),
       (4, 'dave_analyst', 'analyst', 'active'),
       (5, 'erin_moderator', 'moderator', 'active'),
       (6, 'frank_guest', 'guest', 'active'),
       (7, 'grace_vendor', 'vendor', 'active'),
       (8, 'heidi_buyer', 'buyer', 'active'),
       (9, 'ivan_locked', 'admin', 'locked'),
       (10, 'judy_suspended', 'buyer', 'suspended'),
       (11, 'mallory_guest', 'guest', 'active'),
       (12, 'nina_analyst', 'analyst', 'pending');


-- ============================================================
-- 2. DEVICES
-- ============================================================

INSERT INTO devices
(id, device_type, operating_system, browser_name)
    OVERRIDING SYSTEM VALUE
VALUES (1, 'desktop', 'Windows', 'Chrome'),
       (2, 'desktop', 'Windows', 'Edge'),
       (3, 'desktop', 'macOS', 'Safari'),
       (4, 'desktop', 'Linux', 'Firefox'),
       (5, 'mobile', 'Android', 'Chrome'),
       (6, 'mobile', 'iOS', 'Safari'),
       (7, 'tablet', 'Android', 'Chrome'),
       (8, 'tablet', 'iOS', 'Safari'),
       (9, 'kiosk', 'Linux', 'Firefox'),
       (10, 'server', 'Linux', 'Firefox'),
       (11, 'desktop', 'Linux', 'Tor');


-- ============================================================
-- 3. LOCATIONS
-- ============================================================

INSERT INTO locations
(id, location_city, location_region, location_country)
    OVERRIDING SYSTEM VALUE
VALUES (1, 'Austin', 'Texas', 'USA'),
       (2, 'Dallas', 'Texas', 'USA'),
       (3, 'New York', 'New York', 'USA'),
       (4, 'Toronto', 'Ontario', 'Canada'),
       (5, 'London', 'England', 'UK'),
       (6, 'Berlin', 'Berlin', 'Germany'),
       (7, 'Singapore', 'Singapore', 'Singapore'),
       (8, 'Sao Paulo', 'Sao Paulo', 'Brazil'),
       (9, 'Mumbai', 'Maharashtra', 'India'),
       (10, 'Unknown', 'Unknown', 'Unknown');


-- ============================================================
-- 4. EVENT TYPES
-- ============================================================

INSERT INTO event_types
(id, event_type, event_category, severity)
    OVERRIDING SYSTEM VALUE
VALUES (1, 'login', 'authentication', 'low'),
       (2, 'logout', 'authentication', 'low'),
       (3, 'password_change', 'authentication', 'medium'),
       (4, 'purchase', 'transaction', 'low'),
       (5, 'file_access', 'system', 'medium'),
       (6, 'account_update', 'user_management', 'medium'),
       (7, 'admin_action', 'security', 'high');


-- ============================================================
-- 5. SECURITY LOGS
-- ============================================================

INSERT INTO security_logs
(event_time,
 user_id,
 device_id,
 location_id,
 event_type_id,
 ip_address,
 port_number,
 session_id,
 action_taken,
 status,
 resource_type,
 resource_name,
 failure_reason,
 risk_score,
 watchlist_flag)
VALUES

-- ============================================================
-- NORMAL ACTIVITY: 1-50
-- ============================================================

('2026-08-01 08:00:00-05', 1, 1, 1, 1, '10.10.10.10', 443, 'SESSION-001', 'allow', 'success', 'user_account',
 'account-profile', NULL, 1.20, false),
('2026-08-01 08:37:00-05', 2, 5, 1, 1, '10.10.10.11', 443, 'SESSION-002', 'allow', 'success', 'user_account',
 'account-profile', NULL, 1.45, false),
('2026-08-01 09:14:00-05', 3, 2, 2, 7, '10.10.10.12', 443, 'SESSION-003', 'allow', 'success', 'admin_panel',
 'admin-dashboard', NULL, 2.10, false),
('2026-08-01 09:51:00-05', 4, 4, 1, 5, '10.10.10.13', 443, 'SESSION-004', 'allow', 'success', 'file_storage',
 'shared-documents', NULL, 2.30, false),
('2026-08-01 10:28:00-05', 5, 1, 3, 1, '10.10.10.14', 443, 'SESSION-005', 'allow', 'success', 'user_account',
 'account-profile', NULL, 1.75, false),
('2026-08-01 11:05:00-05', 6, 6, 4, 4, '10.10.10.15', 443, 'SESSION-006', 'allow', 'success', 'transaction_record',
 'transaction-1001', NULL, 2.50, false),
('2026-08-01 11:42:00-05', 7, 3, 1, 2, '10.10.10.10', 443, 'SESSION-007', 'allow', 'success', 'user_account',
 'account-profile', NULL, 1.10, false),
('2026-08-01 12:19:00-05', 8, 5, 2, 4, '10.10.10.11', 443, 'SESSION-008', 'allow', 'success', 'transaction_record',
 'transaction-1002', NULL, 2.70, false),

-- Locked/suspended accounts with successful activity
('2026-08-01 12:56:00-05', 9, 1, 1, 1, '10.10.10.12', 443, 'SESSION-009', 'allow', 'success', 'user_account',
 'account-profile', NULL, 3.20, false),
('2026-08-01 13:33:00-05', 10, 6, 1, 4, '10.10.10.13', 443, 'SESSION-010', 'allow', 'success', 'transaction_record',
 'transaction-1003', NULL, 3.40, false),

('2026-08-01 14:10:00-05', 11, 2, 3, 6, '10.10.10.14', 443, 'SESSION-011', 'allow', 'success', 'user_account',
 'account-profile', NULL, 2.00, false),
('2026-08-01 14:47:00-05', 12, 4, 1, 3, '10.10.10.15', 443, 'SESSION-012', 'allow', 'success', 'user_account',
 'account-profile', NULL, 2.80, false),
('2026-08-01 15:24:00-05', 1, 1, 2, 4, '10.10.10.10', 443, 'SESSION-013', 'allow', 'success', 'transaction_record',
 'transaction-1004', NULL, 2.20, false),
('2026-08-01 16:01:00-05', 2, 5, 3, 5, '10.10.10.11', 443, 'SESSION-014', 'allow', 'success', 'file_storage',
 'shared-documents', NULL, 2.60, false),
('2026-08-01 16:38:00-05', 3, 2, 1, 2, '10.10.10.12', 443, 'SESSION-015', 'allow', 'success', 'user_account',
 'account-profile', NULL, 1.30, false),
('2026-08-01 17:15:00-05', 4, 4, 4, 4, '10.10.10.13', 443, 'SESSION-016', 'allow', 'success', 'transaction_record',
 'transaction-1005', NULL, 2.90, false),
('2026-08-01 17:52:00-05', 5, 1, 1, 1, '10.10.10.14', 443, 'SESSION-017', 'allow', 'success', 'user_account',
 'account-profile', NULL, 1.60, false),
('2026-08-01 18:29:00-05', 6, 6, 2, 5, '10.10.10.15', 443, 'SESSION-018', 'allow', 'success', 'file_storage',
 'shared-documents', NULL, 2.40, false),
('2026-08-01 19:06:00-05', 7, 3, 1, 1, '10.10.10.10', 443, 'SESSION-019', 'allow', 'success', 'user_account',
 'account-profile', NULL, 1.40, false),
('2026-08-01 19:43:00-05', 8, 5, 2, 4, '10.10.10.11', 443, 'SESSION-020', 'allow', 'success', 'transaction_record',
 'transaction-1006', NULL, 2.80, false),

('2026-08-01 20:20:00-05', 9, 1, 1, 1, '10.10.10.12', 443, 'SESSION-021', 'allow', 'success', 'user_account',
 'account-profile', NULL, 3.10, false),
('2026-08-01 20:57:00-05', 10, 6, 2, 1, '10.10.10.13', 443, 'SESSION-022', 'allow', 'success', 'user_account',
 'account-profile', NULL, 3.30, false),
('2026-08-01 21:34:00-05', 11, 2, 3, 4, '10.10.10.14', 443, 'SESSION-023', 'allow', 'success', 'transaction_record',
 'transaction-1007', NULL, 2.10, false),
('2026-08-01 22:11:00-05', 12, 4, 1, 5, '10.10.10.15', 443, 'SESSION-024', 'allow', 'success', 'file_storage',
 'shared-documents', NULL, 2.90, false),
('2026-08-01 22:48:00-05', 1, 1, 2, 6, '10.10.10.10', 443, 'SESSION-025', 'allow', 'success', 'user_account',
 'account-profile', NULL, 2.30, false),

('2026-08-02 08:25:00-05', 2, 5, 1, 1, '10.10.10.11', 443, 'SESSION-026', 'allow', 'success', 'user_account',
 'account-profile', NULL, 1.70, false),
('2026-08-02 09:02:00-05', 3, 2, 2, 7, '10.10.10.12', 443, 'SESSION-027', 'allow', 'success', 'admin_panel',
 'admin-dashboard', NULL, 2.50, false),
('2026-08-02 09:39:00-05', 4, 4, 3, 4, '10.10.10.13', 443, 'SESSION-028', 'allow', 'success', 'transaction_record',
 'transaction-1008', NULL, 2.60, false),
('2026-08-02 10:16:00-05', 5, 1, 1, 1, '10.10.10.14', 443, 'SESSION-029', 'allow', 'success', 'user_account',
 'account-profile', NULL, 1.80, false),
('2026-08-02 10:53:00-05', 6, 6, 4, 5, '10.10.10.15', 443, 'SESSION-030', 'allow', 'success', 'file_storage',
 'shared-documents', NULL, 2.30, false),

('2026-08-02 11:30:00-05', 7, 3, 1, 4, '10.10.10.10', 443, 'SESSION-031', 'allow', 'success', 'transaction_record',
 'transaction-1009', NULL, 2.70, false),
('2026-08-02 12:07:00-05', 8, 5, 2, 1, '10.10.10.11', 443, 'SESSION-032', 'allow', 'success', 'user_account',
 'account-profile', NULL, 1.50, false),
('2026-08-02 12:44:00-05', 9, 1, 1, 5, '10.10.10.12', 443, 'SESSION-033', 'allow', 'success', 'file_storage',
 'shared-documents', NULL, 3.00, false),
('2026-08-02 13:21:00-05', 10, 6, 2, 6, '10.10.10.13', 443, 'SESSION-034', 'allow', 'success', 'user_account',
 'account-profile', NULL, 3.20, false),
('2026-08-02 13:58:00-05', 11, 2, 3, 2, '10.10.10.14', 443, 'SESSION-035', 'allow', 'success', 'user_account',
 'account-profile', NULL, 1.90, false),
('2026-08-02 14:35:00-05', 12, 4, 1, 3, '10.10.10.15', 443, 'SESSION-036', 'allow', 'success', 'user_account',
 'account-profile', NULL, 2.40, false),
('2026-08-02 15:12:00-05', 1, 1, 2, 4, '10.10.10.10', 443, 'SESSION-037', 'allow', 'success', 'transaction_record',
 'transaction-1010', NULL, 2.50, false),
('2026-08-02 15:49:00-05', 2, 5, 3, 5, '10.10.10.11', 443, 'SESSION-038', 'allow', 'success', 'file_storage',
 'shared-documents', NULL, 2.80, false),
('2026-08-02 16:26:00-05', 3, 2, 1, 1, '10.10.10.12', 443, 'SESSION-039', 'allow', 'success', 'user_account',
 'account-profile', NULL, 1.20, false),
('2026-08-02 17:03:00-05', 4, 4, 4, 4, '10.10.10.13', 443, 'SESSION-040', 'allow', 'success', 'transaction_record',
 'transaction-1011', NULL, 2.60, false),

('2026-08-02 17:40:00-05', 5, 1, 1, 1, '10.10.10.14', 443, 'SESSION-041', 'allow', 'success', 'user_account',
 'account-profile', NULL, 1.40, false),
('2026-08-02 18:17:00-05', 6, 6, 2, 4, '10.10.10.15', 443, 'SESSION-042', 'allow', 'success', 'transaction_record',
 'transaction-1012', NULL, 2.90, false),
('2026-08-02 18:54:00-05', 7, 3, 1, 5, '10.10.10.10', 443, 'SESSION-043', 'allow', 'success', 'file_storage',
 'shared-documents', NULL, 2.20, false),
('2026-08-02 19:31:00-05', 8, 5, 2, 1, '10.10.10.11', 443, 'SESSION-044', 'allow', 'success', 'user_account',
 'account-profile', NULL, 1.60, false),
('2026-08-02 20:08:00-05', 9, 1, 1, 1, '10.10.10.12', 443, 'SESSION-045', 'allow', 'success', 'user_account',
 'account-profile', NULL, 3.50, false),
('2026-08-02 20:45:00-05', 10, 6, 2, 4, '10.10.10.13', 443, 'SESSION-046', 'allow', 'success', 'transaction_record',
 'transaction-1013', NULL, 3.70, false),
('2026-08-02 21:22:00-05', 11, 2, 3, 6, '10.10.10.14', 443, 'SESSION-047', 'allow', 'success', 'user_account',
 'account-profile', NULL, 2.10, false),
('2026-08-02 21:59:00-05', 12, 4, 1, 5, '10.10.10.15', 443, 'SESSION-048', 'allow', 'success', 'file_storage',
 'shared-documents', NULL, 2.50, false),
('2026-08-02 22:36:00-05', 1, 1, 2, 1, '10.10.10.10', 443, 'SESSION-049', 'allow', 'success', 'user_account',
 'account-profile', NULL, 1.80, false),
('2026-08-02 23:13:00-05', 2, 5, 3, 4, '10.10.10.11', 443, 'SESSION-050', 'allow', 'success', 'transaction_record',
 'transaction-1014', NULL, 2.40, false),

-- ============================================================
-- FAILED / SUSPICIOUS ACTIVITY: 51-100
-- ============================================================

('2026-08-03 08:00:00-05', 3, 2, 1, 1, '10.10.10.12', 443, 'FAIL-001', 'deny', 'failed', 'user_account',
 'account-profile', 'invalid_password', 5.20, false),
('2026-08-03 08:37:00-05', 3, 2, 1, 1, '10.10.10.12', 443, 'FAIL-001', 'deny', 'failed', 'user_account',
 'account-profile', 'invalid_password', 5.40, false),
('2026-08-03 09:14:00-05', 4, 4, 2, 1, '10.10.10.13', 443, 'FAIL-002', 'deny', 'failed', 'user_account',
 'account-profile', 'invalid_username', 5.10, false),
('2026-08-03 09:51:00-05', 5, 1, 3, 5, '10.10.10.14', 443, 'FAIL-003', 'deny', 'failed', 'file_storage',
 'sensitive-file', 'insufficient_permissions', 6.20, true),
('2026-08-03 10:28:00-05', 6, 6, 4, 1, '10.10.10.15', 443, 'FAIL-004', 'deny', 'failed', 'user_account',
 'account-profile', 'invalid_password', 5.30, false),
('2026-08-03 11:05:00-05', 7, 3, 1, 7, '10.10.10.10', 443, 'ADMIN-001', 'flag', 'blocked', 'admin_panel',
 'admin-dashboard', 'suspicious_activity', 7.80, true),
('2026-08-03 11:42:00-05', 8, 5, 2, 1, '10.10.10.11', 443, 'FAIL-005', 'deny', 'failed', 'user_account',
 'account-profile', 'invalid_password', 5.70, false),
('2026-08-03 12:19:00-05', 11, 2, 3, 4, '10.10.10.14', 443, 'FAIL-006', 'deny', 'failed', 'transaction_record',
 'transaction-2001', 'insufficient_permissions', 6.40, true),
('2026-08-03 12:56:00-05', 12, 4, 1, 1, '10.10.10.15', 443, 'FAIL-007', 'deny', 'failed', 'user_account',
 'account-profile', 'timeout', 4.90, false),
('2026-08-03 13:33:00-05', 1, 1, 2, 5, '10.10.10.10', 443, 'FAIL-008', 'deny', 'failed', 'file_storage',
 'restricted-file', 'insufficient_permissions', 6.70, true),

('2026-08-03 14:10:00-05', 2, 5, 3, 1, '10.10.10.11', 443, 'FAIL-009', 'deny', 'failed', 'user_account',
 'account-profile', 'invalid_password', 5.60, false),
('2026-08-03 14:47:00-05', 3, 2, 1, 7, '10.10.10.12', 443, 'ADMIN-002', 'flag', 'blocked', 'admin_panel',
 'admin-dashboard', 'suspicious_activity', 8.10, true),
('2026-08-03 15:24:00-05', 4, 4, 4, 4, '10.10.10.13', 443, 'FAIL-010', 'deny', 'failed', 'transaction_record',
 'transaction-2002', 'suspicious_activity', 7.10, true),
('2026-08-03 16:01:00-05', 5, 1, 1, 1, '10.10.10.14', 443, 'FAIL-011', 'deny', 'failed', 'user_account',
 'account-profile', 'invalid_username', 5.80, false),
('2026-08-03 16:38:00-05', 6, 6, 2, 5, '10.10.10.15', 443, 'FAIL-012', 'deny', 'failed', 'file_storage',
 'restricted-file', 'suspicious_activity', 7.40, true),
('2026-08-03 17:15:00-05', 7, 3, 1, 1, '10.10.10.10', 443, 'FAIL-013', 'deny', 'failed', 'user_account',
 'account-profile', 'invalid_password', 5.50, false),
('2026-08-03 17:52:00-05', 8, 5, 2, 7, '10.10.10.11', 443, 'ADMIN-003', 'flag', 'blocked', 'admin_panel',
 'admin-dashboard', 'suspicious_activity', 8.30, true),
('2026-08-03 18:29:00-05', 11, 2, 3, 1, '10.10.10.14', 443, 'FAIL-014', 'deny', 'failed', 'user_account',
 'account-profile', 'invalid_password', 5.90, false),
('2026-08-03 19:06:00-05', 12, 4, 1, 5, '10.10.10.15', 443, 'FAIL-015', 'deny', 'failed', 'file_storage',
 'restricted-file', 'insufficient_permissions', 6.10, true),
('2026-08-03 19:43:00-05', 1, 1, 2, 4, '10.10.10.10', 443, 'FAIL-016', 'deny', 'failed', 'transaction_record',
 'transaction-2003', 'suspicious_activity', 7.60, true),

('2026-08-03 20:20:00-05', 2, 5, 3, 1, '10.10.10.11', 443, 'FAIL-017', 'deny', 'failed', 'user_account',
 'account-profile', 'invalid_password', 5.40, false),
('2026-08-03 20:57:00-05', 3, 2, 1, 7, '10.10.10.12', 443, 'ADMIN-004', 'flag', 'blocked', 'admin_panel',
 'admin-dashboard', 'suspicious_activity', 8.70, true),
('2026-08-03 21:34:00-05', 4, 4, 4, 1, '10.10.10.13', 443, 'FAIL-018', 'deny', 'failed', 'user_account',
 'account-profile', 'invalid_username', 5.30, false),
('2026-08-03 22:11:00-05', 5, 1, 1, 5, '10.10.10.14', 443, 'FAIL-019', 'deny', 'failed', 'file_storage',
 'restricted-file', 'suspicious_activity', 7.90, true),
('2026-08-03 22:48:00-05', 6, 6, 2, 4, '10.10.10.15', 443, 'FAIL-020', 'deny', 'failed', 'transaction_record',
 'transaction-2004', 'suspicious_activity', 7.20, true),
('2026-08-03 23:25:00-05', 7, 3, 1, 1, '10.10.10.10', 443, 'FAIL-021', 'deny', 'failed', 'user_account',
 'account-profile', 'invalid_password', 5.70, false),
('2026-08-04 08:02:00-05', 8, 5, 2, 7, '10.10.10.11', 443, 'ADMIN-005', 'flag', 'blocked', 'admin_panel',
 'admin-dashboard', 'suspicious_activity', 8.90, true),
('2026-08-04 08:39:00-05', 11, 2, 3, 1, '10.10.10.14', 443, 'FAIL-022', 'deny', 'failed', 'user_account',
 'account-profile', 'invalid_password', 5.80, false),
('2026-08-04 09:16:00-05', 12, 4, 1, 5, '10.10.10.15', 443, 'FAIL-023', 'deny', 'failed', 'file_storage',
 'restricted-file', 'suspicious_activity', 7.70, true),
('2026-08-04 09:53:00-05', 1, 1, 2, 4, '10.10.10.10', 443, 'FAIL-024', 'deny', 'failed', 'transaction_record',
 'transaction-2005', 'suspicious_activity', 8.20, true),

-- ============================================================
-- MULTIPLE FAILED EVENTS IN SAME SESSION
-- ============================================================

('2026-08-04 10:30:00-05', 1, 11, 6, 1, '203.0.113.250', 22, 'SUSP-SESSION-001', 'block', 'failed', 'api_endpoint',
 'api/v1/auth', 'suspicious_activity', 9.10, true),
('2026-08-04 10:31:00-05', 1, 11, 6, 1, '203.0.113.250', 22, 'SUSP-SESSION-001', 'block', 'failed', 'api_endpoint',
 'api/v1/auth', 'suspicious_activity', 9.35, true),
('2026-08-04 10:32:00-05', 1, 11, 6, 7, '203.0.113.250', 22, 'SUSP-SESSION-001', 'block', 'failed', 'admin_panel',
 'admin-dashboard', 'suspicious_activity', 9.70, true),

('2026-08-04 11:09:00-05', 3, 11, 7, 1, '203.0.113.251', 22, 'SUSP-SESSION-002', 'block', 'failed', 'api_endpoint',
 'api/v1/auth', 'suspicious_activity', 8.85, true),
('2026-08-04 11:10:00-05', 3, 11, 7, 7, '203.0.113.251', 22, 'SUSP-SESSION-002', 'block', 'failed', 'admin_panel',
 'admin-dashboard', 'suspicious_activity', 9.55, true),

-- ============================================================
-- LOCKED ACCOUNT SUSPICIOUS ACTIVITY
-- ============================================================

('2026-08-04 11:47:00-05', 9, 11, 8, 1, '198.51.100.99', 22, 'SUSP-SESSION-003', 'deny', 'failed', 'api_endpoint',
 'api/v1/auth', 'account_locked', 8.75, true),
('2026-08-04 11:48:00-05', 9, 11, 8, 7, '198.51.100.99', 22, 'SUSP-SESSION-003', 'deny', 'failed', 'admin_panel',
 'admin-dashboard', 'account_locked', 9.25, true),

-- ============================================================
-- SUSPENDED ACCOUNT SUSPICIOUS ACTIVITY
-- ============================================================

('2026-08-04 12:25:00-05', 10, 11, 9, 1, '198.51.100.100', 22, 'SUSP-SESSION-004', 'block', 'blocked', 'api_endpoint',
 'api/v1/auth', 'suspicious_activity', 8.65, true),
('2026-08-04 12:26:00-05', 10, 11, 9, 5, '198.51.100.100', 22, 'SUSP-SESSION-004', 'block', 'blocked', 'file_storage',
 'sensitive-financial-data', 'suspicious_activity', 9.80, true),

-- ============================================================
-- FINAL MULTI-INDICATOR EVENT
-- ============================================================

('2026-08-04 13:03:00-05', 1, 11, 6, 7, '203.0.113.250', 22, 'SUSP-SESSION-001', 'alert', 'success', 'admin_panel',
 'admin-dashboard', 'insufficient_permissions', 10.00, true),

--========================
-- ADD MORE LOGS TO GET TO 100
--========================
('2026-08-04 13:40:00-05', 4, 4, 2, 1, '203.0.113.250', 443, 'SUSP-SESSION-005', 'deny', 'failed', 'user_account',
 'account-profile', 'invalid_password', 6.80, true),
('2026-08-04 14:17:00-05', 5, 1, 3, 7, '203.0.113.252', 22, 'SUSP-SESSION-006', 'block', 'blocked', 'admin_panel',
 'admin-dashboard', 'suspicious_activity', 9.40, true),
('2026-08-04 14:54:00-05', 9, 11, 8, 1, '198.51.100.99', 22, 'SUSP-SESSION-003', 'deny', 'failed', 'api_endpoint',
 'api/v1/auth', 'account_locked', 9.60, true),
('2026-08-04 15:31:00-05', 10, 11, 9, 7, '198.51.100.100', 22, 'SUSP-SESSION-004', 'block', 'blocked', 'admin_panel',
 'admin-dashboard', 'suspicious_activity', 9.90, true),
('2026-08-04 16:08:00-05', 6, 6, 4, 5, '203.0.113.253', 443, 'FAIL-025', 'deny', 'failed', 'file_storage',
 'restricted-file', 'insufficient_permissions', 6.50, true),
('2026-08-04 16:45:00-05', 7, 3, 1, 1, '10.10.10.10', 443, 'FAIL-026', 'deny', 'failed', 'user_account',
 'account-profile', 'invalid_password', 5.90, false),
('2026-08-04 17:22:00-05', 8, 5, 2, 4, '203.0.113.254', 443, 'FAIL-027', 'deny', 'failed', 'transaction_record',
 'transaction-2006', 'suspicious_activity', 7.85, true),
('2026-08-04 17:59:00-05', 3, 2, 1, 7, '203.0.113.250', 22, 'SUSP-SESSION-001', 'alert', 'success', 'admin_panel',
 'admin-dashboard', 'insufficient_permissions', 9.85, true),
('2026-08-04 18:36:00-05', 11, 2, 3, 1, '10.10.10.14', 443, 'FAIL-028', 'deny', 'failed', 'user_account',
 'account-profile', 'invalid_username', 5.25, false),
('2026-08-04 19:13:00-05', 12, 4, 1, 5, '203.0.113.255', 22, 'SUSP-SESSION-007', 'block', 'failed', 'file_storage',
 'sensitive-financial-data', 'suspicious_activity', 9.75, true);


