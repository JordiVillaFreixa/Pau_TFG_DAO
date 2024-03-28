pdb4amber -i pdb1ksi.pdb -o dao.pdb --dry --reduce

#Descarreguem els dos fitxers dels residues NAG i TPQ
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

nag.mc

## Hem de mirar primer de tot si el NAG el necessitem per la simulació, ja que podem veure al dao.pdb desde chimera que no està unit a la molècula

prepgen -i tpq2.ac -o tpq.prepin -m tpq.mc -rn TPQ
prepgen -i nag.ac -o nag.prepin -m nag.mc -rn NAG