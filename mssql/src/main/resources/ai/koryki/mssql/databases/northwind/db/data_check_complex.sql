--
-- Self-contained (DROP + CREATE + data), like check_type. The complex-types test bed, reduced to what
-- SQL Server offers: DuckDB's check_complex (ai/koryki/duckdb/databases/northwind) is the blueprint, and
-- of its 15 columns only the JSON one has a counterpart here. Same three rows as there: an object, NULL
-- and an array.

DROP VIEW IF EXISTS check_complex_doc_a_b;
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

-- The array doc.a.b, which the catalog declares as a list of integers, flattened into one row per element
-- (FlattenViews in the tools module of core generates it): the key of the row, the position in the array
-- from 1, and "value". CROSS APPLY OPENJSON.
CREATE OR ALTER VIEW check_complex_doc_a_b AS
SELECT t.nr, CAST(j.[key] AS INT) + 1 AS ordinal, CAST(j.value AS INT) AS [value]
FROM check_complex t CROSS APPLY OPENJSON(CASE WHEN LEFT(JSON_QUERY(t.doc, '$.a.b'), 1) = '[' THEN JSON_QUERY(t.doc, '$.a.b') END) j;
