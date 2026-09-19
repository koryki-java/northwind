-- acos: inverse cosine, result in radians.
SELECT
  o.order_id
, round(CAST(acos(1) AS numeric), 6) AS arccosine_of_one
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY