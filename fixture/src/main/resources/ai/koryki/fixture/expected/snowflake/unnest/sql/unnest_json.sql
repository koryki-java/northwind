-- An array inside JSON that the catalog declares, .a.b[]: INTEGER, made into rows.
SELECT
  t.nr
, b.VALUE::INTEGER
, b.VALUE::INTEGER * 10 AS tenfold
FROM
 check_complex t
  , LATERAL FLATTEN(INPUT => TRANSFORM(CAST(GET_PATH(t.doc, 'a.b') AS ARRAY), e -> CAST(e AS INTEGER))) b