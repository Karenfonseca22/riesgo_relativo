--- Al ver los nulos de la variable last_month_salary, se visualizaron los nulos por tipo de pagador y en un hitograma su distribución
 para decidir si se hace imputación con media, mediana o moda
   
  SELECT
  COUNT(*) AS total_filas,
  SUM(CASE
      WHEN last_month_salary IS NULL THEN 1
      ELSE 0
  END
    ) AS nulos,
  (SUM(CASE
        WHEN last_month_salary IS NULL THEN 1
        ELSE 0
    END
      ) / COUNT(*)) * 100 AS porcentaje_nulos
FROM
  `riesgo-relativo-429614.Dataset.user_info`

------------------------------------------

- Se decidió imputar, ya que estos nulos representan mas del 10% de los datos y se hizo con la mediana ya que su distribucion no era normal

WITH mediana AS (
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
  u.user_id,
  u.age,
  u.sex,
  u.number_dependents,
  u.default_flag,
  u.last_month_salary,
  COALESCE(
    last_month_salary,
    mediana.mediana_salario
  ) AS last_month_salary_imputado
FROM
  `riesgo-relativo-429614.Dataset.user_info_flag` AS u
LEFT JOIN
  mediana
ON
  u.default_flag = mediana.default_flag;
