-- GROUP BY ROLLUP: subtotal rows per country plus a grand total.
-- Dialect note — SQLite has no ROLLUP at all and must reject this before execution
-- (SqliteValidator). MariaDB spells it as a trailing WITH ROLLUP and runs it.
SELECT
  c.country
, count(o.order_id)
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
GROUP BY
  c.country WITH ROLLUP