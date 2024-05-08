#Fem el fitxer nou amb l'ajuda del Jordi
#afegim hidrogens, amb openbabel es pot
#li fem un pdb4amber (hem optat per aquesta)
#li fem antechamber
alguns àtoms són du

#fem parmchk2

#editar el pdb

pdb4amber -i asnnag.pdb -o nag.pdb
antechamber -fi pdb -i nag.pdb -fo prepi -o nag.prepin -c bcc -at amber -nc 0 -rn AAG -bk AAG
parmchk2 -i nag.prepin -f prepi -o frcmod.nag

antechamber -j 5 -at sybyl -dr no -i aagt.pdb -o aagt.mol2 -fi pdb -fo mol2
antechamber -j 5 -at sybyl -dr no -i aagt1.pdb -o aagt1.mol2 -fi pdb -fo mol2