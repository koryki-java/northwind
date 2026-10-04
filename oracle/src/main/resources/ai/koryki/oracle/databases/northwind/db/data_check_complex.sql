--
-- Self-contained (DROP + CREATE + data), like check_type. The complex-types test bed, reduced to what
-- Oracle offers: DuckDB's check_complex (ai/koryki/duckdb/databases/northwind) is the blueprint, and
-- of its 15 columns only the JSON one has a counterpart here. Same three rows as there: an object, NULL
-- and an array.

DROP TABLE IF EXISTS check_complex;

CREATE TABLE check_complex (
    nr   SMALLINT NOT NULL PRIMARY KEY,
    doc  JSON            -- the native JSON type of 21c and later; paths count from 0
);

INSERT INTO check_complex VALUES (1, JSON('{"a": {"b": [5, 6]}, "n": 1}'));
INSERT INTO check_complex VALUES (2, NULL);
INSERT INTO check_complex VALUES (3, JSON('[1, 2, 3]'));
