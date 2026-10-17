-- A condition on the rows of an outer unnest belongs to the join, and keeps every parent. Trino, Snowflake, Oracle and SQL Server take none there.
SELECT
  t.nr
, i.item['sku']
FROM
 check_complex t
  LEFT OUTER JOIN UNNEST(t.items) AS i(item) ON i.item['qty'] > 1