-- max: latest order date.
SELECT
  max(o.order_date) AS latest
FROM
 orders o