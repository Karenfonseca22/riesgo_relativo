---Se realizo este test de correlación para ver so exixtia alguna multicolinealidad.
WITH crr_salary AS (
  SELECT
    CORR(last_month_salary, age) AS salary_age_corr
  FROM `riesgo-relativo-429614.Dataset.user_info`
)
SELECT 
  (SELECT salary_age_corr FROM crr_salary) AS salary_age_corr,
  CORR(number_times_delayed_payment_loan_30_59_days, number_times_delayed_payment_loan_60_89_days) AS rela_30_59_y_60_89,
  CORR(more_90_days_overdue, number_times_delayed_payment_loan_30_59_days) AS rela_30_59_y_mas_90,
  CORR(number_times_delayed_payment_loan_60_89_days, more_90_days_overdue) AS rela_60_89_y_more_90
FROM `riesgo-relativo-429614.Dataset.loans_detalle`
