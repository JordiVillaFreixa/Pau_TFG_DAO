#!/bin/bash -x
#SBATCH -J dao_noNAG_TRE100
#SBATCH -e /home/jvilla/scratch/dao_noNAG_TRE100.err
#SBATCH -o /home/jvilla/scratch/dao_noNAG_TRE100.out
#SBATCH -n 1
#SBATCH -t 0-10:00

pwd
. "/home/jvilla/miniconda3/etc/profile.d/conda.sh"
conda init
conda activate mdanalysis
python RMS.py dao_noNAG_TRE100
