-- position: position of a dash within the phone.
SELECT
  instr(c.phone, '-') AS dash_pos
FROM
 customers c