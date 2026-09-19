-- to_char: format the order date as YYYY-MM.
SELECT
  o.order_id
, date_format(o.order_date, '%Y-%m') AS ym
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY