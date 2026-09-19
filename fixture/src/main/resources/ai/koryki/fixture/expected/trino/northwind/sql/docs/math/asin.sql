-- asin: inverse sine, result in radians.
SELECT
  o.order_id
, round(asin(1), 6) AS arcsine_of_one
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY