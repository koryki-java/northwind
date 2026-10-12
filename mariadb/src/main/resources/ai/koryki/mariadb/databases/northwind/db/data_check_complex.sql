--
-- Self-contained (DROP + CREATE + data), like check_type. The complex-types test bed, reduced to what
-- MariaDB offers: DuckDB's check_complex (ai/koryki/duckdb/databases/northwind) is the blueprint, and
-- of its 15 columns only the JSON one has a counterpart here. Same three rows as there: an object, NULL
-- and an array.

DROP VIEW IF EXISTS check_complex_doc_a_b;
DROP TABLE IF EXISTS check_complex;

CREATE TABLE check_complex (
    nr   SMALLINT NOT NULL PRIMARY KEY,
    doc  JSON            -- JSON: a LONGTEXT with a validity check; paths count from 0
);

INSERT INTO check_complex VALUES
    (1, '{"a": {"b": [5, 6]}, "n": 1}'),
    (2, NULL),
    (3, '[1, 2, 3]');

-- The array doc.a.b, which the catalog declares as a list of integers, flattened into one row per element
-- (FlattenViews in the tools module of core generates it): the key of the row, the position in the array
-- from 1, and "value". JSON_TABLE.
CREATE OR REPLACE VIEW check_complex_doc_a_b AS
SELECT t.nr, jt.ordinal, jt.`value` AS `value`
FROM check_complex t, JSON_TABLE(t.doc, '$.a.b[*]' COLUMNS (ordinal FOR ORDINALITY, `value` INT PATH '$')) jt;
