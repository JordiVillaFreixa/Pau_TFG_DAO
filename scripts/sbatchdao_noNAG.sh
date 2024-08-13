#!/bin/bash -x
#SBATCH -J dao_noNAG
#SBATCH -e /Users/jordivilla/scratch/md/%J.%j.err
#SBATCH -o /Users/jordivilla/scratch/md/%J.%j.out
#SBATCH -n 1
#SBATCH -t 0-10:00

# PRODUCTION
echo "Running PRODUCTION for dao_noNAG"
cp /Users/jordivilla/Github/Treball/Pau_TFG_DAO/inputs/md.in /Users/jordivilla/scratch/md
cd /Users/jordivilla/scratch/md

pmemd -O -i md.in -p dao_noNAG.parm7 -c heatdao_noNAG.rst7 -o mddao_noNAG.mdout        -x mddao_noNAG.nc -r mddao_noNAG.rst7
cp ./mddao_noNAG.mdout /Users/jordivilla/Github/Treball/Pau_TFG_DAO/results
