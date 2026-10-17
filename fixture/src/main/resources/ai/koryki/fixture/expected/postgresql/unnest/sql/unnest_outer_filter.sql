-- A condition on the rows of an outer unnest belongs to the join, and keeps every parent. Trino, Snowflake, Oracle and SQL Server take none there.
SELECT
  t.nr
, i.sku
FROM
 check_complex t
  LEFT OUTER JOIN LATERAL unnest(t.items) AS i(sku, qty, price, opts) ON i.qty > 1