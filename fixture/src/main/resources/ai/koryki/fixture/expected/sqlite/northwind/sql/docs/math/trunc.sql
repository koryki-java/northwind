-- trunc: truncate toward zero, never rounding up.
SELECT
  od.order_id
, od.product_id
, trunc(od.unit_price) AS whole_price
, (CAST(19.99 * pow(10, 1) AS INTEGER) / pow(10, 1)) AS one_decimal
FROM
 order_details od
ORDER BY
  od.order_id ASC
, od.product_id ASC
LIMIT 20