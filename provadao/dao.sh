

# Primer fem pdb4amber per preparar el fitxer per tleap amb dry i reduce

pdb4amber -i pdb1ksi.pdb -o dao.pdb --dry --reduce

#Canviem els residus necessaris per a que reconeixi l'amber


#Fem antechamber del nostre residu TPQ

antechamber -fi ccif -i TPQ.cif -bk TPQ -fo ac -o tpq.ac -c bcc -at amber

#Hem de crear el nostre document tleap, HEAD_NAME i TAIL_NAME  identifiquen els atoms que es connectaran als anteriors i seguents amino acids respectivament. MAIN_CHAIN és la llista d'àtoms al llarg de la cadena que connecten els àtoms de head i tail. OMIT_NAME és la llista d'àtoms a TPQ que han de ser extrets de la estructura final. PRE_HEAD_TYPE permet a prepgen quins atom types a la proteina seran utilitzats per la connexió covalent