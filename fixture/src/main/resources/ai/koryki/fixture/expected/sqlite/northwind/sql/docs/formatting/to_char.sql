-- to_char: format the order date as YYYY-MM.
SELECT
  o.order_id
, strftime('%Y-%m', o.order_date) AS ym
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20