## Tutorial GFP 5.2 (https://ambermd.org/tutorials/basic/tutorial5/index.php)
# Primer pas: descàrrega fitxer PDB
wget -nc https://ambermd.org/tutorials/basic/tutorial5/files/1EMA.pdb #(-nc no permet descarregar si el fitxer ja hi és)

#Secció 1
# Segon pas: generar fitxer sense aigues i amb hidrogens
pdb4amber -i 1EMA.pdb -o gfp.pdb --dry --reduce

# Canviar els SE per S i els MSE per MET (anar amb compte amb els espais[s'han de revisar els documents PDB])
sed 's/SE   MSE/ S   MSE/' gfp.pdb|sed s/MSE/MET/ >gfp2.pdb

#Secció 2
# Sabem que CRO no és un residu estandar, per tant les llibreris de residus d'Amber no tenen atom types ni càrrega per aquest residu. En aquest apartat veiem com es fa. Cal mencionar que utilitzarem antechamber per derivar càrregues seguint l'esquema bcc (****buscar que és*****). El primer que hem de fer és descaregar desde PDB el document de CRO en format .cif (el podem descarregar desde el tutorial).

wget -nc https://ambermd.org/tutorials/basic/tutorial5/files/CRO.cif

# Un cop tenim el document, utilitzarem antechamber que pot llegir-ho i generar càrregues i atom types

antechamber -fi ccif -i CRO.cif -bk CRO -fo ac -o cro.ac -c bcc -at amber

# Segons ens demana, entre altres fitxers trobem cro.ac,  