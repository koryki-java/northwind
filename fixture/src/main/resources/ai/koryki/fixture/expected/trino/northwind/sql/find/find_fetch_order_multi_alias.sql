-- Regression (PushOrderRule): an ORDER BY key spanning two aliases — concat over c and o —
-- cannot be pushed down to a single table, so it must stay at the SELECT-level ORDER BY and
-- must NOT be dropped. No aggregate here, so this isolates the ORDER path. If the un-pushable
-- branch drops it, the concat disappears from ORDER BY.
SELECT
  c.company_name AS company
, concat_ws('', c.country, o.ship_country) AS route
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
ORDER BY
  concat_ws('', c.country, o.ship_country) DESC