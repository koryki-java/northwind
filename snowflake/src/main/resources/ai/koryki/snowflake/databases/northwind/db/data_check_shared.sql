--
-- Self-contained (DROP + CREATE + data), like check_complex. A concept that columns share: three columns
-- of one table hold a position. DuckDB's check_shared (ai/koryki/duckdb/databases/shared) is the
-- blueprint, the catalog is ai/koryki/snowflake/databases/shared/db.json. A struct is a structured
-- OBJECT here, and route an ARRAY of them. OBJECT_CONSTRUCT_KEEP_NULL, as in check_complex, so that no
-- field is dropped.

DROP TABLE IF EXISTS check_shared;

CREATE TABLE check_shared (
    nr     SMALLINT NOT NULL PRIMARY KEY,
    home   OBJECT(lat DOUBLE, lon DOUBLE),
    work   OBJECT(lat DOUBLE, lon DOUBLE),
    route  ARRAY(OBJECT(lat DOUBLE, lon DOUBLE))
);

INSERT INTO check_shared
SELECT
    1,
    (OBJECT_CONSTRUCT_KEEP_NULL('lat', 53.5, 'lon', 10.0))::OBJECT(lat DOUBLE, lon DOUBLE),
    (OBJECT_CONSTRUCT_KEEP_NULL('lat', 52.5, 'lon', 13.4))::OBJECT(lat DOUBLE, lon DOUBLE),
    (ARRAY_CONSTRUCT(OBJECT_CONSTRUCT_KEEP_NULL('lat', 53.5, 'lon', 10.0), OBJECT_CONSTRUCT_KEEP_NULL('lat', 52.5, 'lon', 13.4)))::ARRAY(OBJECT(lat DOUBLE, lon DOUBLE));

INSERT INTO check_shared
SELECT
    2,
    (OBJECT_CONSTRUCT_KEEP_NULL('lat', 48.1, 'lon', 11.6))::OBJECT(lat DOUBLE, lon DOUBLE),
    NULL,
    (ARRAY_CONSTRUCT())::ARRAY(OBJECT(lat DOUBLE, lon DOUBLE));
