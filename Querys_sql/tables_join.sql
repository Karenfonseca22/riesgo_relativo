SELECT
  t1.*,
  t2.*,
  t3.*,
FROM
  `riesgo-relativo-429614.Dataset.clean_user_info` t1
LEFT JOIN
  `riesgo-relativo-429614.Dataset.clean_loans_detail` t2
ON
  t1.user_id = t2.user_id
LEFT JOIN
  `riesgo-relativo-429614.Dataset.clean_loan_outstanding` t3
ON
  t1.user_id = t3.user_id;
