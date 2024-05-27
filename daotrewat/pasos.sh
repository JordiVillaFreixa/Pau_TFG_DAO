wget -nc https://files.rcsb.org/download/1KSI.pdb
wget -nc https://files.rcsb.org/ligands/download/TPQ.cif

#pdb4amber
pdb4amber -i 1KSI.pdb -o dao.pdb --dry --reduce
grep -v NAG dao.pdb > daononag.pdb

antechamber -fi ccif -i TPQ.cif -bk TPQ -fo ac -o tpq.ac -c bcc -at amber
sed 's/NT/ N/' tpq.ac >tpq2.ac


un cop fet el tleap, hem d'afegir les trehaloses, que segons el càlculs ens surten 485 molècules de trehaloses a afegir

descarreguem trehalosa desde drugbank en 3D mol format i passem a pdb en 3d coordinates en openbabel per després fer:
antechamber -i trehalose.pdb -fi pdb -fo ac -o trehalose.ac -c bcc -at amber

farem la preparació d'això per parametritzar la trehalosa i 


 $AMBERHOME/bin/AddToBox -c daowat.pdb -a trehalose.pdb -na 485 -o daotrewat.pdb -RP 1 -RW 1
 