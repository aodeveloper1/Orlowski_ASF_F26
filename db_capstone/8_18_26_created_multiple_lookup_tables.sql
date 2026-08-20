CREATE TABLE users
(
    id             BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username       VARCHAR(100) UNIQUE NOT NULL,
    user_role      VARCHAR(50)         NOT NULL
        CHECK (user_role IN ('vendor', 'buyer', 'admin', 'analyst', 'moderator', 'guest')),
    account_status VARCHAR(30)         NOT NULL
        CHECK (account_status IN ('active', 'locked', 'suspended', 'disabled', 'pending'))
);


CREATE TABLE devices
(
    id               BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    device_type      VARCHAR(50),
    operating_system VARCHAR(100),
    browser_name     VARCHAR(100),
    UNIQUE (device_type, operating_system, browser_name)
);

CREATE TABLE locations
(
    id               BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    location_city    VARCHAR(100),
    location_region  VARCHAR(100),
    location_country VARCHAR(100),
    UNIQUE (location_city, location_region, location_country)
);


CREATE TABLE event_types
(
    id             BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    event_type     VARCHAR(100) UNIQUE NOT NULL,
    event_category VARCHAR(100),
    severity       VARCHAR(30)
);

CREATE TABLE security_logs
(
    log_id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    event_time     TIMESTAMPTZ NOT NULL,

    user_id        BIGINT REFERENCES users (id),
    device_id      BIGINT REFERENCES devices (id),
    location_id    BIGINT REFERENCES locations (id),
    event_type_id  BIGINT REFERENCES event_types (id),

    ip_address     VARCHAR(50),
    port_number    INT,
    session_id     VARCHAR(200),

    action_taken   VARCHAR(100),
    status         VARCHAR(50),

    resource_type  VARCHAR(100),
    resource_name  VARCHAR(200),

    failure_reason VARCHAR(100),

    risk_score     DECIMAL(4, 2)
        CHECK (risk_score BETWEEN 0 AND 10),
    watchlist_flag BOOLEAN,
    notes          TEXT
);
