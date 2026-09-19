-- trunc: truncate toward zero, never rounding up.
SELECT
  od.order_id
, od.product_id
, TRUNCATE(od.unit_price, 0) AS whole_price
, TRUNCATE(19.99, 1) AS one_decimal
FROM
 order_details od
ORDER BY
  od.order_id ASC
, od.product_id ASC
FETCH FIRST 20 ROWS ONLY