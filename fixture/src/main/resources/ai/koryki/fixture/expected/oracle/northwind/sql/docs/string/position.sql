-- position: position of a dash within the phone.
SELECT
  INSTR(c.phone, '-') AS dash_pos
FROM
 customers c