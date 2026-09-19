-- abs: absolute value of a number.
SELECT
  o.order_id
, abs(-17.4) AS magnitude
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY