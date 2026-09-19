SELECT
  o.order_id
, TO_CHAR(o.delivered_date, 'HH24:MI:SS') AS order_time
FROM
 orders o