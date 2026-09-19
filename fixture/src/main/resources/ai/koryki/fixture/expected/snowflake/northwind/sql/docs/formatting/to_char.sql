-- to_char: format the order date as YYYY-MM.
SELECT
  o.order_id
, to_char(o.order_date, 'YYYY-MM') AS ym
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY