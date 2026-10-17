-- A row whose document has no array there has no rows; the outer form keeps it.
SELECT
  t.nr
, b.VALUE::INTEGER
FROM
 check_complex t
  , LATERAL FLATTEN(INPUT => TRANSFORM(CAST(GET_PATH(t.doc, 'a.b') AS ARRAY), e -> CAST(e AS INTEGER)), OUTER => TRUE) b