-- The elements of the JSON array are rows: a count, a sum and an extreme over them.
SELECT
  count(b.value) AS elements
, sum(b.value) AS total
, max(b.value) AS biggest
FROM
 check_complex t
  CROSS JOIN UNNEST(CAST(json_extract(t.doc, '$.a.b') AS ARRAY(INTEGER))) AS b(value)