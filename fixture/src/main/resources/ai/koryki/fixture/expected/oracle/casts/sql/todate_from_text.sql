SELECT
  o.order_id
, TO_DATE('1996-07-04', 'YYYY-MM-DD') AS date_val
FROM
 orders o