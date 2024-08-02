- Vista limpia incluyendo cuartiles, excepto para la variable more_90_days_overdue
WITH
  quartiles AS (
    SELECT
      APPROX_QUANTILES(using_lines_not_secured_personal_assets, 4)[OFFSET(1)] AS Q1_assets,
      APPROX_QUANTILES(using_lines_not_secured_personal_assets, 4)[OFFSET(3)] AS Q3_assets,
      APPROX_QUANTILES(number_times_delayed_payment_loan_30_59_days, 4)[OFFSET(1)] AS Q1_30_59_delays,
      APPROX_QUANTILES(number_times_delayed_payment_loan_30_59_days, 4)[OFFSET(3)] AS Q3_30_59_delays,
      APPROX_QUANTILES(number_times_delayed_payment_loan_60_89_days, 4)[OFFSET(1)] AS Q1_60_89_delays,
      APPROX_QUANTILES(number_times_delayed_payment_loan_60_89_days, 4)[OFFSET(3)] AS Q3_60_89_delays,
      APPROX_QUANTILES(debt_ratio, 4)[OFFSET(1)] AS Q1_debt,
      APPROX_QUANTILES(debt_ratio, 4)[OFFSET(3)] AS Q3_debt
    FROM
      `riesgo-relativo-429614.Dataset.loans_detalle`
  ),
  rango_inter AS (
    SELECT
      Q1_assets,
      Q3_assets,
      Q1_30_59_delays,
      Q3_30_59_delays,
      Q1_60_89_delays,
      Q3_60_89_delays,
      Q1_debt,
      Q3_debt,
      CAST(Q3_assets - Q1_assets AS FLOAT64) AS IQR_assets,
      CAST(Q3_30_59_delays - Q1_30_59_delays AS FLOAT64) AS IQR_30_59_delays,
      CAST(Q3_60_89_delays - Q1_60_89_delays AS FLOAT64) AS IQR_60_89_delays,
      CAST(Q3_debt - Q1_debt AS FLOAT64) AS IQR_debt
    FROM
      quartiles
  ),
  limite AS (
    SELECT
      Q1_assets,
      Q3_assets,
      Q1_30_59_delays,
      Q3_30_59_delays,
      Q1_60_89_delays,
      Q3_60_89_delays,
      Q1_debt,
      Q3_debt,
      IQR_assets,
      IQR_30_59_delays,
      IQR_60_89_delays,
      IQR_debt,
      Q1_assets - 1.5 * IQR_assets AS limite_inferior_assets,
      Q3_assets + 1.5 * IQR_assets AS limite_superior_assets,
      Q1_30_59_delays - 1.5 * IQR_30_59_delays AS limite_inferior_30_59,
      Q3_30_59_delays + 1.5 * IQR_30_59_delays AS limite_superior_30_59,
      Q1_60_89_delays - 1.5 * IQR_60_89_delays AS limite_inferior_60_89,
      Q3_60_89_delays + 1.5 * IQR_60_89_delays AS limite_superior_60_89,
      Q1_debt - 1.5 * IQR_debt AS limite_inferior_debt,
      Q3_debt + 1.5 * IQR_debt AS limite_superior_debt
    FROM
      rango_inter
  )
SELECT
  ld.*,
  CASE
    WHEN ld.using_lines_not_secured_personal_assets < limite.limite_inferior_assets THEN 'outlier_below'
    WHEN ld.using_lines_not_secured_personal_assets > limite.limite_superior_assets THEN 'outlier_above'
    ELSE 'not_outlier'
  END AS outlier_stt_usign_lines,
  CASE
    WHEN ld.number_times_delayed_payment_loan_30_59_days < limite.limite_inferior_30_59 THEN 'outlier_below'
    WHEN ld.number_times_delayed_payment_loan_30_59_days > limite.limite_superior_30_59 THEN 'outlier_above'
    ELSE 'not_outlier'
  END AS outlier_30_59_delay,
  CASE
    WHEN ld.number_times_delayed_payment_loan_60_89_days < limite.limite_inferior_60_89 THEN 'outlier_below'
    WHEN ld.number_times_delayed_payment_loan_60_89_days > limite.limite_superior_60_89 THEN 'outlier_above'
    ELSE 'not_outlier'
  END AS outlier_60_89_delay,
  CASE
    WHEN ld.debt_ratio < limite.limite_inferior_debt THEN 'outlier_below'
    WHEN ld.debt_ratio > limite.limite_superior_debt THEN 'outlier_above'
    ELSE 'not_outlier'
  END AS outlier_debt_ratio
FROM
  `riesgo-relativo-429614.Dataset.loans_detalle` AS ld
  CROSS JOIN limite
-----------------------------Se filtrarons los datos de la variable 'more_90_days_overdue', por los menores a 98.
WHERE
  ld.more_90_days_overdue < 98
ORDER BY
  ld.using_lines_not_secured_personal_assets,
  ld.number_times_delayed_payment_loan_30_59_days,
  ld.number_times_delayed_payment_loan_60_89_days,
  ld.debt_ratio;
