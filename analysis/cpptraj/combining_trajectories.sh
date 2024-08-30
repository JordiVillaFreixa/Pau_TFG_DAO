#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo "ERROR: No arguments supplied. You need to supply the name of the calculation (eg, dao_noNAG)"
    exit
fi

cat <<EOF > combine$1.cpptrajin
noexitonerror
parm ../../inputs/$1.parm7
trajin $BACKUPFOLDER/*/md${1}_?.nc  # 1 last 10
trajin $BACKUPFOLDER/*/md${1}_??.nc # 1 last 10
autoimage # center trajectories
strip :WAT
trajout $SCRATCHDIR/${1}_nowater.dcd dcd
go
EOF
cpptraj < combine$1.cpptrajin

cat <<EOF > newparm$1.cpptrajin
parm ../../inputs/$1.parm7
parmstrip :WAT
parmwrite out $SCRATCHDIR/${1}_nowater.prmtop
go
EOF
cpptraj < newparm$1.cpptrajin

echo "If all went well, try:"
echo "   vmd -parm7 $SCRATCHDIR/${1}_nowater.prmtop $SCRATCHDIR/${1}_nowater.dcd"
echo "to visualize the trajectory in vmd"