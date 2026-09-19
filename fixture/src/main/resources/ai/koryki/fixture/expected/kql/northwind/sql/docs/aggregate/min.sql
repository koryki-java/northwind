-- min: earliest order date.
SELECT
  min(o.order_date) AS earliest
FROM
 orders o