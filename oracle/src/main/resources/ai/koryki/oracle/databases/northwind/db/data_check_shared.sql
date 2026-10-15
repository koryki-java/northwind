--
-- Self-contained (DROP + CREATE + data), like check_complex. A concept that columns share: three columns
-- of one table hold a position. DuckDB's check_shared (ai/koryki/duckdb/databases/shared) is the
-- blueprint, the catalog is ai/koryki/oracle/databases/shared/db.json. A struct is an object type here,
-- which has to be created first, and route is a VARRAY of it (ordered, with a maximum).

DROP TABLE IF EXISTS check_shared PURGE;
DROP TYPE IF EXISTS cx_point_list FORCE;
DROP TYPE IF EXISTS cx_point FORCE;

CREATE TYPE cx_point AS OBJECT (lat BINARY_DOUBLE, lon BINARY_DOUBLE);
CREATE TYPE cx_point_list AS VARRAY(100) OF cx_point;

CREATE TABLE check_shared (
    nr     SMALLINT NOT NULL PRIMARY KEY,
    home   cx_point,
    work   cx_point,
    route  cx_point_list
);

INSERT INTO check_shared VALUES (
    1,
    cx_point(53.5, 10.0),
    cx_point(52.5, 13.4),
    cx_point_list(cx_point(53.5, 10.0), cx_point(52.5, 13.4))
);

INSERT INTO check_shared VALUES (
    2,
    cx_point(48.1, 11.6),
    NULL,
    cx_point_list()
);
