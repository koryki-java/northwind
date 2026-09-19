-- trunc: truncate toward zero, never rounding up.
SELECT
  od.order_id
, od.product_id
, truncate(od.unit_price) AS whole_price
, truncate(CAST(19.99 AS DECIMAL(38,10)), 1) AS one_decimal
FROM
 order_details od
ORDER BY
  od.order_id ASC
, od.product_id ASC
FETCH FIRST 20 ROWS ONLY