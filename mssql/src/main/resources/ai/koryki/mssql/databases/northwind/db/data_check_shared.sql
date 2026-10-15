--
-- Self-contained (DROP + CREATE + data), like check_complex. A concept that columns share: three columns
-- of one table hold a position. DuckDB's check_shared (ai/koryki/duckdb/databases/shared) is the
-- blueprint, the catalog is ai/koryki/mssql/databases/shared/db.json. SQL Server has no struct, so a
-- position is a JSON object stored as text (ISJSON as the check, NULL passes) and route a JSON array of
-- them; the concept is stored as JSON.

DROP TABLE IF EXISTS check_shared;

CREATE TABLE check_shared (
    nr     SMALLINT NOT NULL PRIMARY KEY,
    home   VARCHAR(MAX) COLLATE Latin1_General_100_BIN2_UTF8 CHECK (ISJSON(home) = 1),
    work   VARCHAR(MAX) COLLATE Latin1_General_100_BIN2_UTF8 CHECK (ISJSON(work) = 1),
    route  VARCHAR(MAX) COLLATE Latin1_General_100_BIN2_UTF8 CHECK (ISJSON(route) = 1)
);

INSERT INTO check_shared VALUES
    (1, '{"lat": 53.5, "lon": 10.0}', '{"lat": 52.5, "lon": 13.4}',
        '[{"lat": 53.5, "lon": 10.0}, {"lat": 52.5, "lon": 13.4}]');
INSERT INTO check_shared VALUES (2, '{"lat": 48.1, "lon": 11.6}', NULL, '[]');
