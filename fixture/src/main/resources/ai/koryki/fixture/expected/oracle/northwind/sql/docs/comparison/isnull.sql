-- ISNULL : orders not yet shipped.
SELECT
  o.order_id
, o.shipped_date
FROM
 orders o
WHERE
  o.shipped_date IS NULL