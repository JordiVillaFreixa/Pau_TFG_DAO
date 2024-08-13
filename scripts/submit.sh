#!/bin/bash
cat <<EOT >sbatch$1.sh
#!/bin/bash -x
#SBATCH -J $1
#SBATCH -e $SCRATCHDIR/%J.%j.err
#SBATCH -o $SCRATCHDIR/%J.%j.out
#SBATCH -n 1
#SBATCH -t 0-10:00

# MINIMIZATION
echo "Running MINIMIZATION for $1"
cp $INPUTDIR/{min.in,$1.parm7,$1.rst7} $SCRATCHDIR
cd $SCRATCHDIR

pmemd -O -i min.in -p $1.parm7 -c $1.rst7 -o min$1.mdout \
       -x min$1.nc -r min$1.rst7

# HEATING
echo "Running HEATING for $1"
cp $INPUTDIR/heat.in $SCRATCHDIR
cd $SCRATCHDIR

pmemd -O -i heat.in -p $1.parm7 -c min$1.rst7 -o heat$1.mdout \
       -x heat$1.nc -r heat$1.rst7

# PRODUCTION
echo "Running PRODUCTION for $1"
cp $INPUTDIR/md.in $SCRATCHDIR
cd $SCRATCHDIR

pmemd -O -i md.in -p $1.parm7 -c heat$1.rst7 -o md$1.mdout \
       -x md$1.nc -r md$1.rst7
EOT
sbatch sbatch$1.sh