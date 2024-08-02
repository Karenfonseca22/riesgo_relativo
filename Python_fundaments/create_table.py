import pandas as pd
## IMPORTAR UNA NUEVA TABLA DESDE BIGQUERY

# Reemplaza con tu ID de proyecto y el nombre de la nueva tabla
project_id = 'riesgo-relativo-429614'  # Asegúrate de que este sea tu ID de proyecto real
dataset_id = 'Dataset'  # Nombre del conjunto de datos
new_table_id = 'tabla_general'  # Nombre de la nueva tabla

# Define the table ID to be used in the query
general_table_id = new_table_id # Assign the value of new_table_id to flag_table_id

# Consulta SQL para seleccionar los datos de la nueva tabla
general_query = f'SELECT * FROM `{project_id}.{dataset_id}.{general_table_id}`'

# Cargar los datos de la nueva tabla en un nuevo DataFrame
general_df = pd.read_gbq(general_query, project_id=project_id)

# Ahora new_df contiene los datos de la nueva tabla en un DataFrame
