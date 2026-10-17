-- Revenue by sku, the analysis a list column alone cannot answer.
SELECT
  i.sku
, count(i.sku) AS lines
, sum(i.qty * i.price) AS revenue
FROM
 check_complex t
  CROSS JOIN UNNEST(t.items) AS i(sku, qty, price, opts)
GROUP BY
  i.sku