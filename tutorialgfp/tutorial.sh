## Tutorial GFP 5.2 (https://ambermd.org/tutorials/basic/tutorial5/index.php)
# Primer pas: descàrrega fitxer PDB
wget -nc https://ambermd.org/tutorials/basic/tutorial5/files/1EMA.pdb #(-nc no permet descarregar si el fitxer ja hi és)

# Segon pas: generar fitxer sense aigues i amb hidrogens
pdb4amber -i 1EMA.pdb -o gfp.pdb --dry --reduce

# Canviar els SE per S i els MSE per MET
sed 's/SE   MSE/ S   MSE/' gfp.pdb|sed s/MSE/MET/ >gfp2.pdb


