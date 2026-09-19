-- asin: inverse sine, result in radians.
SELECT
  o.order_id
, round(asin(1), 6) AS arcsine_of_one
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY