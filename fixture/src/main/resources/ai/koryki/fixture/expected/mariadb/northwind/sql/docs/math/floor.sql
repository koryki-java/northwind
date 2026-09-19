-- floor: round freight down to a whole number.
SELECT
  o.order_id
, floor(o.freight) AS rounded_down
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY