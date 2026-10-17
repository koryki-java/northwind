-- Revenue by sku, the analysis a list column alone cannot answer.
SELECT
  i.sku
, count(i.sku) AS lines
, sum(i.qty * i.price) AS revenue
FROM
 check_complex t
  INNER JOIN LATERAL unnest(t.items) AS i(sku, qty, price, opts) ON TRUE
GROUP BY
  i.sku