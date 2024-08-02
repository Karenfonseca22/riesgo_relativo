WITH clean_table AS (
  SELECT
    user_id,
    CASE
      WHEN LOWER(loan_type) = 'others' THEN 'other'
      ELSE LOWER(loan_type)
    END AS clean_loan_type
  FROM
    `riesgo-relativo-429614.Dataset.loans_pendientes`
)
SELECT
  user_id,
  SUM(CASE WHEN clean_loan_type = 'real estate' THEN 1 ELSE 0 END) AS total_real_estate_loans,
  SUM(CASE WHEN clean_loan_type = 'other' THEN 1 ELSE 0 END) AS total_other_loans
FROM
  clean_table
GROUP BY
  user_id;
