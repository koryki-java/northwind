SELECT
  count(o.freight) AS f
, (
   SELECT
     count(o.freight) AS f
   FROM
    orders o
  ) AS id
FROM
 orders o
