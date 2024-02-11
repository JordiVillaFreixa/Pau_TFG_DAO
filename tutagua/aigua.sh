#BUILDING PROTEIN SYSTEMS IN EXPLICIT WATER TUTORIAL
#Visualitzem el fitxer pdb corresponent a Crystal structure of the extracellular domain of human RAMP1 amb vmd, podem visualitzar-ho directament amb:

vmd 2yx8.pdb

#Realitzem els canvis que ens diuen al tutorial desde VMD
#Creem una còpia del fitxer pdb per treballar amb ell
cp 2yx8.pdb 2yx8_fxMET.pdb

#Obrim el fitxer amb el nostre editor de text

nano 2yx8_fxMET.pdb

#Ara hem de fer que els HETATM siguin ATOM, utilitzem sed. MSE a MET, SE passa a SD i a la útlima columna, SE passa a S.

sed 's/HETATM/ATOM  /' 2yx8_fxMET.pdb|sed 's/MSE/MET/' |sed 's/SE / SD/'|sed 's/SE/ S/' >2yx82.pdb

#Observem els canvis i afegim un de nou, que és canviar les cisteines (CYS) a CYX que és el que reconeix Amber

sed 's/CYS/CYX/' 2yx82.pdb

#fem una nova còpia del fitxer

cp 2yx82.pdb 2yx8_fxMET_fxCYS.pdb

# Anem al website de H++ desde el tutorial i seguim els passos que ens donen allà


