import pandas as pd
import re

# Lista para almacenar los datos
datos = []

# Ruta al archivo .txt
ruta_archivo = '/home/bel/arxiusgrans/min1.txt'

# Palabras clave a buscar
palabras_clave = ['NSTEP', 'BOND', 'VDWAALS']

# Lectura del archivo
with open(ruta_archivo, 'r') as archivo:
    # Inicializamos un diccionario para almacenar temporalmente los datos de cada entrada
    entrada_actual = {}
    
    # Iteramos sobre las líneas del archivo
    for linea in archivo:
        # Verificamos si la línea contiene alguna palabra clave
        for palabra_clave in palabras_clave:
            # Utilizamos expresiones regulares para buscar la palabra clave y extraer el valor numérico
            coincidencia = re.search(f'{palabra_clave}: (\d+)', linea)
            if coincidencia:
                # Almacenamos la palabra clave y el valor numérico en el diccionario temporal
                entrada_actual[palabra_clave] = int(coincidencia.group(1))
    
    # Verificamos si encontramos al menos una palabra clave en la línea actual
    if entrada_actual:
        # Agregamos los datos al listado
        datos.append(entrada_actual)

# Creamos el DataFrame
df = pd.DataFrame(datos)

# Imprimimos el DataFrame
print(df)
