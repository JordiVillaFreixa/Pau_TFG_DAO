#!/bin/bash
#SBATCH -J tre5
#SBATCH -e /home/jvilla/scratch/%J.%j.err
#SBATCH -o /home/jvilla/scratch/%J.%j.out
#SBATCH -n 1
#SBATCH -t 0-10:00

# MINIMIZATION
cp /home/jvilla/Github/Pau_TFG_DAO/inputs/{min.in,tre5.parm7,tre5.rst7} /home/jvilla/scratch
cd /home/jvilla/scratch

pmemd -O -i min.in -p tre5.parm7 -c tre5.rst7 -o mintre5.mdout        -x mintre5.nc -r mintre5.rst7
cp ./mintre5.mdout /home/jvilla/Github/Pau_TFG_DAO/results

# HEATING
cp /home/jvilla/Github/Pau_TFG_DAO/inputs/heat.in /home/jvilla/scratch
cd /home/jvilla/scratch

pmemd -O -i heat.in -p tre5.parm7 -c mintre5.rst7 -o heattre5.mdout        -x heattre5.nc -r heattre5.rst7
cp ./heattre5.mdout /home/jvilla/Github/Pau_TFG_DAO/results

# PRODUCTION
cp /home/jvilla/Github/Pau_TFG_DAO/inputs/md.in /home/jvilla/scratch
cd /home/jvilla/scratch

pmemd -O -i md.in -p tre5.parm7 -c heattre5.rst7 -o mdtre5.mdout        -x mdtre5.nc -r mdtre5.rst7
cp ./mdtre5.mdout /home/jvilla/Github/Pau_TFG_DAO/results
