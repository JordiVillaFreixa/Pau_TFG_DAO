import pandas as pd

# Ruta al archivo .txt
ruta_archivo = '/home/bel/arxiusgrans/min1.txt'

# Diccionario para almacenar los datos
datos = {'NSTEP': [], 'ENERGY': [], 'RMS': [], 'GMAX': [], 'NAME': [], 'NUMBER': [],
         'BOND': [], 'ANGLE': [], 'DIHED': [], 'VDWAALS': [], 'EEL': [], 'EGB': [],
         '1-4 VDW': [], '1-4 EEL': [], 'RESTRAINT': []}

# Lectura del archivo
with open(ruta_archivo, 'r') as archivo:
    for linea in archivo:
        if ' NSTEP       ENERGY          RMS            GMAX         NAME    NUMBER' in linea:
            print(linea)
            
            valores = linea.split()
            datos['NSTEP'].append(int(valores[0]))
            datos['ENERGY'].append(float(valores[1]))
            datos['RMS'].append(float(valores[2]))
            datos['GMAX'].append(float(valores[3]))
            datos['NAME'].append(valores[4])
            datos['NUMBER'].append(int(valores[5]))
        elif '=' in linea:
            print(linea)
            clave, valor = linea.split('\=')
            clave = clave.strip()
            valor = float(valor.strip())
            # Asegurarse de que la clave es válida antes de intentar agregarla al diccionario
            if clave in datos:
                datos[clave].append(valor)

# Crear un DataFrame
df = pd.DataFrame(datos)

# Imprimir el DataFrame
print(df)
