#!/bin/bash

for num in 5 25 100 250 500
do
cat <<EOF >packmol_dao_TRE$num.in
# All atoms from diferent molecules will be at least 2.0 Angstroms apart
tolerance 2.0

# The type of the files will be pdb
filetype pdb
add_amber_ter

# The name of the output file
output dao_noNAG_TRE$num.pdb

# put the COM of the solute at the center of the box
# obtained from Chimera on dao_noNAG.pdb using Select + Tools/StructureAnalysis/Planes-Axes-Centroids 
# I leave the rotation to 0 by now, as the DAO structure in the 1KSI pdb file is relatively well oriented with respect to the final MD box
structure dao_noNAG.pdb
  number 1
  fixed 22.86382851 51.27007338 2.5412616 0. 0. 0.
  center
end structure

# in order to know the size of the box where to put the trehalose molecules, we use the info from 
# tleap -f tleap_dao_noNAG.in > tleap_dao_noNAG.log
# which provides the bounding box of the trehalose free MD run, that we wish to maintain:
#   Total bounding box for atom centers:  104.841 102.718 137.764
# so, we take as the lower and upper coordinates of the box:
# Xmin=22.864-104.841/2=-29.557
# Xmax=22.864+104.841/2=75.285
# Ymin=51.270-102.718/2=-0.089
# Ymax=51.270+102.718/2=102.629
# Zmin=2.541-137.764/2=-66.341
# Zmax=2.541+137.764/2=71.423
# add now add trehalose molecules
structure trehalose_final.pdb
  number $num
  inside box -29.557 -0.089 -66.341 75.285 102.629 71.423
end structure
EOF

packmol <packmol_dao_TRE$num.in
done
