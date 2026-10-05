--
-- Self-contained (DROP + CREATE + data), like check_type: tables.sql does not define check_complex and
-- drop.sql does not drop it. The complex-types test bed, one column per shape; DuckDB's check_complex
-- is the blueprint (ai/koryki/duckdb/databases/northwind).
--
-- Snowflake's structured types, ARRAY(T), OBJECT(name T, ...) and MAP(K, V), carry the element types
-- the untyped ARRAY and OBJECT do not. Differences from DuckDB: no fixed-size array (a list of three),
-- OBJECT for STRUCT, VARIANT for JSON, map keys are text or integers. Values come back from the JDBC
-- driver as JSON text. OBJECT_CONSTRUCT_KEEP_NULL: plain OBJECT_CONSTRUCT would drop the NULL fields
-- the rows are meant to contain.

DROP TABLE IF EXISTS check_complex;

CREATE TABLE check_complex (
    nr       SMALLINT NOT NULL PRIMARY KEY,
    tags     ARRAY(VARCHAR),  -- list of scalars
    scores   ARRAY(INTEGER),  -- list, numeric element
    vec      ARRAY(DOUBLE),  -- DuckDB DOUBLE[3]; no fixed-size array here, a list of three
    matrix   ARRAY(ARRAY(DOUBLE)),  -- DuckDB DOUBLE[3][2]: two rows of three, as a list of lists
    dims     OBJECT(w DOUBLE, h DOUBLE),  -- flat struct
    address  OBJECT(street VARCHAR, geo OBJECT(lat DOUBLE, lon DOUBLE), phones ARRAY(VARCHAR)),  -- struct holding a struct and a list
    attrs    MAP(VARCHAR, VARCHAR),  -- map, text keys
    counts   MAP(VARCHAR, INTEGER),  -- map, numeric values
    lookup   MAP(INTEGER, VARCHAR),  -- map, integer keys
    items    ARRAY(OBJECT(sku VARCHAR, qty INTEGER, price NUMBER(10,2), opts ARRAY(VARCHAR))),  -- list of structs
    events   ARRAY(OBJECT(ts TIMESTAMP_NTZ, day DATE)),  -- list of structs with temporal fields
    deep     ARRAY(MAP(VARCHAR, OBJECT(a ARRAY(INTEGER), b MAP(INTEGER, ARRAY(VARCHAR))))),  -- every constructor inside every other
    doc      VARIANT,  -- JSON; paths count from 0, like every Snowflake array
    odd      OBJECT("Odd Name" INTEGER, x INTEGER)  -- quoted, mixed-case field name
);


INSERT INTO check_complex
SELECT
    1,
    (ARRAY_CONSTRUCT('red', 'green', 'blue'))::ARRAY(VARCHAR),
    (ARRAY_CONSTRUCT(10, 20, 30))::ARRAY(INTEGER),
    (ARRAY_CONSTRUCT(1.0, 2.0, 3.0))::ARRAY(DOUBLE),
    (ARRAY_CONSTRUCT(ARRAY_CONSTRUCT(1.0, 2.0, 3.0), ARRAY_CONSTRUCT(4.0, 5.0, 6.0)))::ARRAY(ARRAY(DOUBLE)),
    (OBJECT_CONSTRUCT_KEEP_NULL('w', 1.5, 'h', 2.5))::OBJECT(w DOUBLE, h DOUBLE),
    (OBJECT_CONSTRUCT_KEEP_NULL('street', 'Main St 1', 'geo', OBJECT_CONSTRUCT_KEEP_NULL('lat', 52.52, 'lon', 13.405), 'phones', ARRAY_CONSTRUCT('+49 30 1', '+49 30 2')))::OBJECT(street VARCHAR, geo OBJECT(lat DOUBLE, lon DOUBLE), phones ARRAY(VARCHAR)),
    (OBJECT_CONSTRUCT_KEEP_NULL('color', 'red', 'size', 'L'))::MAP(VARCHAR, VARCHAR),
    (OBJECT_CONSTRUCT_KEEP_NULL('a', 1, 'b', 2))::MAP(VARCHAR, INTEGER),
    (OBJECT_CONSTRUCT_KEEP_NULL('1', 'one', '2', 'two'))::MAP(INTEGER, VARCHAR),
    (ARRAY_CONSTRUCT(OBJECT_CONSTRUCT_KEEP_NULL('sku', 'A-1', 'qty', 2, 'price', 9.99, 'opts', ARRAY_CONSTRUCT('x', 'y')), OBJECT_CONSTRUCT_KEEP_NULL('sku', 'B-2', 'qty', 1, 'price', 24.50, 'opts', ARRAY_CONSTRUCT())))::ARRAY(OBJECT(sku VARCHAR, qty INTEGER, price NUMBER(10,2), opts ARRAY(VARCHAR))),
    (ARRAY_CONSTRUCT(OBJECT_CONSTRUCT_KEEP_NULL('ts', '2026-05-17 14:30:45'::TIMESTAMP_NTZ, 'day', '2026-05-17'::DATE)))::ARRAY(OBJECT(ts TIMESTAMP_NTZ, day DATE)),
    (ARRAY_CONSTRUCT(OBJECT_CONSTRUCT_KEEP_NULL('m', OBJECT_CONSTRUCT_KEEP_NULL('a', ARRAY_CONSTRUCT(1, 2), 'b', OBJECT_CONSTRUCT_KEEP_NULL('1', ARRAY_CONSTRUCT('q', 'r'))))))::ARRAY(MAP(VARCHAR, OBJECT(a ARRAY(INTEGER), b MAP(INTEGER, ARRAY(VARCHAR))))),
    PARSE_JSON('{"a": {"b": [5, 6]}, "n": 1}'),
    (OBJECT_CONSTRUCT_KEEP_NULL('Odd Name', 1, 'x', 2))::OBJECT("Odd Name" INTEGER, x INTEGER);

