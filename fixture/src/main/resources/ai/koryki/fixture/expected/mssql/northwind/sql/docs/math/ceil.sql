-- ceil: round freight up to a whole number.
SELECT
  o.order_id
, CEILING(o.freight) AS rounded_up
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY