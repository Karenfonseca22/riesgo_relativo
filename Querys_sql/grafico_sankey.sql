SELECT
  CASE 
    WHEN default_flag = 0 THEN 'Buen pagador (Default_flag)' 
    ELSE 'Mal pagador (Default_flag)' 
  END AS pagador_default,
  CASE 
    WHEN prediccion_value = 0 THEN 'Buen pagador (Matriz)' 
    ELSE 'Mal pagador (Matriz)' 
  END AS prediccion_pagador,
  COUNT(*) as flujo
FROM
  `riesgo-relativo-429614.Dataset.dummies`
GROUP BY 
  default_flag, prediccion_value;
