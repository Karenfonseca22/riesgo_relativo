--- Identificar nulos en una variable especifica, para este proyecto en la variable last_month_salary

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
