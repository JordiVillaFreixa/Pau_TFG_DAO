#!/bin/bash -x
#SBATCH -J dao_noNAG_TRE500
#SBATCH -e /home/jvilla/scratch/%J.%j.err
#SBATCH -o /home/jvilla/scratch/%J.%j.out
#SBATCH -n 1
#SBATCH -t 0-10:00

pwd
conda activate MD
python RMS.py dao_noNAG_TRE500

