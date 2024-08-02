WITH quartiles AS (
  SELECT
    APPROX_QUANTILES(last_month_salary, 4)[OFFSET(1)] AS Q1,
    APPROX_QUANTILES(last_month_salary, 4)[OFFSET(3)] AS Q3
  FROM
    `riesgo-relativo-429614.Dataset.user_info_flag`
),
rango_inter AS (
  SELECT
    Q1,
    Q3,
    CAST(Q3 - Q1 AS FLOAT64) AS IQR
  FROM
    quartiles
),
limite AS (
  SELECT
    Q1,
    Q3,
    IQR,
    Q1 - 1.5 * IQR AS limite_inferior,
    Q3 + 1.5 * IQR AS limite_superior
  FROM
    rango_inter
),
mediana AS (
  SELECT
    default_flag,
    APPROX_QUANTILES(last_month_salary, 2)[OFFSET(1)] AS mediana_salario
  FROM
    `riesgo-relativo-429614.Dataset.user_info_flag`
  WHERE
    last_month_salary IS NOT NULL
  GROUP BY
    default_flag
)
SELECT
  ld.user_id,
  ld.age,
  UPPER(ld.sex) AS mayu_sex,
  ld.number_dependents,
  ld.default_flag,
  ld.generacion,
  CASE
    WHEN ld.last_month_salary < limite.limite_inferior THEN 'outlier_below'
    WHEN ld.last_month_salary > limite.limite_superior THEN 'outlier_above'
    ELSE 'not_outlier'
  END AS outlier_last_month_salary,
  COALESCE(ld.last_month_salary, mediana.mediana_salario) AS last_month_salary_imputado
FROM
  `riesgo-relativo-429614.Dataset.user_info_flag` AS ld
CROSS JOIN
  limite
LEFT JOIN
  mediana ON ld.default_flag = mediana.default_flag
ORDER BY
  ld.last_month_salary;
