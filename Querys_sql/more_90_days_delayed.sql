-- Paso 1: Crear una tabla temporal con los datos base
WITH base_data AS (
    SELECT
        more_90_days_overdue,
        default_flag
    FROM `riesgo-relativo-429614.Dataset.tabla_general`
),
-- Paso 2: Calcular los cuartiles para la variable age
quartiles AS (
    SELECT
        more_90_days_overdue,
        default_flag,
        NTILE(4) OVER (ORDER BY more_90_days_overdue) AS more_90_overdue_quartile
    FROM base_data
),
-- Paso 3: Calcular el número total de malos y buenos pagadores por cuartil
quartile_risk AS (
    SELECT
        more_90_overdue_quartile,
        COUNT(*) AS total_count,
        SUM(default_flag) AS total_bad_payers,
        AVG(default_flag) AS tasa_bad_payers,
        COUNT(*) - SUM(default_flag) AS total_good_payers,
    FROM quartiles
    GROUP BY more_90_overdue_quartile
),
-- Paso 4: Obtener el rango de edad (mínimo y máximo) para cada cuartil
quartile_ranges AS (
    SELECT
        more_90_overdue_quartile,
        MIN(more_90_days_overdue) AS min_90_overdue,
        MAX(more_90_days_overdue) AS max_90_overdue
    FROM quartiles
    GROUP BY more_90_overdue_quartile
),
-- Paso 5: Calcular el riesgo relativo usando la nueva fórmula
risk_relative AS (
    SELECT
        q.more_90_overdue_quartile,
        q.total_count,
        q.total_bad_payers,
        q.tasa_bad_payers,
        q.total_good_payers,
        r.min_90_overdue,
        r.max_90_overdue,
        CASE
            WHEN q.more_90_overdue_quartile = 1 THEN (((q1.total_bad_payers/q1.total_count))/((q2.total_bad_payers+q3.total_bad_payers+q4.total_bad_payers)/(q2.total_count+q3.total_count+q4.total_count)))
            WHEN q.more_90_overdue_quartile = 2 THEN (((q2.total_bad_payers / q2.total_count)) / ((q1.total_bad_payers + q3.total_bad_payers + q4.total_bad_payers) / (q1.total_count + q3.total_count +q4.total_count)))
            WHEN q.more_90_overdue_quartile = 3 THEN (((q3.total_bad_payers / q3.total_count)) / ((q1.total_bad_payers + q2.total_bad_payers + q4.total_bad_payers) / (q1.total_count + q2.total_count +q4.total_count)))
            WHEN q.more_90_overdue_quartile = 4 THEN (((q4.total_bad_payers / q4.total_count)) / ((q1.total_bad_payers + q2.total_bad_payers + q3.total_bad_payers) / (q1.total_count + q2.total_count +q3.total_count)))
        END AS riesgo_relativo
    FROM quartile_risk q
    JOIN quartile_ranges r ON q.more_90_overdue_quartile = r.more_90_overdue_quartile
    LEFT JOIN quartile_risk q1 ON q1.more_90_overdue_quartile = 1
    LEFT JOIN quartile_risk q2 ON q2.more_90_overdue_quartile = 2
    LEFT JOIN quartile_risk q3 ON q3.more_90_overdue_quartile = 3
    LEFT JOIN quartile_risk q4 ON q4.more_90_overdue_quartile = 4
)
-- Paso 6: Seleccionar los resultados finales
SELECT
    more_90_overdue_quartile,
    total_count,
    total_bad_payers,
    tasa_bad_payers,
    total_good_payers,
    riesgo_relativo,
    min_90_overdue,
    max_90_overdue
FROM risk_relative
ORDER BY more_90_overdue_quartile ASC;
