#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage:
    bash generate_PDB.sh <calculation> <{min,heat,md}>"
    exit
fi

ambpdb -p ../inputs/$1.parm7 -c $SCRATCHDIR/$2$1.rst7 > ../results/$2$1.pdb
echo "The file  ../results/$2$1.pdb has been generated"
