-- Paso 1: Crear una tabla temporal con los datos base
WITH base_data AS (
    SELECT
        last_month_salary_imputado,
        default_flag
    FROM `riesgo-relativo-429614.Dataset.tabla_general`
),
-- Paso 2: Calcular los cuartiles para la variable age
quartiles AS (
    SELECT
        last_month_salary_imputado,
        default_flag,
        NTILE(4) OVER (ORDER BY last_month_salary_imputado) AS last_salary_quartile
    FROM base_data
),
-- Paso 3: Calcular el número total de malos y buenos pagadores por cuartil
quartile_risk AS (
    SELECT
        last_salary_quartile,
        COUNT(*) AS total_count,
        SUM(default_flag) AS total_bad_payers,
        AVG(default_flag) AS tasa_bad_payers,
        COUNT(*) - SUM(default_flag) AS total_good_payers,
    FROM quartiles
    GROUP BY last_salary_quartile
),
-- Paso 4: Obtener el rango de edad (mínimo y máximo) para cada cuartil
quartile_ranges AS (
    SELECT
        last_salary_quartile,
        MIN(last_month_salary_imputado) AS min_last_salary,
        MAX(last_month_salary_imputado) AS max_last_salary
    FROM quartiles
    GROUP BY last_salary_quartile
),
-- Paso 5: Calcular el riesgo relativo usando la nueva fórmula
risk_relative AS (
    SELECT
        q.last_salary_quartile,
        q.total_count,
        q.total_bad_payers,
        q.tasa_bad_payers,
        q.total_good_payers,
        r.min_last_salary,
        r.max_last_salary,
        CASE
            WHEN q.last_salary_quartile = 1 THEN (((q1.total_bad_payers/q1.total_count))/((q2.total_bad_payers+q3.total_bad_payers+q4.total_bad_payers)/(q2.total_count+q3.total_count+q4.total_count)))
            WHEN q.last_salary_quartile = 2 THEN (((q2.total_bad_payers / q2.total_count)) / ((q1.total_bad_payers + q3.total_bad_payers + q4.total_bad_payers) / (q1.total_count + q3.total_count +q4.total_count)))
            WHEN q.last_salary_quartile = 3 THEN (((q3.total_bad_payers / q3.total_count)) / ((q1.total_bad_payers + q2.total_bad_payers + q4.total_bad_payers) / (q1.total_count + q2.total_count +q4.total_count)))
            WHEN q.last_salary_quartile = 4 THEN (((q4.total_bad_payers / q4.total_count)) / ((q1.total_bad_payers + q2.total_bad_payers + q3.total_bad_payers) / (q1.total_count + q2.total_count +q3.total_count)))
        END AS riesgo_relativo
    FROM quartile_risk q
    JOIN quartile_ranges r ON q.last_salary_quartile = r.last_salary_quartile
    LEFT JOIN quartile_risk q1 ON q1.last_salary_quartile = 1
    LEFT JOIN quartile_risk q2 ON q2.last_salary_quartile = 2
    LEFT JOIN quartile_risk q3 ON q3.last_salary_quartile = 3
    LEFT JOIN quartile_risk q4 ON q4.last_salary_quartile = 4
)
-- Paso 6: Seleccionar los resultados finales
SELECT
    last_salary_quartile,
    total_count,
    total_bad_payers,
    tasa_bad_payers,
    total_good_payers,
    riesgo_relativo,
    min_last_salary,
    max_last_salary
FROM risk_relative
ORDER BY last_salary_quartile ASC;
