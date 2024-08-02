--- Formula para la vista de clasificacion de riesgos, esta vista me permite saber cual es el riesgo segun su cuartil.
SELECT
user_id,
age,
default_flag,
more_90_cuartiles,
more_90_days_overdue,
not_secured_cuartiles,
using_lines_not_secured_personal_assets,
d_30_59_cuartiles,
number_times_delayed_payment_loan_30_59_days,
debt_ratio_cuartiles,
debt_ratio,
last_salary_cuartiles,
last_month_salary_imputado,
age_cuartiles,
number_dependents,
dependents_cuartiles,
CASE 
  WHEN more_90_cuartiles = 1 THEN 0.085860998995
  WHEN more_90_cuartiles = 2 THEN 0.0316320068794
  WHEN more_90_cuartiles = 3 THEN 0.069400369869623
  ELSE 46.289284061611
END as riesgo_more_90,
CASE 
  WHEN not_secured_cuartiles = 1 THEN 0.04232477816437
  WHEN not_secured_cuartiles = 2 THEN 0.005226077791638
  WHEN not_secured_cuartiles = 3 THEN 0.17096906728910907
  ELSE 40.1280946321147
END as riesgo_not_secures_lines,
CASE 
  WHEN d_30_59_cuartiles = 1 THEN 0.14779882046497
  WHEN d_30_59_cuartiles = 2 THEN 0.015733052372
  WHEN d_30_59_cuartiles = 3 THEN 0.1081164459230
  ELSE 31.5024294308190
END as riesgo_30_59_delay,
CASE 
  WHEN debt_ratio_cuartiles = 1 THEN 0.73370964874724
  WHEN debt_ratio_cuartiles = 2 THEN 0.85899415549715
  WHEN debt_ratio_cuartiles = 3 THEN 1.4923025846444
  ELSE 0.9931321447546
END as riesgo_debt_ratio,
CASE 
  WHEN age_cuartiles = 1 THEN 2.32389485108783
  WHEN age_cuartiles = 2 THEN 1.3016452506674 
  WHEN age_cuartiles = 3 THEN 0.69384365831109
  ELSE 0.4294565784377
END as riesgo_age,
CASE 
  WHEN last_salary_cuartiles = 1 THEN 1.7915285007390
  WHEN last_salary_cuartiles = 2 THEN 1.7258942931617
  WHEN last_salary_cuartiles = 3 THEN 0.4708612619725
  ELSE 1.012937984
END as riesgo_last_salary,
CASE 
  WHEN dependents_cuartiles = 1 THEN 1.34498443356987
  WHEN dependents_cuartiles = 2 THEN 0.513198710390
  WHEN dependents_cuartiles = 3 THEN 0.876472086892
  ELSE 1.4006182181340
END as riesgo_dependents,
FROM `riesgo-relativo-429614.Dataset.cuartiles-riesgo-relativo`
