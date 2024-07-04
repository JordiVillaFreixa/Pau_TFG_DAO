# TFG_DAO


# BUSCAR INFO AL MANUAL D'AMBER, PUNT 13 PREPARING PDB FILES

## Preparem els documents necessaris per fer minimization, heat i production.

### Al document min s'ha d'afegir imin que és el minimization run, ntx= que llegeix les coordenades però no la velocitat del fitxer de coordenades, irest= valor per restart la simulació (no aplicable a la minimization); maxcyc= maxim de cicles de minimització; ncyc= algoritme de descens més pronunciat pels primers cicles de 0-ncyc; ntpr= fer un output del fitxer per cada cicle completat;ntwx= no hi ha un fitxer amber mdcrd(no aplicable per minimization); cut= distància de tall en angstrom (no pot ser menys de 8)

### Fitxer min.in

```
  simple generalized Born minimization script
 &cntrl
   imin=1, ntb=0, maxcyc=100, ntpr=10, cut=1000., igb=8, 
 /
 
```

# Al document de heat: imin= escollir tipus de md; nstlim= número de passos md in run; dt= temps per pas en picosegons (durada de temps per cada md step);ntf= configuració per no calcuar la força d'enllacç per enllaços restringits SHAKE; ntc= habilitar SHAKE per restringir tots els enllaços involucrant hidrogen; tempi= temperatura inicial en K; temp0= temperatura final en K; ntwx= mostrar la trajectoria d'amber cada quan; ntb= límits periòdics per volum constant; ntp= no control de pressió; ntt= control de temperatura; gamma_ln= freqüència de col·lisió Langevin; nmprot= rstriccions NMR i canvis de pes; ig= aleatoritzar la seed pel generador de números pseudoaleatoris

# Al docuemnt de production trobem alguns paràmetres iguals a fitxers anteriors, però, ntx= llegeix coordenades i velocitats del fitxer de coordenades rst7; irest= restart de la md previa; temp0= temperatura; ntb= utilitza condicions de contorn periòdiques amb pressió constant; barostat= utilitza el barostat de Berendsen per simualció de pressió constant

# Primer fem pdb4amber per preparar el fitxer per tleap amb dry i reduce

pdb4amber -i pdb1ksi.pdb -o dao.pdb --dry --reduce

#Canviem els residus necessaris per a que reconeixi l'amber

##FEEEEEEEEEEEEEEEER



#Fem antechamber del nostre residu TPQ

antechamber -fi ccif -i TPQ.cif -bk TPQ -fo ac -o tpq.ac -c bcc -at amber

#Canviar NT per N
sed 's/NT/N /' tpq.ac >tpq2.ac

#Hem de crear el nostre document tleap, HEAD_NAME i TAIL_NAME  identifiquen els atoms que es connectaran als anteriors i seguents amino acids respectivament. MAIN_CHAIN és la llista d'àtoms al llarg de la cadena que connecten els àtoms de head i tail. OMIT_NAME és la llista d'àtoms a TPQ que han de ser extrets de la estructura final. PRE_HEAD_TYPE i POST_TAIL_TYPE permet a prepgen quins atom types a la proteina seran utilitzats per la connexió covalent. Finalment CHARGE dona la càrrega total al residu (crec que ha de ser 0)

# No se crear l'arxiu tpq.mc


#Fem prepgen

prepgen -i tpq2.pdb -o tpq.prepin -m tpq.mc -rn TPQ

<<<<<<< HEAD
# Ara s'ha de fer run de parmchk2 utilitzant el seguent command:

parmchk2 -i tpq.prepin -f prepi -o frcmod.tpq -a Y \ -p $AMBERHOME/dat/leap/parm/parm10.dat
=======
>>>>>>> 2e57c34 (11)

# we created the tleap file and now we run tleap

tleap -f leap.in

#Si observem el documente de dao.pdb trobem que tenim CYX i no CYS, cosa que indica que hi ha un pont disulfur, i això li hem d'indicar
dao=loadpdb dao.pdb
bond dao.132.SG dao.153.SG
bond dao.314.SG dao.340.SG
bond dao.774.SG dao.795.SG
bond dao.956.SG dao.982.SG

#això s'ha d'afegir al fitxer de tleap.in


# After all this, now it's only needed minimization, heating and production

#Per minimization creem el fitxer min.in i fem sander

sander -O -i min.in -p dao.parm7 -c dao.rst7 -o min1.out -r min1.rst7

#Per heating creem el fitxer heat.in

sander -O -i heat.in -p dao.parm7 -c min1.rst7 -o heat.mdout \
       -x heat.nc -r heat.rst7

#Per production creem el fitxer md.in

sander -O -i md.in -p dao.parm7 -c heat.rst7 -o md1.mdout \
       -x md1.nc -r md1.rst7