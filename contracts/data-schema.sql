-- =====================================================================
-- Data Schema Contract
-- status: Draft
-- Description: This file is the "deterministic anchor". The data model in the code
--       must be fully consistent with this file.
--       When rebuilding the code, generate the ORM/migration based on this file.
-- =====================================================================

-- ⚠️ Example — delete when starting real content: the users/devices/telemetry below are format demonstrations; replace this entire section with your own data model when starting a real project.

CREATE TABLE users (
    id          INTEGER PRIMARY KEY,
    email       TEXT NOT NULL UNIQUE,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE devices (
    id          INTEGER PRIMARY KEY,
    user_id     INTEGER NOT NULL REFERENCES users(id),
    serial_no   TEXT NOT NULL UNIQUE,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE telemetry (
    id          INTEGER PRIMARY KEY,
    device_id   INTEGER NOT NULL REFERENCES devices(id),
    ts          TIMESTAMP NOT NULL,
    value       REAL NOT NULL
);

CREATE INDEX idx_telemetry_device_ts ON telemetry(device_id, ts);