INSERT INTO check_complex
SELECT
    2,
    (ARRAY_CONSTRUCT())::ARRAY(VARCHAR),
    (ARRAY_CONSTRUCT())::ARRAY(INTEGER),
    NULL,
    NULL,
    NULL,
    (OBJECT_CONSTRUCT_KEEP_NULL('street', NULL, 'geo', NULL, 'phones', ARRAY_CONSTRUCT()))::OBJECT(street VARCHAR, geo OBJECT(lat DOUBLE, lon DOUBLE), phones ARRAY(VARCHAR)),
    (OBJECT_CONSTRUCT_KEEP_NULL())::MAP(VARCHAR, VARCHAR),
    (OBJECT_CONSTRUCT_KEEP_NULL())::MAP(VARCHAR, INTEGER),
    NULL,
    (ARRAY_CONSTRUCT())::ARRAY(OBJECT(sku VARCHAR, qty INTEGER, price NUMBER(10,2), opts ARRAY(VARCHAR))),
    (ARRAY_CONSTRUCT())::ARRAY(OBJECT(ts TIMESTAMP_NTZ, day DATE)),
    (ARRAY_CONSTRUCT())::ARRAY(MAP(VARCHAR, OBJECT(a ARRAY(INTEGER), b MAP(INTEGER, ARRAY(VARCHAR))))),
    NULL,
    NULL;

INSERT INTO check_complex
SELECT
    3,
    (ARRAY_CONSTRUCT('x', NULL, 'z'))::ARRAY(VARCHAR),
    (ARRAY_CONSTRUCT(NULL, 5, NULL))::ARRAY(INTEGER),
    (ARRAY_CONSTRUCT(0.0, NULL, 3.0))::ARRAY(DOUBLE),
    (ARRAY_CONSTRUCT(ARRAY_CONSTRUCT(1.0, NULL, 3.0), ARRAY_CONSTRUCT(NULL, 5.0, 6.0)))::ARRAY(ARRAY(DOUBLE)),
    (OBJECT_CONSTRUCT_KEEP_NULL('w', NULL, 'h', 4.0))::OBJECT(w DOUBLE, h DOUBLE),
    (OBJECT_CONSTRUCT_KEEP_NULL('street', 'Side Rd 3', 'geo', OBJECT_CONSTRUCT_KEEP_NULL('lat', NULL, 'lon', NULL), 'phones', ARRAY_CONSTRUCT(NULL)))::OBJECT(street VARCHAR, geo OBJECT(lat DOUBLE, lon DOUBLE), phones ARRAY(VARCHAR)),
    (OBJECT_CONSTRUCT_KEEP_NULL('k', NULL))::MAP(VARCHAR, VARCHAR),
    (OBJECT_CONSTRUCT_KEEP_NULL('z', NULL))::MAP(VARCHAR, INTEGER),
    (OBJECT_CONSTRUCT_KEEP_NULL('3', NULL))::MAP(INTEGER, VARCHAR),
    (ARRAY_CONSTRUCT(OBJECT_CONSTRUCT_KEEP_NULL('sku', 'C-3', 'qty', NULL, 'price', NULL, 'opts', NULL)))::ARRAY(OBJECT(sku VARCHAR, qty INTEGER, price NUMBER(10,2), opts ARRAY(VARCHAR))),
    (ARRAY_CONSTRUCT(OBJECT_CONSTRUCT_KEEP_NULL('ts', NULL, 'day', '2026-01-01'::DATE)))::ARRAY(OBJECT(ts TIMESTAMP_NTZ, day DATE)),
    (ARRAY_CONSTRUCT(OBJECT_CONSTRUCT_KEEP_NULL('m', OBJECT_CONSTRUCT_KEEP_NULL('a', NULL, 'b', NULL))))::ARRAY(MAP(VARCHAR, OBJECT(a ARRAY(INTEGER), b MAP(INTEGER, ARRAY(VARCHAR))))),
    PARSE_JSON('[1, 2, 3]'),
    (OBJECT_CONSTRUCT_KEEP_NULL('Odd Name', NULL, 'x', NULL))::OBJECT("Odd Name" INTEGER, x INTEGER);
