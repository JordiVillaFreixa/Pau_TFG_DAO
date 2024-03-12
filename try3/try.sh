pdb4amber -i pdb1ksi.pdb -o dao.pdb --dry --reduce

#Descarreguem els dos fitxers dels residues NAG i TPQ
antechamber -fi ccif -i TPQ.cif -bk TPQ -fo ac -o tpq.ac -c bcc -at amber
antechamber -fi ccif -i NAG.cif -bk NAG -fo ac -o nag.ac -c bcc -at amber

#Mirem els fitxers tpq.ac i nag.ac i busquem àtoms que no es reconeguin a amber per canviar-los
sed 's/NT/N /' tpq.ac >tpq2.ac
