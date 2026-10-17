-- The elements of the JSON array are rows: a count, a sum and an extreme over them.
SELECT
  count(b.item) AS elements
, sum(b.item) AS total
, max(b.item) AS biggest
FROM
 check_complex t
  INNER JOIN UNNEST(CAST((t.doc -> '$.a.b') AS INTEGER[])) AS b(item) ON TRUE