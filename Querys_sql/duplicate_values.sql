--- Identificar valores duplicados por tabla
---- -- Encuentra duplicados, en donde la combinacion de user_id y loan_id esten duplicados
--------------------------
TABLA 1
SELECT
  user_id,
  loan_id,
  COUNT(*) AS cantidad_dupli
FROM `riesgo-relativo-429614.Dataset.loans_pendientes`
GROUP BY
  user_id,
  loan_id
HAVING
  cantidad_dupli > 1
---------------------------
TABLA 2
SELECT
user_id,
COUNT(*) AS num_id
FROM `riesgo-relativo-429614.Dataset.default`
GROUP BY
user_id
HAVING
num_id >1
-----------------------------
TABLA 3
SELECT
user_id,
COUNT(*) AS cantidad_ids
FROM `riesgo-relativo-429614.Dataset.loans_detalle`
GROUP BY
user_id
HAVING
cantidad_ids >1
---------------------------
TABLA 4
SELECT
user_id,
COUNT(*) AS cantidad
FROM `riesgo-relativo-429614.Dataset.user_info`
GROUP BY
user_id
HAVING
cantidad >1

