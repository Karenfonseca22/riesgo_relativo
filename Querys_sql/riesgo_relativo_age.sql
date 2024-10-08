-- Paso 1: Crear una tabla temporal con los datos base
WITH base_data AS (
    SELECT
        age,
        default_flag
    FROM `riesgo-relativo-429614.Dataset.tabla_general`
),
-- Paso 2: Calcular los cuartiles para la variable age
quartiles AS (
    SELECT
        age,
        default_flag,
        NTILE(4) OVER (ORDER BY age) AS age_quartile
    FROM base_data
),
-- Paso 3: Calcular el número total de malos y buenos pagadores por cuartil
quartile_risk AS (
    SELECT
        age_quartile,
        COUNT(*) AS total_count,
        SUM(default_flag) AS total_bad_payers,
        AVG(default_flag) AS tasa_bad_payers,
        COUNT(*) - SUM(default_flag) AS total_good_payers,
    FROM quartiles
    GROUP BY age_quartile
),
-- Paso 4: Obtener el rango de edad (mínimo y máximo) para cada cuartil
quartile_ranges AS (
    SELECT
        age_quartile,
        MIN(age) AS min_age,
        MAX(age) AS max_age
    FROM quartiles
    GROUP BY age_quartile
),
-- Paso 5: Calcular el riesgo relativo usando la nueva fórmula
risk_relative AS (
    SELECT
        q.age_quartile,
        q.total_count,
        q.total_bad_payers,
        q.tasa_bad_payers,
        q.total_good_payers,
        r.min_age,
        r.max_age,
        CASE
            WHEN q.age_quartile = 1 THEN (((q1.total_bad_payers/q1.total_count))/((q2.total_bad_payers+q3.total_bad_payers+q4.total_bad_payers)/(q2.total_count+q3.total_count+q4.total_count)))
            WHEN q.age_quartile = 2 THEN (((q2.total_bad_payers / q2.total_count)) / ((q1.total_bad_payers + q3.total_bad_payers + q4.total_bad_payers) / (q1.total_count + q3.total_count +q4.total_count)))
            WHEN q.age_quartile = 3 THEN (((q3.total_bad_payers / q3.total_count)) / ((q1.total_bad_payers + q2.total_bad_payers + q4.total_bad_payers) / (q1.total_count + q2.total_count +q4.total_count)))
            WHEN q.age_quartile = 4 THEN (((q4.total_bad_payers / q4.total_count)) / ((q1.total_bad_payers + q2.total_bad_payers + q3.total_bad_payers) / (q1.total_count + q2.total_count +q3.total_count)))
        END AS riesgo_relativo
    FROM quartile_risk q
    JOIN quartile_ranges r ON q.age_quartile = r.age_quartile
    LEFT JOIN quartile_risk q1 ON q1.age_quartile = 1
    LEFT JOIN quartile_risk q2 ON q2.age_quartile = 2
    LEFT JOIN quartile_risk q3 ON q3.age_quartile = 3
    LEFT JOIN quartile_risk q4 ON q4.age_quartile = 4
)
-- Paso 6: Seleccionar los resultados finales
SELECT
    age_quartile,
    total_count,
    total_bad_payers,
    tasa_bad_payers,
    total_good_payers,
    riesgo_relativo,
    min_age,
    max_age
FROM risk_relative
ORDER BY age_quartile ASC;
