-- The elements of the JSON array are rows: a count, a sum and an extreme over them.
SELECT
  count(b.VALUE::INTEGER) AS elements
, sum(b.VALUE::INTEGER) AS total
, max(b.VALUE::INTEGER) AS biggest
FROM
 check_complex t
  , LATERAL FLATTEN(INPUT => TRANSFORM(CAST(GET_PATH(t.doc, 'a.b') AS ARRAY), e -> CAST(e AS INTEGER))) b