--
-- Self-contained (DROP + CREATE + data), like check_complex. A concept that columns share: three columns
-- of one table hold a position. DuckDB's check_shared (ai/koryki/duckdb/databases/shared) is the
-- blueprint, the catalog is ai/koryki/postgresql/databases/shared/db.json. A struct is a composite type
-- here, which has to be created first; route is an array of it.

DROP TABLE IF EXISTS check_shared;
DROP TYPE IF EXISTS cx_point;

CREATE TYPE cx_point AS (lat DOUBLE PRECISION, lon DOUBLE PRECISION);

CREATE TABLE check_shared (
    nr     SMALLINT NOT NULL PRIMARY KEY,
    home   cx_point,
    work   cx_point,
    route  cx_point[]
);

INSERT INTO check_shared VALUES (
    1,
    ROW(53.5, 10.0)::cx_point,
    ROW(52.5, 13.4)::cx_point,
    ARRAY[ROW(53.5, 10.0)::cx_point, ROW(52.5, 13.4)::cx_point]
);
INSERT INTO check_shared VALUES (
    2,
    ROW(48.1, 11.6)::cx_point,
    NULL,
    ARRAY[]::cx_point[]
);
