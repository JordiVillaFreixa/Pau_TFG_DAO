#Per començar, el que hem de fer és buscar els PDB files que necessitarem per preparar els scripts i còrrer les simulacions més endavant. En el nostre treball necessitarem dels PDB de DAO de pisum sativum, trehalosa, el cofactor TPQ i el lligand NAG.

wget -nc https://files.rcsb.org/download/1KSI.pdb
wget -nc https://files.rcsb.org/ligands/download/NAG.cif
wget -nc https://files.rcsb.org/ligands/download/TPQ.cif

#En relació a la trehalosa, serà més difícil ja que no es troba en format pdb o cif. Per otenir la seva estructura en 3D primer descarreguem desde drugbank la estructura en 3D-SDF, i a openbabel convertim el fitxer de .sdf a .pdb per poder treballar amb ell. El tenim anomenat com trehalose.pdb

#Un cop tenim tots