## Tutorial GFP 5.2 (https://ambermd.org/tutorials/basic/tutorial5/index.php)
# Primer pas: descàrrega fitxer PDB
wget -nc https://ambermd.org/tutorials/basic/tutorial5/files/1EMA.pdb #(-nc no permet descarregar si el fitxer ja hi és)

#Secció 1
# Segon pas: generar fitxer sense aigues i amb hidrogens
pdb4amber -i 1EMA.pdb -o gfp.pdb --dry --reduce

# Canviar els SE per S i els MSE per MET (anar amb compte amb els espais[s'han de revisar els documents PDB]) S'ha de tenir en compte amb els espais que es deixen a
sed 's/SE   MSE/ SD  MSE/' gfp.pdb|sed s/MSE/MET/ >gfp2.pdb

#Secció 2
# Sabem que CRO no és un residu estandar, per tant les llibreris de residus d'Amber no tenen atom types ni càrrega per aquest residu. En aquest apartat veiem com es fa. Cal mencionar que utilitzarem antechamber per derivar càrregues seguint l'esquema bcc (****buscar que és*****). El primer que hem de fer és descaregar desde PDB el document de CRO en format .cif (el podem descarregar desde el tutorial).

wget -nc https://ambermd.org/tutorials/basic/tutorial5/files/CRO.cif #****això s'de canviar perque el document és diferent**** el document cro.cif de 2023 és diferent i al punt de parmchk no funciona la comanda

# Un cop tenim el document, utilitzarem antechamber que pot llegir-ho i generar càrregues i atom types

antechamber -fi ccif -i CRO.cif -bk CRO -fo ac -o cro.ac -c bcc -at amber #el resultant cro.ac té diferents números

# Segons ens demana, entre altres fitxers trobem cro.ac, el que pot semblar-se a un PDB file,però que conté una llista d'enllaços així com a càrregues atòmiques parcials i atom types. Donat que antechamber ocasionalment dona errors amb els Amber atom types, en aquest cas hem de corregir els NT atom per N a mà. Utilitzarem sed, tenint en compte els espais i les lletres que ocupen cada posició al document.

sed 's/NT/N /' cro.ac >cro2.ac #el meu cro2ac és diferent al resultant de l'exemple, directament 

#Secció 3
# Creem el fitxer cro.mc

prepgen -i cro2.ac -o cro.prepin -m cro.mc -rn CRO # no està bé

parmchk2 -i cro.prepin -f prepi -o frcmod.cro -a Y \ -p $AMBERHOME/dat/leap/parm/parm10.dat #anar amb compte dels espais ~~~~REPASSAR DOCUMENT FRCMOD

grep -v "ATTN" frcmod.cro > frcmod1.cro # Strip out ATTN lines

parmchk2 -i cro.prepin -f prepi -o frcmod2.cro ##hay algo mal aquí

#Secció 4
tleap -f tleap.in #Problema en MSE 75, se suposa que haviem de canviar MSE . Arregladpo lo de los atomos SE y S por SD ()


#Secció 5
#Creem el document min.in per minimization
#Fem run de minimization amb la següent comanda:
sander -O -i min.in -p gfp.parm7 -c gfp.rst7 -o min1.out -r min1.rst7

#Per heating creem un altre fitxer anomenat heat.in i fem run amb:
sander -O -i heat.in -p gfp.parm7 -c min1.rst7 -o heat.mdout \ -x heat.nc -r heat.rst7

#Per finalitzar amb production creem el fitxer md.in i fem run:

sander -O -i md.in -p gfp.parm7 -c heat.rst7 -o md1.mdout \
       -x md1.nc -r md1.rst7
