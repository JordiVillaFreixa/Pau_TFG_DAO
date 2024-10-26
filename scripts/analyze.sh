#!/bin/bash
curdir=`pwd`
cat <<EOT >../analysis/analysis$1.sh
#!/bin/bash -x
#SBATCH -J $1
#SBATCH -e $SCRATCHDIR/%J.%j.err
#SBATCH -o $SCRATCHDIR/%J.%j.out
#SBATCH -n 1
#SBATCH -t 0-10:00

pwd
conda activate MD
python RMS.py $1

EOT
cd $curdir/../analysis
pwd
echo "To submit in local, use:
sbatch analysis$1.sh
otherwise, wait for slurm to do the magic"
sbatch analysis$1.sh
