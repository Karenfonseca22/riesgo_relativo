WITH categ AS (
    SELECT
        t1.user_id,
        CASE
            WHEN (t2.more_90_days_overdue > 0 AND t2.number_times_delayed_payment_loan_30_59_days > 0) THEN 2
            WHEN (t2.more_90_days_overdue > 0 OR t2.number_times_delayed_payment_loan_30_59_days > 0) THEN 1
            ELSE 0
        END AS num_debt_categ_presence,
        CASE
            WHEN (CASE
                    WHEN (t2.more_90_days_overdue > 0 OR t2.number_times_delayed_payment_loan_30_59_days > 0) THEN 1
                    ELSE 0
                  END = 0) THEN 'Buen pagador'
            ELSE 'Mal pagador'
        END AS categ_pagador
    FROM `riesgo-relativo-429614.Dataset.clean_user_info` t1
    LEFT JOIN 
        `riesgo-relativo-429614.Dataset.clean_loans_detail` t2 ON t1.user_id = t2.user_id
)

SELECT 
    t1.*, 
    t2.more_90_days_overdue,
    t2.using_lines_not_secured_personal_assets,
    t2.outlier_stt_usign_lines,
    t2.number_times_delayed_payment_loan_30_59_days,
    t2.outlier_30_59_delay,
    t2.debt_ratio,
    t2.outlier_debt_ratio, 
    t3.total_other_loans,
    t3.total_real_estate_loans,
    (t2.more_90_days_overdue + 
     t2.number_times_delayed_payment_loan_30_59_days) AS total_delayed_payments,
    c.num_debt_categ_presence,
    c.categ_pagador,
FROM `riesgo-relativo-429614.Dataset.clean_user_info` t1
LEFT JOIN 
    `riesgo-relativo-429614.Dataset.clean_loans_detail` t2 ON t1.user_id = t2.user_id
LEFT JOIN 
    `riesgo-relativo-429614.Dataset.clean_loan_outstanding` t3 ON t1.user_id = t3.user_id
LEFT JOIN
    categ c ON t1.user_id = c.user_id
WHERE t2.outlier_stt_usign_lines = 'not_outlier'
  AND t1.outlier_last_month_salary = 'not_outlier'
