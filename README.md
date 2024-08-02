
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
### Perform Exploratory Analysis ###

Data visualization through charts: This technique helps us visualize the distribution and relationships between variables such as income, age, debt, and payment behavior of clients, providing preliminary insights into how these variables might influence credit risk.

Statistical summary through descriptive statistics calculations: Such as calculating mean, median, standard deviation, percentiles, etc., to understand the central tendency, dispersion, and shape of the distribution of credit data.

Trend and pattern analysis: Observing temporal, seasonal, or other interesting patterns in the data, such as payment behavior in different income groups or the impact of the number of dependents on payment capacity.

Data segmentation: Dividing data into groups or segments, such as different income ranges or employment categories, to analyze them separately and find significant differences in credit risk.


![image](https://github.com/user-attachments/assets/582a5f2e-4fbc-4aad-8eda-c39cd195d07b)

🟥  
### Apply Analytical Techniques ###

Analytical techniques in the financial and credit domain can be quite varied, and their choice depends on the specific problem to be solved. In some cases, different techniques can be combined to reach a result or deepen findings.

---

The relative risk technique can be found at this link: https://www.youtube.com/watch?v=df4ePYdNGBY&t=149s

In the Q1 subgroup, which would represent the exposed group of bad payers, divide this by the sum of the non-exposed group (Q2, Q3, Q4) of both good and bad payers. Then divide the incidence rates to create the relative risk.

---

![image](https://github.com/user-attachments/assets/687273b8-d4fc-45ea-9285-ed9ad107d26f)

![image](https://github.com/user-attachments/assets/7e1806fa-b69b-4b14-985d-336408871e60)

### Relative risk results ###

- rr.using_lines_not_secured

![image](https://github.com/user-attachments/assets/8bc58fc0-8abb-40f8-a869-d8db5d7a4bda)

- rr_age

![image](https://github.com/user-attachments/assets/e62df8b5-c0b0-4d8d-913b-3be15c32ab33)

- rr_debt_ratio

![image](https://github.com/user-attachments/assets/bffc4d61-aaa5-43a5-8ae0-40d8453c7897)

-- rr_delayed_30_59

![image](https://github.com/user-attachments/assets/ce097de5-3702-4e4b-9df6-ba3f2f4084bb)

-- rr_last_month_salary

![image](https://github.com/user-attachments/assets/617c5ff9-15ae-4cb4-828c-7a356b22ae84)

-- rr_more_90_days_overdue

![image](https://github.com/user-attachments/assets/5a7b00e4-d5a8-440c-befc-d08e0af49142)

-- rr_number_dependents

![image](https://github.com/user-attachments/assets/f0a551b6-31ea-4126-8db4-254aae9101db)


🟧 
### Summarize Information in a Dashboard ###

A dashboard is an essential data visualization tool that provides a graphical and summarized representation of relevant information, in this case, related to the credit risk of the bank's clients.

![image](https://github.com/user-attachments/assets/a914759f-5b5c-4325-a400-aa9b867b3998)

Link de dashboard interactivo [riesgo_relativo](https://lookerstudio.google.com/reporting/2a8c55ed-4abb-4fd2-bb19-fa7c2a46c9b7).

-----------

### Hypothesis Validation ###
- Younger individuals have a higher risk of default.

_This hypothesis is **true**; the relative risk for the youngest group is 2.3238948510878._

- People with a higher number of active loans have a greater risk of being bad payers.

_This hypothesis is **true**; the relative risk for `number_times_delayed_payment_loan_30_59_days` is 31.502429430819063._

- People who have delayed payments by more than 90 days have a higher risk of being bad payers.

_This hypothesis is **true**; the relative risk for `more_90_days_overdue` is 46.289284061611689._
