-- Revenue by sku, the analysis a list column alone cannot answer.
SELECT
  i.VALUE:sku::VARCHAR
, count(i.VALUE:sku::VARCHAR) AS lines
, sum(i.VALUE:qty::INTEGER * i.VALUE:price::NUMBER(10, 2)) AS revenue
FROM
 check_complex t
  , LATERAL FLATTEN(INPUT => t.items) i
GROUP BY
  i.VALUE:sku::VARCHAR