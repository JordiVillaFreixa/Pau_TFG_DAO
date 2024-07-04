#!/bin/bash
#SBATCH -J mdgfp
#SBATCH -e %J.%j.err
#SBATCH -o %J.%j.out
#SBATCH -p gpu
#SBATCH -n 1
#SBATCH -t 0-10:00

module load apps/amber/22

##
#  Modify the input and output files!

cp -r ${SLURM_SUBMIT_DIR}/{*.in,*.parm7,*.rst7} ${SCRATCHDIR}
cd ${SCRATCHDIR}

sander -O -i md.in -p gfp.parm7 -c heat.rst7 -o md1.mdout \
       -x md1.nc -r md1.rst7
cp ./*.mdout ${SLURM_SUBMIT_DIR}