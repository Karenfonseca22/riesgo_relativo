-- Se hace este analisis para excluir de la base de datos la variable con la menor desvación estandar, ya que se convertiría en la menos interesante para sacar conclusiones.
SELECT
STDDEV(more_90_days_overdue) AS std_more90,
STDDEV(number_times_delayed_payment_loan_30_59_days) AS std_30to59,
STDDEV (number_times_delayed_payment_loan_60_89_days) AS std_60_89
FROM `riesgo-relativo-429614.Dataset.loans_detalle` LIMIT 1000
