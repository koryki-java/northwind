-- years_between: whole years from order to shipment.
SELECT
  o.order_id
, (CASE WHEN (CAST(strftime('%Y', o.shipped_date) AS INTEGER) - CAST(strftime('%Y', o.order_date) AS INTEGER)) > 0 AND strftime('%m-%d', o.shipped_date) < strftime('%m-%d', o.order_date) THEN (CAST(strftime('%Y', o.shipped_date) AS INTEGER) - CAST(strftime('%Y', o.order_date) AS INTEGER)) - 1 WHEN (CAST(strftime('%Y', o.shipped_date) AS INTEGER) - CAST(strftime('%Y', o.order_date) AS INTEGER)) < 0 AND strftime('%m-%d', o.shipped_date) > strftime('%m-%d', o.order_date) THEN (CAST(strftime('%Y', o.shipped_date) AS INTEGER) - CAST(strftime('%Y', o.order_date) AS INTEGER)) + 1 ELSE (CAST(strftime('%Y', o.shipped_date) AS INTEGER) - CAST(strftime('%Y', o.order_date) AS INTEGER)) END) AS years
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20