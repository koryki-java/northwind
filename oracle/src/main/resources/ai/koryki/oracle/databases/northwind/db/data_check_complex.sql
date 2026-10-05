--
-- Self-contained (DROP + CREATE + data), like check_type: tables.sql does not define check_complex and
-- drop.sql does not drop it. The complex-types test bed, one column per shape; DuckDB's check_complex
-- is the blueprint (ai/koryki/duckdb/databases/northwind), the catalog is
-- ai/koryki/oracle/databases/complex/db.json.
--
-- Oracle maps the DuckDB shapes like this:
--   LIST, ARRAY   -> collection types, which have to be created first: VARRAY (ordered, with a
--                    maximum, here 100) and NESTED TABLE (unbounded; needs a STORE AS table). A
--                    VARRAY of VARRAYs is a real array of arrays, so DOUBLE[3][2] fits.
--   STRUCT        -> object types (cx_*). Their attributes are reached by dot notation, which needs a
--                    table alias; a collection is unnested with TABLE(...), there is no subscript in SQL.
--   MAP           -> none: JSON, so a map is a JSON object here and its keys are text. deep, a list of
--                    maps, is JSON as a whole for the same reason.
--   JSON          -> the native JSON type of 21c and later.

DROP TABLE IF EXISTS check_complex PURGE;
DROP TYPE IF EXISTS cx_matrix FORCE;
DROP TYPE IF EXISTS cx_dbl_list FORCE;
DROP TYPE IF EXISTS cx_int_list FORCE;
DROP TYPE IF EXISTS cx_dims FORCE;
DROP TYPE IF EXISTS cx_address FORCE;
DROP TYPE IF EXISTS cx_geo FORCE;
DROP TYPE IF EXISTS cx_item_tab FORCE;
DROP TYPE IF EXISTS cx_item FORCE;
DROP TYPE IF EXISTS cx_event_list FORCE;
DROP TYPE IF EXISTS cx_event FORCE;
DROP TYPE IF EXISTS cx_odd FORCE;
DROP TYPE IF EXISTS cx_str_list FORCE;

CREATE TYPE cx_str_list AS VARRAY(100) OF VARCHAR2(100);
CREATE TYPE cx_int_list AS VARRAY(100) OF INTEGER;
CREATE TYPE cx_dbl_list AS VARRAY(100) OF BINARY_DOUBLE;
CREATE TYPE cx_matrix AS VARRAY(100) OF cx_dbl_list;
CREATE TYPE cx_dims AS OBJECT (w BINARY_DOUBLE, h BINARY_DOUBLE);
CREATE TYPE cx_geo AS OBJECT (lat BINARY_DOUBLE, lon BINARY_DOUBLE);
CREATE TYPE cx_address AS OBJECT (street VARCHAR2(100), geo cx_geo, phones cx_str_list);
CREATE TYPE cx_item AS OBJECT (sku VARCHAR2(20), qty INTEGER, price NUMBER(10,2), opts cx_str_list);
CREATE TYPE cx_item_tab AS TABLE OF cx_item;
CREATE TYPE cx_event AS OBJECT (ts TIMESTAMP, day DATE);
CREATE TYPE cx_event_list AS VARRAY(100) OF cx_event;
CREATE TYPE cx_odd AS OBJECT ("Odd Name" INTEGER, x INTEGER);

CREATE TABLE check_complex (
    nr       SMALLINT NOT NULL PRIMARY KEY,
    tags     cx_str_list,       -- list of scalars
    scores   cx_int_list,       -- list, numeric element
    vec      cx_dbl_list,       -- DuckDB DOUBLE[3]: a VARRAY has a maximum, not a fixed size
    matrix   cx_matrix,         -- DuckDB DOUBLE[3][2]: a VARRAY of VARRAYs, two rows of three
    dims     cx_dims,           -- flat struct
    address  cx_address,        -- struct holding a struct and a list
    attrs    JSON,              -- map, text keys
    counts   JSON,              -- map, numeric values
    lookup   JSON,              -- map, integer keys (text in JSON)
    items    cx_item_tab,       -- list of structs, as a nested table
    events   cx_event_list,     -- list of structs with temporal fields
    deep     JSON,              -- every constructor inside every other; a list of maps, so JSON
    doc      JSON,              -- JSON: paths count from 0
    odd      cx_odd             -- quoted, mixed-case attribute name
)
NESTED TABLE items STORE AS check_complex_items;

INSERT INTO check_complex VALUES (
    1,
    cx_str_list('red', 'green', 'blue'),
    cx_int_list(10, 20, 30),
    cx_dbl_list(1, 2, 3),
    cx_matrix(cx_dbl_list(1, 2, 3), cx_dbl_list(4, 5, 6)),
    cx_dims(1.5, 2.5),
    cx_address('Main St 1', cx_geo(52.52, 13.405), cx_str_list('+49 30 1', '+49 30 2')),
    JSON('{"color": "red", "size": "L"}'),
    JSON('{"a": 1, "b": 2}'),
    JSON('{"1": "one", "2": "two"}'),
    cx_item_tab(cx_item('A-1', 2, 9.99, cx_str_list('x', 'y')), cx_item('B-2', 1, 24.50, cx_str_list())),
    cx_event_list(cx_event(TIMESTAMP '2026-05-17 14:30:45', DATE '2026-05-17')),
    JSON('[{"m": {"a": [1, 2], "b": {"1": ["q", "r"]}}}]'),
    JSON('{"a": {"b": [5, 6]}, "n": 1}'),
    cx_odd(1, 2)
);

INSERT INTO check_complex VALUES (
    2,
    cx_str_list(),
    cx_int_list(),
    NULL,
    NULL,
    NULL,
    cx_address(NULL, NULL, cx_str_list()),
    JSON('{}'),
    JSON('{}'),
    NULL,
    cx_item_tab(),
    cx_event_list(),
    JSON('[]'),
    NULL,
    NULL
);

INSERT INTO check_complex VALUES (
    3,
    cx_str_list('x', NULL, 'z'),
    cx_int_list(NULL, 5, NULL),
    cx_dbl_list(0, NULL, 3),
    cx_matrix(cx_dbl_list(1, NULL, 3), cx_dbl_list(NULL, 5, 6)),
    cx_dims(NULL, 4.0),
    cx_address('Side Rd 3', cx_geo(NULL, NULL), cx_str_list(NULL)),
    JSON('{"k": null}'),
    JSON('{"z": null}'),
    JSON('{"3": null}'),
    cx_item_tab(cx_item('C-3', NULL, NULL, NULL)),
    cx_event_list(cx_event(NULL, DATE '2026-01-01')),
    JSON('[{"m": {"a": null, "b": null}}]'),
    JSON('[1, 2, 3]'),
    cx_odd(NULL, NULL)
);
