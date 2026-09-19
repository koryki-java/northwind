-- ceil: round freight up to a whole number.
SELECT
  o.order_id
, ceil(o.freight) AS rounded_up
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20