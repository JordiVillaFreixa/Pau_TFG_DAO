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

#Ara ho farem amb el lligand NAG:

antechamber -fi ccif -i NAG.cif -bk NAG -fo ac -o nag.ac -c bcc -at amber

antechamber -fi ccif -i NAG.cif -fo prepi -o nag2.ac -c bcc -at amber -nc 0 -rn NAG -bk NAG
#Provem a partir de la nayanika aquest antechamber
#provem de crear nag3.ac
antechamber -fi ccif -i NAG.cif -fo ac -o nag3.ac -c bcc -at amber -nc 0 -rn NAG -bk NAG
#En aquest cas no ens farà falta corregir cap error de atom type.

#Ara, per preparar la llibreria del residu TPQ i els seus paràmetres per utilitzar amb leap, necessitem fer un main chain file que identifica els àtoms a ser eliminats i quins són els que pertanyen a la cadena principal.

tpq.mc:
HEAD_NAME N
TAIL_NAME C
MAIN_CHAIN CA
OMIT_NAME H2
OMIT_NAME OXT
OMIT_NAME HXT
PRE_HEAD_TYPE C
POST_TAIL_TYPE N
CHARGE 0.0
#Aquest serà el nostre mc file per TPQ.*********EXPLICAR QUE SIGNIFICA CADA COSA*********. Amb el fitxer a punt, hem de fer un prepgen.

prepgen -i tpq2.ac -o tpq.prepin -m tpq.mc -rn TPQ
#Ara ja tenim el document prepin que conté la definició del residu TPQ. Però, necessitem comprovar els paràmetres covalents

parmchk2 -i tpq.prepin -f prepi -o frcmod.tpq -s gaff2

#Ara ja tenim parametritzat el nostre residu modificat TPQ, però ens falta el nostre lligan NAG.
#https://docs.bioexcel.eu/2020_06_09_online_ambertools4cp2k/04-parameters/index.html

prepgen -i nag.ac -o nag.prepin -f int -rn NAG
prepgen -i nag2.ac -o nag2.prepin -f int -rn NAG

#últim prepgen nag3.ac
prepgen -i nag3.ac -o nag4.prepin -f int -rn NAG
# Per la nostra parametrització del lligan, NO FARÀ FALTA CREAR UN MC FILE perque no és un residu, així que directament usarem parmchk2

parmchk2 -i nag.prepin -f prepi -o frcmod.nag -s gaff2
parmchk2 -i nag.prepin -f prepi -o frcmod.nag -s gaff
parmchk2 -i nag.prepin -f prepi -o frcmod.nag -s parm10
parmchk2 -i nag2.prepin -f prepi -o frcmod.nag2 -s gaff2
#provem amb el nag3.prepim
parmchk2 -i nag3.prepin -f prepi -o frcmod.nag4

#parmchk de la nayanika
parmchk2 -f prepi -i nag2.prepi -o frcmod.nag3

#provem amb el nag3.ac i passem a frcmod.nag5
parmchk2 -f prepi -i nag4.prepin -o frcmod.nag5

#Amb tots aquests fitxers, hem de fer un tleap, afegint els nous paràmetres i així creem els fitxers de coordenades per començar amb les simulacions.
#Per les simulacions que volem fer, necessitem afegir ions, trehalosa en diferents concentracions i aigua.

#Al fitxer tleap, afegirem el force field de proteines ff19SB, el water opc, carregarem el fitxer dao

Amb el tleap fet, ens dona fatal error per tema de atom types, comprovem si canviant les paraules HETATM per ATOM, funciona el tleap. 
Farem:
sed 's/HETATM/ATOM  /' dao.pdb >dao2.pdb
No sembla que allò fos l'error, potser hem d'eliminar on possa connect al fitxer.
Probem d'eliminar els connect i canviar hetatm per atom

#Quedad jordi, borramos hidrogenos sobrantes despues de añadirlos en openbabel, borramos h22, h2 y h4
#Ojo la quiralidad

1198
554