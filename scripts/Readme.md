# Scripts to run MD simulations on DAO

## Overview

This folder includes all the scripts for the simulation of trehalose free and trehalose containing water+DAO boxes. 


* `set_scratchdir.sh.example`: when you work in different computers, you need to control the name of the scratch directory where results of MD calculations are stored

## Running AMBER

### Running AMBER in local

Check the `min*,sh`, `heat*.in` and `md*.sh` files, which run something similar to:

```
cp -r ${INPUTDIR}/{*.in,*.parm7,*.rst7} ${SCRATCHDIR}
cd ${SCRATCHDIR}

sander -O -i md.in -p gfp.parm7 -c heat.rst7 -o md1.mdout \
       -x md1.nc -r md1.rst7
cp ./*.mdout ${RESULTSDIR}
```

### Running AMBER in the SLURM queing system

The template is in `submit_slurm.sh`, which contains these instructions:

```
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
```

## Specific calculations

* `min<name>.sh` minimization script for calculation `name`
* `heat<name>.sh` heating script for calculation `name`
* `md<name>.sh` molecular dynamics script for calculation `name`
