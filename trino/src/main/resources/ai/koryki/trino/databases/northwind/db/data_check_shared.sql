--
-- A concept that columns share: three columns of one table hold a position. DuckDB's check_shared
-- (ai/koryki/duckdb/databases/shared) is the blueprint, the catalog is
-- ai/koryki/trino/databases/shared/db.json. Like check_complex it lives in the memory catalog and is
-- forgotten when Trino restarts: run this script again (./gradlew :trino:createDatabase).

DROP TABLE IF EXISTS check_shared;

CREATE TABLE check_shared (
    nr     SMALLINT,
    home   ROW(lat DOUBLE, lon DOUBLE),
    work   ROW(lat DOUBLE, lon DOUBLE),
    route  ARRAY(ROW(lat DOUBLE, lon DOUBLE))
);

INSERT INTO check_shared VALUES (
    1,
    CAST(ROW(53.5, 10.0) AS ROW(lat DOUBLE, lon DOUBLE)),
    CAST(ROW(52.5, 13.4) AS ROW(lat DOUBLE, lon DOUBLE)),
    CAST(ARRAY[ROW(53.5, 10.0), ROW(52.5, 13.4)] AS ARRAY(ROW(lat DOUBLE, lon DOUBLE)))
);
INSERT INTO check_shared VALUES (
    2,
    CAST(ROW(48.1, 11.6) AS ROW(lat DOUBLE, lon DOUBLE)),
    NULL,
    CAST(ARRAY[] AS ARRAY(ROW(lat DOUBLE, lon DOUBLE)))
);
