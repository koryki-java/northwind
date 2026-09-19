-- to_char: format the order date as YYYY-MM.
SELECT
  o.order_id
, CONCAT(CAST(YEAR(o.order_date) AS VARCHAR(4)), '-', RIGHT('0' + CAST(MONTH(o.order_date) AS VARCHAR(2)), 2)) AS ym
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY