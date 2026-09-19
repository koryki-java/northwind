-- bit_length: length of the company name in bits.
SELECT
  length(CAST(c.company_name AS BLOB)) * 8 AS name_bits
FROM
 customers c