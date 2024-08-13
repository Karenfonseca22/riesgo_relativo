from google.colab import auth
from google.cloud import bigquery
import pandas as pd
import IPython

# Autenticar en Google Colab
auth.authenticate_user()

# Crear un cliente de BigQuery
client = bigquery.Client(project="idproyecto-1234")

# Consulta a BigQuery
query = f"""
SELECT * FROM `{"iddeproyecto"}.{"nombre_dataset"}.{"nombre_tabla_o_vista"}`
"""
#SELECT * FROM `{"laboratoria2"}.{"datos_hipotesis"}.{"view_unificado"}`

# Obtener todos los registros de la consulta y convertirlos en un DataFrame de Pandas
df = client.query(query).to_dataframe()

IPython.display.display(df)
