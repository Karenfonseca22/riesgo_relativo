--- Contar valores segun variables, el objetivo es porder ubicarlos en la tabla de Google Sheets y calcular su riesgo relativo

--- Resultados para poner en las tablas de Google Sheets, mirar cuantas veces estaba en la variable y que fueran Buen o Mal pagador
-- Contar las filas para d_30_59_cuartiles = 1
SELECT
  'cuartil = 4 Buen pagador' AS criterio,
  COUNT(*) AS count
FROM `riesgo-relativo-429614.Dataset.cuartiles-riesgo-relativo`
WHERE d_30_59_cuartiles = 1 AND categ_pagador = 'Buen pagador'

UNION ALL

-- Contar las filas para d_30_59_cuartiles IN (3, 2, 4)
SELECT
  'cuartil IN (1, 2, 3) Buen pagador' AS criterio,
  COUNT(*) AS count
FROM `riesgo-relativo-429614.Dataset.cuartiles-riesgo-relativo`
WHERE d_30_59_cuartiles IN (4, 2, 3) AND categ_pagador = 'Buen pagador'

------------- Mal pagador
UNION ALL

SELECT
  'cuartil = 4 Mal pagador' AS criterio,
  COUNT(*) AS count
FROM `riesgo-relativo-429614.Dataset.cuartiles-riesgo-relativo`
WHERE d_30_59_cuartiles = 1 AND categ_pagador = 'Mal pagador'

UNION ALL

-- Contar las filas para d_30_59_cuartiles IN (3, 2, 4)
SELECT
  'cuartiles IN (1, 2, 3)Mal pagador' AS criterio,
  COUNT(*) AS count
FROM `riesgo-relativo-429614.Dataset.cuartiles-riesgo-relativo`
WHERE d_30_59_cuartiles IN (4, 2, 3) AND categ_pagador = 'Mal pagador'
