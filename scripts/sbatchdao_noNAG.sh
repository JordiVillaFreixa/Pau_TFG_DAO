#!/bin/bash
#SBATCH -J dao_noNAG
#SBATCH -e /home/jvilla/scratch/%J.%j.err
#SBATCH -o /home/jvilla/scratch/%J.%j.out
#SBATCH -n 1
#SBATCH -t 0-10:00

# MINIMIZATION
cp /home/jvilla/Github/Pau_TFG_DAO/inputs/{min.in,dao_noNAG.parm7,dao_noNAG.rst7} /home/jvilla/scratch
cd /home/jvilla/scratch

pmemd -O -i min.in -p dao_noNAG.parm7 -c dao_noNAG.rst7 -o mindao_noNAG.mdout        -x mindao_noNAG.nc -r mindao_noNAG.rst7
cp ./mindao_noNAG.mdout /home/jvilla/Github/Pau_TFG_DAO/results

# HEATING
cp /home/jvilla/Github/Pau_TFG_DAO/inputs/heat.in /home/jvilla/scratch
cd /home/jvilla/scratch

pmemd -O -i heat.in -p dao_noNAG.parm7 -c mindao_noNAG.rst7 -o heatdao_noNAG.mdout        -x heatdao_noNAG.nc -r heatdao_noNAG.rst7
cp ./heatdao_noNAG.mdout /home/jvilla/Github/Pau_TFG_DAO/results

# PRODUCTION
cp /home/jvilla/Github/Pau_TFG_DAO/inputs/md.in /home/jvilla/scratch
cd /home/jvilla/scratch

pmemd -O -i md.in -p dao_noNAG.parm7 -c heatdao_noNAG.rst7 -o mddao_noNAG.mdout        -x mddao_noNAG.nc -r mddao_noNAG.rst7
cp ./mddao_noNAG.mdout /home/jvilla/Github/Pau_TFG_DAO/results
