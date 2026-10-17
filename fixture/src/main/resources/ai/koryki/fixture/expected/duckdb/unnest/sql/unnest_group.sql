-- Revenue by sku, the analysis a list column alone cannot answer.
SELECT
  i.item['sku']
, count(i.item['sku']) AS lines
, sum(i.item['qty'] * i.item['price']) AS revenue
FROM
 check_complex t
  INNER JOIN UNNEST(t.items) AS i(item) ON TRUE
GROUP BY
  i.item['sku']