# riesgo_relativo #
El objetivo de este proyecto es encontrar el riesgo relativo dentro de los grupos definidos como 'buenos pagadores' y 'malos pagadores'. Este desarrollo de trabajo partió de una base de datos del banco "super caja" en donde se cuenta con las variables more_90_days_overdue y number_times-delayed_payment_30_59_days.
El proceso fue el siguiente:

🟦 
### Procesar y preparar base de datos ###

Conectar/importar datos a herramientas, identificar y manejar valores nulos, identificar y manejar valores duplicados , identificar y manejar datos fuera del alcance del análisis , identificar y manejar datos inconsistentes en variables categóricas , identificar y manejar datos discrepantes en variables numéricas , comprobar y cambiar tipo de dato , crear nuevas variables , unir tablas , construir tablas auxiliares.

Se verificaron datos null y duplicados. Se pudo observar que del mismo usuario habian varios prestamos, sin embargo no se encontró ningun duplicado.

Para los datos null, se tomó dos caminos, para las variables que los datos null representaban mas del 10%, se hizo imputación según su dritribución (a través de un histograma en Google Colab) y si no eran mayores al 10% se dejaron quietos.

Para los datos outliers, se tomó dos caminos, para las variables que los datos null representaban mas del 10%, se hizo imputación según su dritribución (a través de un histograma en Google Colab) y se visualizo su comportamiento a través de Boxplots (Google Colab).

🟪 
## Hacer un análisis exploratorio ##

Visualización de datos a través de gráficos: Esta técnica nos ayuda a visualizar la distribución y relaciones entre variables como ingresos, edad, deudas y comportamiento de pago de los clientes, proporcionando insights preliminares sobre cómo estas variables podrían influir en el riesgo crediticio.
Resumen estadístico a través de cálculos de medidas descriptivas: Como calcular la media, mediana, desviación estándar, percentiles, etc., para entender la tendencia central, dispersión y forma de la distribución de los datos crediticios.

Análisis de tendencias y patrones: Observar tendencias temporales, estacionales u otros patrones interesantes en los datos, como el comportamiento de pago en diferentes grupos de ingresos o el impacto de la cantidad de dependientes en la capacidad de pago.

Segmentación de datos: Dividir los datos en grupos o segmentos, como diferentes rangos de ingresos o categorías de empleo, para analizarlos por separado y encontrar diferencias significativas en el riesgo crediticio.

🟥  
## Aplicar técnica de análisis ##

Las técnicas de análisis en el ámbito financiero y crediticio pueden ser muy variadas, y su elección depende del problema específico que se pretende solucionar. En algunos casos, se pueden utilizar distintas técnicas combinadas para llegar a un resultado o profundizar los hallazgos.

Las técnicas de análisis en el ámbito financiero y crediticio pueden ser muy variadas, y su elección depende del problema específico que se pretende solucionar. En algunos casos, se pueden utilizar distintas técnicas combinadas para llegar a un resultado o profundizar los hallazgos.

🟧 
## Resumir información en un dashboard ##

Un dashboard es una herramienta de visualización de datos esencial que proporciona una representación gráfica y resumida de información relevante, en este caso, relacionada con el riesgo crediticio de los clientes del banco.

![image](https://github.com/user-attachments/assets/a914759f-5b5c-4325-a400-aa9b867b3998)


### Validación de hipotesis ###
- Los más jóvenes tienen un mayor riesgo de impago.

_Esta hiposis es **verdadera**, el riesgo relativo del grupo mas joven es de 2.3238948510878_

- Las personas con más cantidad de préstamos activos tienen mayor riesgo de ser malos pagadores.

_Esta hiposis es **verdadera**, el riesgo relativo de number_ times_ delayed_ payment_ loan_ 30_ 59_ days es de 31.502429430819063_

- Las personas que han retrasado sus pagos por más de 90 días tienen mayor riesgo de ser malos pagadores.

_Esta hiposis es **verdadera**, el riesgo relativo de more_90_days_overdue es de 46.289284061611689_
