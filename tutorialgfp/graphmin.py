import pandas as pd
import matplotlib as plt
import re

minout='/home/bel/arxiusgrans/min1.txt'

df =pd.read_csv(minout,delimiter='\t')

###############
import pandas as pd
import re

# Nombre del archivo de texto
minout= '/home/bel/arxiusgrans/min1.txt'

# Lista para almacenar los datos extraídos
datos = []

# Expresión regular para buscar patrones en cada línea del archivo
patron = re.compile(r'PatronQueCorresponda(.+?)OtroPatron(.+?)OtroPatronMas')

# Abrir el archivo y procesar cada línea
with open(nombre_archivo, 'r') as archivo:
    for linea in archivo:
        match = patron.search(linea)
        if match:
            # Obtener los grupos coincidentes de la expresión regular
            dato1 = match.group(1)
            dato2 = match.group(2)

            # Agregar los datos a la lista
            datos.append([dato1, dato2])

# Crear un DataFrame con los datos
columnas = ['Columna1', 'Columna2']  # Reemplaza con nombres adecuados
df = pd.DataFrame(datos, columns=columnas)

# Mostrar el DataFrame
print(df)