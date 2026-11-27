-- FALSE, and the negated forms: <> and NOT, against the same three storage forms.
SELECT
  t.nr
FROM
 check_type t
WHERE
  NOT (t.bool_from_text = 'N')
 AND
  t.bool_from_int <> 0
 AND
  t.type_boolean <> 0