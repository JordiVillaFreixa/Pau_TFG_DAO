## Tutorial GFP 5.2 (https://ambermd.org/tutorials/basic/tutorial5/index.php)
# Primer pas: descàrrega fitxer PDB
wget -nc https://ambermd.org/tutorials/basic/tutorial5/files/1EMA.pdb #(-nc no permet descarregar si el fitxer ja hi és)

#Secció 1
# Segon pas: generar fitxer sense aigues i amb hidrogens
pdb4amber -i 1EMA.pdb -o gfp.pdb --dry --reduce

# Canviar els SE per S i els MSE per MET (anar amb compte amb els espais[s'han de revisar els documents PDB])
sed 's/SE   MSE/ S   MSE/' gfp.pdb|sed s/MSE/MET/ >gfp2.pdb

#Secció 2
# Sabem que CRO no és un residu estandar, per tant les llibreris de residus d'Amber no tenen atom types ni càrrega per aquest residu. En aquest apartat veiem com es fa. Cal mencionar que utilitzarem antechamber per derivar càrregues seguint l'esquema bcc (****buscar que és*****).
