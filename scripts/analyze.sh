#!/bin/bash
curdir=`pwd`
cat <<EOT >../analysis/analysis$1.sh
#!/bin/bash -x
#SBATCH -J $1
#SBATCH -e $SCRATCHDIR/$1.err
#SBATCH -o $SCRATCHDIR/$1.out
#SBATCH -n 1
#SBATCH -t 0-10:00

pwd
. "/home/jvilla/miniconda3/etc/profile.d/conda.sh"
conda init
conda activate mdanalysis
python RMS.py $1

EOT
cd $curdir/../analysis
pwd
echo "To submit in local, use:
sbatch analysis$1.sh
otherwise, wait for slurm to do the magic"
sbatch analysis$1.sh
