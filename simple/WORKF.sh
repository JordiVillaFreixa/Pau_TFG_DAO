#Primer de tot descarreguem els fitxers de la molecula amb codi pdb 8hhe i el fitxer mol desde drugbank de la trehalosa, que passarem a pdb amb openbabel. Un cop els tenim descarregats fem el seguen:

pdb4amber -i 8hhe.pdb -o hh.pdb --dry --reduce
antechamber -fi pdb -i tre.pdb -fo ac -o tre.ac -c bcc -at amber
$AMBERHOME/bin/AddToBox -c hh.pdb -a tre.ac -na 2445 -o hhtre.pdb -RP 2.0 -RW 3.0
prepgen -i tre.ac -o tre.prepin -m tre.mc -rn UNL
parmchk2 -i tre.prepin -f prepi -o frcmod.tre -a Y -p $AMBERHOME/dat/leap/parm/parm10.dat
tleap -f tleap.in