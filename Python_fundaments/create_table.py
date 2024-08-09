from google.colab import auth
from google.cloud import bigquery
import pandas as pd
import IPython

# Autenticar en Google Colab
auth.authenticate_user()

# Crear un cliente de BigQuery
client = bigquery.Client(project="datalab-431915")

# Consulta a BigQuery
query = f"""
SELECT * FROM `{"datalab-431915"}.{"Amazon_sales"}.{"amazon_product_clean"}`
"""
#SELECT * FROM `{"laboratoria2"}.{"datos_hipotesis"}.{"view_unificado"}`

# Obtener todos los registros de la consulta y convertirlos en un DataFrame de Pandas
df = client.query(query).to_dataframe()

IPython.display.display(df)
