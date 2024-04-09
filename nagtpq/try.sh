pdb4amber -i pdb1ksi.pdb -o dao.pdb --dry --reduce

#Descarreguem els dos fitxers dels residues NAG i TPQ desde 
antechamber -fi ccif -i TPQ.cif -bk TPQ -fo ac -o tpq.ac -c bcc -at amber
antechamber -fi ccif -i NAG.cif -bk NAG -fo ac -o nag.ac -c bcc -at amber

#Mirem els fitxers tpq.ac i nag.ac i busquem àtoms que no es reconeguin a amber per canviar-los
sed 's/NT/ N/' tpq.ac >tpq2.ac

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

nag.mc:
HEAD_NAME
TAIL_NAME
MAIN_CHAIN
OMIT_NAME
PRE_HEAD_TYPE
POST_TAIL_TYPE
CHARGE 0.0

## Hem de mirar primer de tot si el NAG el necessitem per la simulació, ja que podem veure al dao.pdb desde chimera que no està unit a la molècula

prepgen -i tpq2.ac -o tpq.prepin -m tpq.mc -rn TPQ
prepgen -i nag.ac -o nag.prepin -m nag.mc -rn NAG


#Per a la trehalosa, hem de descarregar desde drugbank format mol, després anem a openlabel i transforme'm l'arxiu mol a pdb amb estructura 3D. Un cop fet això i amb l'arxiu allà on el volem, treballem amb ell
antechamber -i dbtre.pdb -fi pdb -fo ac -o treant.ac -c bcc -at amber

#Creem un fitxer mc per a la trehalosa:
tre.mc:

HEAD_NAME C6
TAIL_NAME C10
MAIN_CHAIN C
MAIN_CHAIN C2
PRE_HEAD_TYPE C
POST_TAIL_TYPE C
CHARGE 0.0

#Fem prepgen de la trehalosa:
prepgen -i treant.ac -o tre.prepin -m tre.mc -rn TRE
parmchk2 -i tre.prepin -f prepi -o frcmod.tre -a Y -p $AMBERHOME/dat/leap/parm/parm10.dat
