# PROVA 2 DAO

### En aquesta segona prova de càlculs actualitzarem els paràmetres als necessaris per DAO. Afegirem els force fields que vaig trobar i alhora la trehalosa a la water box. S'hauran de repetir alguns pasos amb la prova anterior i afegir-hi de nous, en aquet cas no hi hauria d'haver-hi problemes amb els fitxers a crear (substitució d'àtoms, addició de water box, NAG...)

```
pdb4amber -i pdb1ksi.pdb -o dao.pdb --dry --reduce
```
### Necessitem fer els canvis en el fitxer dao necessaris per a que Amber els reconeixi

```
sed 
```

```
antechamber -fi ccif -i TPQ.cif -bk TPQ -fo ac -o tpq.ac -c bcc -at amber
```
### Canviar els NT per N
```
sed 's/NT/N /' tpq.ac >tpq2.ac
```

```
prepgen -i tpq.pdb -o tpq.prepin -m tpq.mc -rn TPQ
```

```
parmchk2 -i tpq.prepin -f prepi -o frcmod.tpq -a Y \ -p $AMBERHOME/dat/leap/parm/parm10.dat
```
```
grep -v NAG dao.pdb > daonag.pdb
```
### no se si fer-ho amb això encara

### Hem de crear l'arxiu tleap

```
tleap -f leap.in
```