--
-- The complex-types test bed for Trino: DuckDB's check_complex (ai/koryki/duckdb/databases/northwind)
-- is the blueprint, the catalog is ai/koryki/trino/databases/complex/db.json.
--
-- Trino has every shape natively: ARRAY(T), ROW(name T, ...) for a struct, MAP(K, V), JSON; a list of
-- lists is a real list of lists. Only the fixed-size array is missing (a list of three). The table
-- lives in the memory catalog, because the catalog the other Northwind tables sit in is the MariaDB
-- connector, which has no nested types. The memory connector forgets its tables when Trino
-- restarts: run this script again (./gradlew :trino:createDatabase).

DROP TABLE IF EXISTS check_complex;

CREATE TABLE check_complex (
    nr       SMALLINT,
    tags     ARRAY(VARCHAR),
    scores   ARRAY(INTEGER),
    vec      ARRAY(DOUBLE),
    matrix   ARRAY(ARRAY(DOUBLE)),
    dims     ROW(w DOUBLE, h DOUBLE),
    address  ROW(street VARCHAR, geo ROW(lat DOUBLE, lon DOUBLE), phones ARRAY(VARCHAR)),
    attrs    MAP(VARCHAR, VARCHAR),
    counts   MAP(VARCHAR, INTEGER),
    lookup   MAP(INTEGER, VARCHAR),
    items    ARRAY(ROW(sku VARCHAR, qty INTEGER, price DECIMAL(10,2), opts ARRAY(VARCHAR))),
    events   ARRAY(ROW(ts TIMESTAMP(3), day DATE)),
    deep     ARRAY(MAP(VARCHAR, ROW(a ARRAY(INTEGER), b MAP(INTEGER, ARRAY(VARCHAR))))),
    doc      JSON,
    odd      ROW("Odd Name" INTEGER, x INTEGER)
);

INSERT INTO check_complex VALUES (
    1,
    CAST(ARRAY['red', 'green', 'blue'] AS ARRAY(VARCHAR)),
    CAST(ARRAY[10, 20, 30] AS ARRAY(INTEGER)),
    CAST(ARRAY[1.0, 2.0, 3.0] AS ARRAY(DOUBLE)),
    CAST(ARRAY[ARRAY[1.0, 2.0, 3.0], ARRAY[4.0, 5.0, 6.0]] AS ARRAY(ARRAY(DOUBLE))),
    CAST(ROW(1.5, 2.5) AS ROW(w DOUBLE, h DOUBLE)),
    CAST(ROW('Main St 1', ROW(52.52, 13.405), ARRAY['+49 30 1', '+49 30 2']) AS ROW(street VARCHAR, geo ROW(lat DOUBLE, lon DOUBLE), phones ARRAY(VARCHAR))),
    CAST(MAP(ARRAY['color', 'size'], ARRAY['red', 'L']) AS MAP(VARCHAR, VARCHAR)),
    CAST(MAP(ARRAY['a', 'b'], ARRAY[1, 2]) AS MAP(VARCHAR, INTEGER)),
    CAST(MAP(ARRAY[1, 2], ARRAY['one', 'two']) AS MAP(INTEGER, VARCHAR)),
    CAST(ARRAY[ROW('A-1', 2, 9.99, ARRAY['x', 'y']), ROW('B-2', 1, 24.50, CAST(ARRAY[] AS ARRAY(VARCHAR)))] AS ARRAY(ROW(sku VARCHAR, qty INTEGER, price DECIMAL(10,2), opts ARRAY(VARCHAR)))),
    CAST(ARRAY[ROW(TIMESTAMP '2026-05-17 14:30:45', DATE '2026-05-17')] AS ARRAY(ROW(ts TIMESTAMP(3), day DATE))),
    CAST(ARRAY[MAP(ARRAY['m'], ARRAY[ROW(ARRAY[1, 2], MAP(ARRAY[1], ARRAY[ARRAY['q', 'r']]))])] AS ARRAY(MAP(VARCHAR, ROW(a ARRAY(INTEGER), b MAP(INTEGER, ARRAY(VARCHAR)))))),
    JSON '{"a": {"b": [5, 6]}, "n": 1}',
    CAST(ROW(1, 2) AS ROW("Odd Name" INTEGER, x INTEGER))
);

INSERT INTO check_complex VALUES (
    2,
    CAST(ARRAY[] AS ARRAY(VARCHAR)),
    CAST(ARRAY[] AS ARRAY(INTEGER)),
    NULL,
    NULL,
    NULL,
    CAST(ROW(NULL, NULL, CAST(ARRAY[] AS ARRAY(VARCHAR))) AS ROW(street VARCHAR, geo ROW(lat DOUBLE, lon DOUBLE), phones ARRAY(VARCHAR))),
    CAST(MAP(ARRAY[], ARRAY[]) AS MAP(VARCHAR, VARCHAR)),
    CAST(MAP(ARRAY[], ARRAY[]) AS MAP(VARCHAR, INTEGER)),
    NULL,
    CAST(ARRAY[] AS ARRAY(ROW(sku VARCHAR, qty INTEGER, price DECIMAL(10,2), opts ARRAY(VARCHAR)))),
    CAST(ARRAY[] AS ARRAY(ROW(ts TIMESTAMP(3), day DATE))),
    CAST(ARRAY[] AS ARRAY(MAP(VARCHAR, ROW(a ARRAY(INTEGER), b MAP(INTEGER, ARRAY(VARCHAR)))))),
    NULL,
    NULL
);

INSERT INTO check_complex VALUES (
    3,
    CAST(ARRAY['x', NULL, 'z'] AS ARRAY(VARCHAR)),
    CAST(ARRAY[NULL, 5, NULL] AS ARRAY(INTEGER)),
    CAST(ARRAY[0.0, NULL, 3.0] AS ARRAY(DOUBLE)),
    CAST(ARRAY[ARRAY[1.0, NULL, 3.0], ARRAY[NULL, 5.0, 6.0]] AS ARRAY(ARRAY(DOUBLE))),
    CAST(ROW(NULL, 4.0) AS ROW(w DOUBLE, h DOUBLE)),
    CAST(ROW('Side Rd 3', ROW(NULL, NULL), ARRAY[NULL]) AS ROW(street VARCHAR, geo ROW(lat DOUBLE, lon DOUBLE), phones ARRAY(VARCHAR))),
    CAST(MAP(ARRAY['k'], ARRAY[NULL]) AS MAP(VARCHAR, VARCHAR)),
    CAST(MAP(ARRAY['z'], ARRAY[NULL]) AS MAP(VARCHAR, INTEGER)),
    CAST(MAP(ARRAY[3], ARRAY[NULL]) AS MAP(INTEGER, VARCHAR)),
    CAST(ARRAY[ROW('C-3', NULL, NULL, NULL)] AS ARRAY(ROW(sku VARCHAR, qty INTEGER, price DECIMAL(10,2), opts ARRAY(VARCHAR)))),
    CAST(ARRAY[ROW(NULL, DATE '2026-01-01')] AS ARRAY(ROW(ts TIMESTAMP(3), day DATE))),
    CAST(ARRAY[MAP(ARRAY['m'], ARRAY[ROW(NULL, NULL)])] AS ARRAY(MAP(VARCHAR, ROW(a ARRAY(INTEGER), b MAP(INTEGER, ARRAY(VARCHAR)))))),
    JSON '[1, 2, 3]',
    CAST(ROW(NULL, NULL) AS ROW("Odd Name" INTEGER, x INTEGER))
);
