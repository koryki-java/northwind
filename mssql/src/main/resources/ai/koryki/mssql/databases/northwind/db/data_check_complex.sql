--
-- Self-contained (DROP + CREATE + data), like check_type. The complex-types test bed, reduced to what
-- SQL Server offers: DuckDB's check_complex (ai/koryki/duckdb/databases/northwind) is the blueprint, and
-- of its 15 columns only the JSON one has a counterpart here. Same three rows as there: an object, NULL
-- and an array.

DROP TABLE IF EXISTS check_complex;

CREATE TABLE check_complex (
    nr   SMALLINT NOT NULL PRIMARY KEY,
    -- JSON is text here: UTF-8 with binary comparison like every text column of this database, and
    -- ISJSON as the check (NULL passes); paths count from 0
    doc  VARCHAR(MAX) COLLATE Latin1_General_100_BIN2_UTF8 CHECK (ISJSON(doc) = 1)
);

INSERT INTO check_complex VALUES (1, '{"a": {"b": [5, 6]}, "n": 1}');
INSERT INTO check_complex VALUES (2, NULL);
INSERT INTO check_complex VALUES (3, '[1, 2, 3]');
