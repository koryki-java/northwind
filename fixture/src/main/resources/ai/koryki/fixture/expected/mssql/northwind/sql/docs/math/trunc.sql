-- trunc: truncate toward zero, never rounding up.
SELECT
  od.order_id
, od.product_id
, ROUND(od.unit_price, 0, 1) AS whole_price
, ROUND(19.99, 1, 1) AS one_decimal
FROM
 order_details od
ORDER BY
  od.order_id ASC
, od.product_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY