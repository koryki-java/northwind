-- acos: inverse cosine, result in radians.
SELECT
  o.order_id
, round(acos(1), 6) AS arccosine_of_one
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY