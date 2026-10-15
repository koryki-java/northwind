--
-- Self-contained (DROP + CREATE + data), like check_complex. A concept that columns share: three columns
-- of one table hold a position. DuckDB's check_shared (ai/koryki/duckdb/databases/shared) is the
-- blueprint, the catalog is ai/koryki/mariadb/databases/shared/db.json. MariaDB has no struct, so a
-- position is a JSON object and route a JSON array of them; the concept is stored as JSON.

DROP TABLE IF EXISTS check_shared;

CREATE TABLE check_shared (
    nr     SMALLINT NOT NULL PRIMARY KEY,
    home   JSON,
    work   JSON,
    route  JSON
);

INSERT INTO check_shared VALUES
    (1, '{"lat": 53.5, "lon": 10.0}', '{"lat": 52.5, "lon": 13.4}',
        '[{"lat": 53.5, "lon": 10.0}, {"lat": 52.5, "lon": 13.4}]'),
    (2, '{"lat": 48.1, "lon": 11.6}', NULL, '[]');
