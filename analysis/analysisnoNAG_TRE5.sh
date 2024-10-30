#!/bin/bash -x
#SBATCH -J noNAG_TRE5
#SBATCH -e /home/jvilla/scratch/%J.%j.err
#SBATCH -o /home/jvilla/scratch/%J.%j.out
#SBATCH -n 1
#SBATCH -t 0-10:00

pwd
. "/home/jvilla/miniconda3/etc/profile.d/conda.sh"
conda init
conda activate mdanalysis
python RMS.py noNAG_TRE5

