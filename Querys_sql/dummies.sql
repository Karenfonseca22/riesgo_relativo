SELECT
default_flag,
  using_lines_not_secured_personal_assets,
  CASE
    WHEN using_lines_not_secured_personal_assets > 0.53 AND using_lines_not_secured_personal_assets < 1.32 THEN 1
    ELSE 0
  END AS dummies_using_lines_not_secured,
  
  debt_ratio,
  CASE 
    WHEN debt_ratio > 0.36 AND debt_ratio < 0.93 THEN 1 
    ELSE 0
  END AS dummies_debt_ratio,
  
  number_times_delayed_payment_loan_30_59_days,
  CASE 
    WHEN number_times_delayed_payment_loan_30_59_days = 96 THEN 1 
    ELSE 0
  END AS dummies_loan_payment_delayed_30_59,
  
  -- Concatenar las dummies como cadena de texto
  CONCAT(
    CAST(CASE 
      WHEN using_lines_not_secured_personal_assets > 0.53 AND using_lines_not_secured_personal_assets < 1.32 THEN 1 
      ELSE 0 
    END AS STRING),
    CAST(CASE 
      WHEN debt_ratio > 0.36 AND debt_ratio < 0.93 THEN 1 
      ELSE 0 
    END AS STRING),
    CAST(CASE 
      WHEN number_times_delayed_payment_loan_30_59_days = 96 THEN 1 
      ELSE 0 
    END AS STRING)
  ) AS concatenated_values,
  
  -- Validar si el valor concatenado es '000', entonces 0, de lo contrario 1
  CASE 
    WHEN CONCAT(
      CAST(CASE 
        WHEN using_lines_not_secured_personal_assets > 0.53 AND using_lines_not_secured_personal_assets < 1.32 THEN 1 
        ELSE 0 
      END AS STRING),
      CAST(CASE 
        WHEN debt_ratio > 0.36 AND debt_ratio < 0.93 THEN 1 
        ELSE 0 
      END AS STRING),
      CAST(CASE 
        WHEN number_times_delayed_payment_loan_30_59_days = 96 THEN 1 
        ELSE 0 
      END AS STRING)
    ) = '000' THEN 0
    ELSE 1
  END AS prediccion_value
FROM
  `riesgo-relativo-429614.Dataset.tabla_general`;
