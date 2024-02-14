import pandas as pd
import re

# Ruta al archivo .txt
ruta_archivo = '/home/bel/arxiusgrans/min1.out'
nstep='NSTEP'
with open(ruta_archivo) as file:
    lines= [lines for line in file.read().split('\n') if nstep in line]
with open ('output.txt', 'w+')
