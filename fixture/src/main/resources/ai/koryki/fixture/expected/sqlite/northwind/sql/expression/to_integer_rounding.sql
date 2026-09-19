-- The integer conversions round, they do not truncate — and they must agree on every dialect.
-- Measured before this was pinned: SQLite's bare CAST truncated (1.7 -> 1) while duckdb,
-- postgresql, oracle, mariadb and trino rounded (1.7 -> 2). SQL Server needs the same collar.
-- Half-way values round away from zero.
SELECT
  CAST(ROUND(1.7, 0) AS INTEGER) AS i_pos
, CAST(ROUND(-1.7, 0) AS INTEGER) AS i_neg
, CAST(ROUND(2.5, 0) AS INTEGER) AS i_half
, CAST(ROUND(1.7, 0) AS INTEGER) AS b_pos
, CAST(ROUND(1.7, 0) AS INTEGER) AS s_pos
FROM
 products p
WHERE
  p.product_id = 1