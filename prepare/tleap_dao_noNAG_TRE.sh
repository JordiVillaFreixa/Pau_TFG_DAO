#!/bin/bash

for num in 5 25 100 250 500
do
cat <<EOF > tleap_dao_noNAG_TRE$num.in
source leaprc.protein.ff19SB
source leaprc.water.opc
loadAmberPrep ../pdb/TPQ.prepin
loadAmberParams ../pdb/TPQ.frcmod
LIG = loadmol2 ../pdb/TRE.mol2
loadAmberParams ../pdb/TRE.frcmod
DAO=loadpdb ../pdb/dao_noNAG_TRE$num.pdb
bond DAO.132.SG DAO.153.SG
bond DAO.314.SG DAO.340.SG
bond DAO.774.SG DAO.795.SG
bond DAO.956.SG DAO.982.SG
addions2 DAO NA 0
solvatebox DAO OPCBOX 1.0
savepdb DAO ../pdb/dao_noNAG_TRE${num}_wat.pdb
check DAO
saveAmberParm DAO ../inputs/dao_noNAG_TRE$num.parm7 ../inputs/dao_noNAG_TRE$num.rst7
quit
EOF
echo "Processing tleap_dao_noNAG_TRE$num.in"
tleap -f tleap_dao_noNAG_TRE$num.in > tleap_dao_noNAG_TRE$num.log
done


