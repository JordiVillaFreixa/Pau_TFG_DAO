# **Simul·lació de DAO amb trehalosa i aigua**

## Preparar el PDB file

### Primer hem de descarregar el PDB file necessari per a la simuació referent a la DAO de *Pisum Sativum*.
### El primer pas per poder utilitzar el PDB file amb tleap és prepar-lo amb:

```
pdb4amber -i fitxer -o output(nom del fitxer que volem) --dry --reduce
```
### Utilitzem --dry per treure les aigües cristal·lografàfiques i --reduce per afegir àtoms d'hidrogen a les localitzacions òptimes

### Després de realitzar el pdb4amber, possiblement s'han de fer canvis (recomant amb la comanda sed)

## càrregas parcials i tipus d'àtoms per TPQ?

### Utilitzar R.E.D tools (aprendre a com va). La utiltizació de R.E.D tools ens permet

## Addició de trehalosa com a sucre a la simulació més l'aigua

### El sucre que s'utilitzarà a la simulació serà la trehalosa (α,α‐Trehalose); juntament amb l'aigua.



## antechamber CDD

## afegir els paràmetres amb tleap

## crear la topologia

## simulacions