-- round: order freight rounded to one decimal place.
SELECT
  round(o.freight, 1) AS freight_rounded
FROM
 orders o
WHERE
  o.customer_id = 'TOMSP'