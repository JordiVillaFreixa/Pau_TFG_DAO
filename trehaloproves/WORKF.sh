#Primer de tot descarreguem els fitxers de la molecula amb codi pdb 8hhe i el fitxer mol desde drugbank de la trehalosa, que passarem a pdb amb openbabel. Un cop els tenim descarregats fem el seguen:

pdb4amber -i 8hhe.pdb -o hh.pdb --dry --reduce

#Fem antechamber
antechamber -fi pdb -i tre.pdb -fo ac -o tre.ac -c bcc -at amber

#Afegim la trehalosa al sistema
$AMBERHOME/bin/AddToBox -c hh.pdb -a tre.ac -na 2445 -o hhtre.pdb -RP 2.0 -RW 3.0

#Fem un prepgen, tenint en compta que és isolated, el mc file només posem càrrega 0.0
prepgen -i tre.ac -o tre.prepin -m tre.mc -rn UNL

#parmchk2
parmchk2 -i tre.prepin -f prepi -o frcmod.tre -a Y -p $AMBERHOME/dat/leap/parm/parm10.dat
tleap -f tleap.in

#Simulació per una sola trehalosa en aigua
pmemd -O -i min.in -p tre1.parm7 -c tre1.rst7 -o tremin1.out -r min1tre.rst7

pmemd -O -i heat.in -p tre1.parm7 -c min1tre.rst7 -o tre1heat.mdout -x tre1heat.nc -r tre1heat.rst7

pmemd -O -i md.in -p tre1.parm7 -c tre1heat.rst7 -o tre1md.mdout -x tre1md.nc -r tre1md.rst7

#Simulació per dos trehaloses en aigua (fer un nou tleap desrpés d'haver afegit una trehalosa més al sistema)

pmemd -O -i min.in -p tre2.parm7 -c tre2.rst7 -o tremin2.out -r min2tre.rst7

pmemd -O -i heat.in -p tre2.parm7 -c min2tre.rst7 -o tre2heat.mdout -x tre2heat.nc -r tre2heat.rst7

pmemd -O -i md.in -p tre2.parm7 -c tre2heat.rst7 -o tre2md.mdout -x tre2md.nc -r tre2md.rst7

#Simulació per 5 trehaloses en aigua (fer un nou tleap després d'haver afegit 4 trehaloses més al sistema)

pmemd -O -i min.in -p tre5.parm7 -c tre5.rst7 -o tremin5.out -r min5tre.rst7

pmemd -O -i heat.in -p tre5.parm7 -c min5tre.rst7 -o tre5heat.mdout -x tre5heat.nc -r tre5heat.rst7

pmemd -O -i md.in -p tre5.parm7 -c tre5heat.rst7 -o tre5md.mdout -x tre5md.nc -r tre5md.rst7

#Simulació per 10 trehaloses en aigua (fer un nou tleap després d'haver afegit 9 trehaloses més al sistema)

pmemd -O -i min.in -p tre10.parm7 -c tre10.rst7 -o tremin10.out -r min10tre.rst7

pmemd -O -i heat.in -p tre10.parm7 -c min10tre.rst7 -o tre10heat.mdout -x tre10heat.nc -r tre10heat.rst7

pmemd -O -i md.in -p tre10.parm7 -c tre10heat.rst7 -o tre10md.mdout -x tre10md.nc -r tre10md.rst7

#Simulació per 25 trehaloses

pmemd -O -i min.in -p tre25.parm7 -c tre25.rst7 -o tremin25.out -r min25tre.rst7

pmemd -O -i heat.in -p tre25.parm7 -c min25tre.rst7 -o tre25heat.mdout -x tre25heat.nc -r tre25heat.rst7

pmemd -O -i md.in -p tre25.parm7 -c tre25heat.rst7 -o tre25md.mdout -x tre25md.nc -r tre25md.rst7




Fitxer md per enviar al csuc
#!/bin/bash
#SBATCH -J mddao
#SBATCH -e %J.%j.err
#SBATCH -o %J.%j.out
#SBATCH -p gpu
#SBATCH -n 1
#SBATCH -t 0-24:00
module load apps/amber/22
##
#  Modify the input and output files!
cp -r ${SLURM_SUBMIT_DIR}/{*.in,*.parm7,*.rst7} $SCRATCH
cd $SCRATCH
echo $(SCRATCH)
echo $(SLURM_SUBMIT_DIR)
echo $SCRATCH
ls
pwd
pmemd.cuda -O -i md.in -p tre1.parm7 -c tre1heat.rst7 -o tre1md.mdout -x tre1md.nc -r tre1md.rst7
cp ./*.out ${SLURM_SUBMIT_DIR}

