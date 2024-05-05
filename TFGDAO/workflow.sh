#Per començar, el que hem de fer és buscar els PDB files que necessitarem per preparar els scripts i còrrer les simulacions més endavant. En el nostre treball necessitarem dels PDB de DAO de pisum sativum, trehalosa, el cofactor TPQ i el lligand NAG.

wget -nc https://files.rcsb.org/download/1KSI.pdb
wget -nc https://files.rcsb.org/ligands/download/NAG.cif
wget -nc https://files.rcsb.org/ligands/download/TPQ.cif

#En relació a la trehalosa, serà més difícil ja que no es troba en format pdb o cif. Per otenir la seva estructura en 3D primer descarreguem desde drugbank la estructura en 3D-SDF, i a openbabel convertim el fitxer de .sdf a .pdb per poder treballar amb ell. El tenim anomenat com trehalose.pdb

#Després d'obtenir el fitxer de la trehalosa observem que els residue names són UNL, per fer-ho més estètic i entenedor, amb el comando sed, ho canviem per TRE en un nou fitxer de manera que així no perdem l'original per si hem de tornar a treballar amb ell.

 sed 's/UNL/TRE/' trehalose.pdb > tre.pdb

#Un cop tenim tots els fitxers descarregats, ja podem començar a treballar amb ells. El primer de tot que hem de fer és fer un pdb4amber del nostre enzim, d'aquesta manera el fitxer serà modificat per poder ser utilitzat amb tleap que veurem més endavant.

pdb4amber -i 1KSI.pdb -o dao.pdb --dry --reduce

#Utilitzem dry i reduce per treure les aigües cristalografiques i afegir àtoms d'hidrogen a les localitzacions més òpptimes

#Ara anem amb el residu modificat TPQ, ja que no és un residu estàndard hem de crear la nostra pròpia llibreria. Per fer aquesta nova llibreria que contingui els atom types i les càrregues, farem ús d'antechamber. La comanda serà la següent:

antechamber -fi ccif -i TPQ.cif -bk TPQ -fo ac -o tpq.ac -c bcc -at amber

#Si observem el document generat i anomenat tpq.ac, veiem que hi ha un atom type NT, que no el reconeix amber, i per tant hem d'utilitzar altre cop el comando sed per canviar-ho manualment.

sed 's/NT/ N/' tpq.ac >tpq2.ac

