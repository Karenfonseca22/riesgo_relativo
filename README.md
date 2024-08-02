Aquí tienes la traducción al inglés:

---

# Relative Risk #
The goal of this project is to find the relative risk within the groups defined as 'good payers' and 'bad payers'. This work started with a database from the bank "Super Caja," which includes the variables `more_90_days_overdue` and `number_times_delayed_payment_30_59_days`.

The process was as follows:

🟦 
### Process and Prepare Database ###

Connect/import data into tools, identify and handle missing values, identify and handle duplicate values, identify and handle out-of-scope data, identify and handle inconsistent data in categorical variables, identify and handle outlier data in numerical variables, check and change data types, create new variables, join tables, construct auxiliary tables.

Null and duplicate data were checked. It was observed that there were multiple loans for the same user; however, no duplicates were found.

For missing data, two approaches were taken. For variables where missing data represented more than 10%, imputation was performed according to its distribution (using a histogram in Google Colab). If it was less than 10%, the data was left as is.

For outliers, two approaches were taken. For variables where outliers represented more than 10%, imputation was performed according to its distribution (using a histogram in Google Colab), and their behavior was visualized through Boxplots (Google Colab).

🟪 
## Perform Exploratory Analysis ##

Data visualization through charts: This technique helps us visualize the distribution and relationships between variables such as income, age, debt, and payment behavior of clients, providing preliminary insights into how these variables might influence credit risk.

Statistical summary through descriptive statistics calculations: Such as calculating mean, median, standard deviation, percentiles, etc., to understand the central tendency, dispersion, and shape of the distribution of credit data.

Trend and pattern analysis: Observing temporal, seasonal, or other interesting patterns in the data, such as payment behavior in different income groups or the impact of the number of dependents on payment capacity.

Data segmentation: Dividing data into groups or segments, such as different income ranges or employment categories, to analyze them separately and find significant differences in credit risk.

🟥  
## Apply Analytical Techniques ##

Analytical techniques in the financial and credit domain can be quite varied, and their choice depends on the specific problem to be solved. In some cases, different techniques can be combined to reach a result or deepen findings.

🟧 
## Summarize Information in a Dashboard ##

A dashboard is an essential data visualization tool that provides a graphical and summarized representation of relevant information, in this case, related to the credit risk of the bank's clients.

![image](https://github.com/user-attachments/assets/a914759f-5b5c-4325-a400-aa9b867b3998)


### Validación de hipotesis ###
- Los más jóvenes tienen un mayor riesgo de impago.

_Esta hiposis es **verdadera**, el riesgo relativo del grupo mas joven es de 2.3238948510878_

- Las personas con más cantidad de préstamos activos tienen mayor riesgo de ser malos pagadores.

_Esta hiposis es **verdadera**, el riesgo relativo de number_ times_ delayed_ payment_ loan_ 30_ 59_ days es de 31.502429430819063_

- Las personas que han retrasado sus pagos por más de 90 días tienen mayor riesgo de ser malos pagadores.

_Esta hiposis es **verdadera**, el riesgo relativo de more_90_days_overdue es de 46.289284061611689_
