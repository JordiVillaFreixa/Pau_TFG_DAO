# Això és un mini tutorial de com podem activar i desactivar nuclis de CPU a l'hora de treballar amb Ubuntu.
#Primer de tot instal·lem lscpu

sudo apt-get install util-linux

#Fem run de lscpu

lscpu

# Per poder deshabilitar nuclis, hem de tenir en compte que cadascun té la seva pròpia carpeta, per això podem fer un run del següent comando per veure una llista de les carptetes dels nuclis:

ls /sys/devices/system/cpu
#El cpu0 és el main core, i no es pot deshabilitar (seria inservible l'ordinador)

# A l'hora de deshablitar, s'ha de fer run de la següent comanda, on n representa el número del nucli de la cpu que volem deshabilitar. Per tant, per deshabilitar la CPU16:
#Primer naveguem al seu directori:

cd /sys/devices/system/cpu/cpu15

#Mirem que hi ha al seu directori:

cat online

# Si retorna 1, vol dir que està operatiu, per deshabilitar-ho editem online:

echo 0 | sudo tee online
cat online

#Per activar-ho:

echo 1 | sudo tee online
cat online