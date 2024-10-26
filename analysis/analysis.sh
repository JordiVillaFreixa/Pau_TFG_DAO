#!/bin/bash -x
#SBATCH -J 
#SBATCH -e /home/jvilla/scratch/%J.%j.err
#SBATCH -o /home/jvilla/scratch/%J.%j.out
#SBATCH -n 1
#SBATCH -t 0-10:00

cd ../analysis
conda activate MD
python RMS.py 

