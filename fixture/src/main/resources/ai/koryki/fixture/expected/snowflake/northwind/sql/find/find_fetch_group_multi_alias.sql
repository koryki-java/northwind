-- Regression (PushGroupRule): a GROUP BY key spanning two aliases — concat over c and o —
-- cannot be pushed down to a single table, so it must stay at the SELECT-level GROUP BY and
-- must NOT be dropped. count(...) triggers GROUP BY inference; the multi-alias scalar becomes
-- the group key. If the un-pushable branch drops it, the concat disappears from GROUP BY.
SELECT
  ARRAY_TO_STRING(ARRAY_CONSTRUCT_COMPACT(c.country, o.ship_country), '') AS route
, count(o.order_id) AS orders
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
GROUP BY
  ARRAY_TO_STRING(ARRAY_CONSTRUCT_COMPACT(c.country, o.ship_country), '')