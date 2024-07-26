--- Observar y agregar tagline a los datos atipicos de una sola variable, en este caso de la variable 'last_month_salary'

WITH
  quartiles AS (
  SELECT
    APPROX_QUANTILES(last_month_salary, 4)[
  OFFSET
    (1)] AS Q1,
    APPROX_QUANTILES(last_month_salary, 4)[
  OFFSET
    (3)] AS Q3
  
  FROM
    `riesgo-relativo-429614.Dataset.user_info_flag` ),
  rango_inter AS (
  SELECT
    Q1,
    Q3,
    CAST(Q3 - Q1 AS FLOAT64) AS IQR
  FROM
    quartiles ),
  limite AS (
  SELECT
    Q1,
    Q3,
    IQR,
    Q1 - 1.5 * IQR AS limite_inferior,
    Q3 + 1.5 * IQR AS limite_superior
  FROM
    rango_inter)
SELECT
  ld.*,
  CASE
    WHEN ld.last_month_salary < limite.limite_inferior THEN 'outlier_below'
    WHEN ld.last_month_salary > limite.limite_superior THEN 'outlier_above'
    ELSE 'not_outlier'
END
  AS outlier_status_more_90
FROM
  `riesgo-relativo-429614.Dataset.user_info_flag` AS ld,
  limite
ORDER BY
  ld.last_month_salary;
