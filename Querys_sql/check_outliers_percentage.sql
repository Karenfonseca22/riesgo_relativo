--- Formula para sacar el porcentaje de mis datos atipicos, esto ayudo para tomar la decision de eliminar los outliers, ya que me representaban menos del 10% 
SELECT
  SUM(CASE
      WHEN outlier_90_delay = 'outlier_above' THEN 1
      ELSE 0
  END
    )*100 / COUNT(*) AS porcentaje
FROM
  `riesgo-relativo-429614.Dataset.tabla_general`
