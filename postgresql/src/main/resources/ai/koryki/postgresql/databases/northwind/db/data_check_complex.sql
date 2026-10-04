--
-- Self-contained (DROP + CREATE + data), like check_type: tables.sql does not define check_complex and
-- drop.sql does not drop it. The complex-types test bed, one column per shape; DuckDB's check_complex
-- is the blueprint (ai/koryki/duckdb/databases/northwind), the catalog is
-- ai/koryki/postgresql/databases/complex/db.json.
--
-- PostgreSQL maps the DuckDB shapes like this:
--   LIST, ARRAY   -> arrays: text[], integer[], double precision[]. A PostgreSQL array has no fixed
--                    size (the [3] is documentation) and no array of arrays: DOUBLE[3][2] is ONE
--                    two-dimensional array.
--   STRUCT        -> composite types, which have to be created first (cx_*).
--   MAP           -> none: jsonb, so a map is a JSON object here and its keys are text.
--   JSON          -> jsonb. deep, a list of maps, is jsonb as a whole for the same reason.

DROP TABLE IF EXISTS check_complex;
DROP TYPE IF EXISTS cx_dims, cx_address, cx_geo, cx_item, cx_event, cx_odd;

CREATE TYPE cx_dims AS (w DOUBLE PRECISION, h DOUBLE PRECISION);
CREATE TYPE cx_geo AS (lat DOUBLE PRECISION, lon DOUBLE PRECISION);
CREATE TYPE cx_address AS (street TEXT, geo cx_geo, phones TEXT[]);
CREATE TYPE cx_item AS (sku TEXT, qty INTEGER, price NUMERIC(10,2), opts TEXT[]);
CREATE TYPE cx_event AS (ts TIMESTAMP, day DATE);
CREATE TYPE cx_odd AS ("Odd Name" INTEGER, x INTEGER);

CREATE TABLE check_complex (
    nr       SMALLINT NOT NULL PRIMARY KEY,
    tags     TEXT[],                 -- list of scalars
    scores   INTEGER[],              -- list, numeric element
    vec      DOUBLE PRECISION[],     -- DuckDB DOUBLE[3]: no fixed size here, three values
    matrix   DOUBLE PRECISION[][],   -- DuckDB DOUBLE[3][2]: one two-dimensional array, two rows of three
    dims     cx_dims,                -- flat struct
    address  cx_address,             -- struct holding a struct and a list
    attrs    JSONB,                  -- map, text keys
    counts   JSONB,                  -- map, numeric values
    lookup   JSONB,                  -- map, integer keys (stored as text, as JSON has no other)
    items    cx_item[],              -- list of structs
    events   cx_event[],             -- list of structs with temporal fields
    deep     JSONB,                  -- every constructor inside every other; a list of maps, so jsonb
    doc      JSONB,                  -- JSON: paths count from 0, arrays from 1
    odd      cx_odd                  -- quoted, mixed-case field name
);

INSERT INTO check_complex VALUES (
    1,
    ARRAY['red', 'green', 'blue'],
    ARRAY[10, 20, 30],
    ARRAY[1.0, 2.0, 3.0],
    ARRAY[[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]],
    ROW(1.5, 2.5)::cx_dims,
    ROW('Main St 1', ROW(52.52, 13.405)::cx_geo, ARRAY['+49 30 1', '+49 30 2'])::cx_address,
    '{"color": "red", "size": "L"}'::jsonb,
    '{"a": 1, "b": 2}'::jsonb,
    '{"1": "one", "2": "two"}'::jsonb,
    ARRAY[ROW('A-1', 2, 9.99, ARRAY['x', 'y'])::cx_item, ROW('B-2', 1, 24.50, ARRAY[]::TEXT[])::cx_item],
    ARRAY[ROW(TIMESTAMP '2026-05-17 14:30:45', DATE '2026-05-17')::cx_event],
    '[{"m": {"a": [1, 2], "b": {"1": ["q", "r"]}}}]'::jsonb,
    '{"a": {"b": [5, 6]}, "n": 1}'::jsonb,
    ROW(1, 2)::cx_odd
);

INSERT INTO check_complex VALUES (
    2,
    ARRAY[]::TEXT[],
    ARRAY[]::INTEGER[],
    NULL,
    NULL,
    NULL,
    ROW(NULL, NULL, ARRAY[]::TEXT[])::cx_address,
    '{}'::jsonb,
    '{}'::jsonb,
    NULL,
    ARRAY[]::cx_item[],
    ARRAY[]::cx_event[],
    '[]'::jsonb,
    NULL,
    NULL
);

INSERT INTO check_complex VALUES (
    3,
    ARRAY['x', NULL, 'z'],
    ARRAY[NULL, 5, NULL]::INTEGER[],
    ARRAY[0.0, NULL, 3.0],
    ARRAY[[1.0, NULL, 3.0], [NULL, 5.0, 6.0]],
    ROW(NULL, 4.0)::cx_dims,
    ROW('Side Rd 3', ROW(NULL, NULL)::cx_geo, ARRAY[NULL]::TEXT[])::cx_address,
    '{"k": null}'::jsonb,
    '{"z": null}'::jsonb,
    '{"3": null}'::jsonb,
    ARRAY[ROW('C-3', NULL, NULL, NULL)::cx_item],
    ARRAY[ROW(NULL, DATE '2026-01-01')::cx_event],
    '[{"m": {"a": null, "b": null}}]'::jsonb,
    '[1, 2, 3]'::jsonb,
    ROW(NULL, NULL)::cx_odd
);
