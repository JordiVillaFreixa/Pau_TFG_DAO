# Preparing structure files
- [Preparing structure files](#preparing-structure-files)
  - [Preliminary installations](#preliminary-installations)
    - [`openbabel`](#openbabel)
  - [Obtain PDB files to work in AMBER](#obtain-pdb-files-to-work-in-amber)
    - [The enzyme DAO](#the-enzyme-dao)
    - [The ligand NAG](#the-ligand-nag)
    - [The modified TPQ residue](#the-modified-tpq-residue)
    - [Trehalose](#trehalose)
  - [Generating the DAO+nTRE PDB files](#generating-the-daontre-pdb-files)

## Preliminary installations

### `openbabel`

First install `cmake`. In Mac OS:

```
brew install cmake
```
Now, install `openbabel` from github:
```
git clone git@github.com:openbabel/openbabel.git
cd openbabel
mkdir build
cd build
cmake ..
make -j2
make test
sudo make install
```


## Obtain PDB files to work in AMBER

Download the original PDB file for the protein and accessory files for the coordinates of cofactors and sugars.

This is a step by step collection of instructions for each fragmnent of the desired simulated system. Alternatively, use the [`PDB_work.ipynb`](https://github.com/JordiVillaFreixa/Pau_TFG_DAO/blob/main/pdb/PDB_work.ipynb) notebook to obtain the pdb and cif files. 

### The enzyme DAO
```
wget -nc https://files.rcsb.org/view/1KSI.pdb
```



1. Get the protein PDB file prepared for AMBER:


Remove the connection between cysteine residues, as this will be explicitly added in `tleap` below. Also change the character of the TPQ entry and specify it is a regular residue (it is still not, but we will make it so in a few lines)

```
pdb4amber -i 1KSI.pdb -o dao.pdb --dry --reduce
sed -i -e '/TPQ/ s/HETATM/ATOM  /' dao.pdb
grep -v NAG dao.pdb | grep -v CONECT > dao_noNAG.pdb
```
It is interesting to keep in mind the problems found in the PDB entry:
```
REMARK 480 ZERO OCCUPANCY ATOM                                                  
REMARK 480 THE FOLLOWING RESIDUES HAVE ATOMS MODELED WITH ZERO                  
REMARK 480 OCCUPANCY. THE LOCATION AND PROPERTIES OF THESE ATOMS                
REMARK 480 MAY NOT BE RELIABLE. (M=MODEL NUMBER; RES=RESIDUE NAME;              
REMARK 480 C=CHAIN IDENTIFIER; SSEQ=SEQUENCE NUMBER; I=INSERTION CODE):         
REMARK 480   M RES C SSEQI ATOMS                                                
REMARK 480     LYS A  149   CB   CG   CD   CE   NZ                              
REMARK 480     LYS A  472   CB   CG   CD   CE   NZ                              
REMARK 480     GLU B  148   CB   CG   CD   OE1  OE2                             
REMARK 480     ARG B  640   CB   CG   CD   NE   CZ   NH1  NH2 
```
and also the close contacts that reveal covalent links between NAG and the protein:
```
REMARK 500 THE FOLLOWING ATOMS ARE IN CLOSE CONTACT.                            
REMARK 500                                                                      
REMARK 500  ATM1  RES C  SSEQI   ATM2  RES C  SSEQI           DISTANCE          
REMARK 500   O4   NAG C     1     N2   NAG C     2              2.03            
REMARK 500   OD1  ASP B   575     O    HOH B   887              2.16            
REMARK 500   O4   NAG C     1     O5   NAG C     2              2.17            
REMARK 500   ND2  ASN B   558     C2   NAG B   657              2.18 
```
as well as other contacts worth monitoring during dynamics:
```
REMARK 500 DISTANCE CUTOFF:                                                     
REMARK 500 2.2 ANGSTROMS FOR CONTACTS NOT INVOLVING HYDROGEN ATOMS              
REMARK 500 1.6 ANGSTROMS FOR CONTACTS INVOLVING HYDROGEN ATOMS                  
REMARK 500                                                                      
REMARK 500  ATM1  RES C  SSEQI   ATM2  RES C  SSEQI  SSYMOP   DISTANCE          
REMARK 500   NE2  HIS A   268     NH1  ARG B   640     4455     1.95   
```
in addition to bond length. angle and torsion deviations also in `REMARK 500`

Finally, the active site is located, for both chain `A` and `B` in: 
```
REMARK 620 COORDINATION ANGLES FOR:  M RES CSSEQI METAL                         
REMARK 620                              CU A 650  CU                            
REMARK 620 N RES CSSEQI ATOM                                                    
REMARK 620 1 HIS A 442   NE2                                                    
REMARK 620 2 HIS A 444   NE2  98.7                                              
REMARK 620 3 HIS A 603   ND1  93.0 134.6                                        
REMARK 620 4 HOH A 658   O    91.9 119.7 103.4                                  
REMARK 620 5 HOH A 659   O   158.9  93.3  90.7  67.0                            
REMARK 620 N                    1     2     3     4                             
REMARK 620                                                                      
REMARK 620 COORDINATION ANGLES FOR:  M RES CSSEQI METAL                         
REMARK 620                              MN A 653  MN                            
REMARK 620 N RES CSSEQI ATOM                                                    
REMARK 620 1 ASP A 451   OD1                                                    
REMARK 620 2 PHE A 452   O    92.6                                              
REMARK 620 3 ASP A 453   OD1  95.1  76.0                                        
REMARK 620 4 ASP A 592   OD1 102.6 161.9  92.8                                  
REMARK 620 5 ILE A 593   O    88.6  94.5 169.9  95.7                            
REMARK 620 6 HOH A 660   O   168.1  75.6  81.3  88.9  93.3                      
REMARK 620 N                    1     2     3     4     5  
(...)
SITE     1 ACA  7 HIS A 442  HIS A 444  HIS A 603   CU A 650                    
SITE     2 ACA  7 HOH A 658  HOH A 659  TPQ A 387                               
SITE     1 ACB  7 HIS B 442  HIS B 444  HIS B 603   CU B 650                    
SITE     2 ACB  7 HOH B 658  HOH B 659  TPQ B 387 
```
and the post translational modifications are found in 
```
MODRES 1KSI ASN A  131  ASN  GLYCOSYLATION SITE                                 
MODRES 1KSI ASN A  558  ASN  GLYCOSYLATION SITE                                 
MODRES 1KSI ASN B  131  ASN  GLYCOSYLATION SITE                                 
MODRES 1KSI ASN B  558  ASN  GLYCOSYLATION SITE                                 
MODRES 1KSI TPQ A  387  TYR                                                     
MODRES 1KSI TPQ B  387  TYR  
HET    TPQ  A 387      14                                                       
HET    TPQ  B 387      14                                                       
HET    NAG  C   1      14                                                       
HET    NAG  C   2      14                                                       
HET    NAG  D   1      14                                                       
HET    NAG  D   2      14                                                       
HET    NAG  A 657      14                                                       
HET     CU  A 650       1                                                       
HET     MN  A 653       1                                                       
HET    NAG  B 657      14                                                       
HET     CU  B 650       1                                                       
HET     MN  B 653       1  
```
Finally, two disulfide bonds are found in each monomer:
```
SSBOND   1 CYS A  137    CYS A  158                          1555   1555  1.99  
SSBOND   2 CYS A  319    CYS A  345                          1555   1555  2.00  
SSBOND   3 CYS B  137    CYS B  158                          1555   1555  2.01  
SSBOND   4 CYS B  319    CYS B  345                          1555   1555  1.98  
```

Note that there are 5 missing residues in the N-terminal of the PDB file for each chain, which implies that the AMBER numbering is lowered by 5 with respect to the PDB numbering for all residues.



### The ligand NAG
``` 
wget -nc https://files.rcsb.org/ligands/download/NAG.cif
```

```
antechamber -fi ccif -i NAG.cif -fo ac -o nag3.ac -c bcc -at amber -nc 0 -rn NAG -bk NAG
```

### The modified TPQ residue
```
wget -nc https://files.rcsb.org/ligands/view/TPQ_ideal.sdf
obabel -i sdf TPQ_ideal.sdf -o pdb -O TPQ_ideal.pdb
sed -i -e 's/UNL/TPQ/' TPQ_ideal.pdb
```
After this last step, the `TPQ_ideal.pdb` contains a list of atom names that does not correspond to the proper naming in the PDB. We simply extract the proper names from the `TPQ.cif` file and add them to `TPQ_ideal.pdb`, creating `TPQ_final.pdb`, that we will use later. See how the file is AMBER-friendly (no CONECT lines):
```
ATOM      1  N   TPQ     1      -5.202  -3.337  -2.620  1.00  0.00           N  
ATOM      2  CA  TPQ     1      -4.504  -2.205  -2.013  1.00  0.00           C  
ATOM      3  CB  TPQ     1      -3.306  -1.797  -2.878  1.00  0.00           C  
ATOM      4  C   TPQ     1      -5.534  -1.096  -1.870  1.00  0.00           C  
ATOM      5  O   TPQ     1      -6.472  -0.902  -2.631  1.00  0.00           O  
ATOM      6  OXT TPQ     1      -5.302  -0.323  -0.776  1.00  0.00           O  
ATOM      7  C1  TPQ     1      -2.567  -0.628  -2.304  1.00  0.00           C  
ATOM      8  C2  TPQ     1      -1.505  -0.918  -1.305  1.00  0.00           C  
ATOM      9  O2  TPQ     1      -1.234  -2.064  -0.959  1.00  0.00           O  
ATOM     10  C3  TPQ     1      -0.770   0.229  -0.729  1.00  0.00           C  
ATOM     11  C4  TPQ     1      -1.036   1.489  -1.085  1.00  0.00           C  
ATOM     12  O4  TPQ     1      -0.360   2.569  -0.558  1.00  0.00           O  
ATOM     13  C5  TPQ     1      -2.090   1.783  -2.082  1.00  0.00           C  
ATOM     14  O5  TPQ     1      -2.350   2.931  -2.427  1.00  0.00           O  
ATOM     15  C6  TPQ     1      -2.827   0.637  -2.655  1.00  0.00           C  
ATOM     16  H   TPQ     1      -6.178  -3.432  -2.445  1.00  0.00           H  
ATOM     17  H2  TPQ     1      -4.652  -4.071  -3.009  1.00  0.00           H  
ATOM     18  HA  TPQ     1      -4.154  -2.482  -1.011  1.00  0.00           H  
ATOM     19  HB2 TPQ     1      -3.623  -1.545  -3.897  1.00  0.00           H  
ATOM     20  HB3 TPQ     1      -2.597  -2.628  -2.961  1.00  0.00           H  
ATOM     21  HXT TPQ     1      -5.946   0.405  -0.642  1.00  0.00           H  
ATOM     22  H3  TPQ     1       0.000   0.000   0.000  1.00  0.00           H  
ATOM     23  HO4 TPQ     1      -0.987   3.197  -0.184  1.00  0.00           H  
ATOM     24  H6  TPQ     1      -3.597   0.871  -3.383  1.00  0.00           H  
```
1. Use `antechamber` to [prepare the library](https://docs.bioexcel.eu/2020_06_09_online_ambertools4cp2k/04-parameters/index.html) for TPQ generating an AC file (we could directly obtain a [mol2 file](https://chemyang.ccnu.edu.cn/ccb/server/AIMMS/mol2.pdf)) with AM1-BCC charges. For an example on how to proceded to parameterize a residue with general Gaussian RESP charges, check [this web page](https://carlosramosg.com/amber-custom-residue-parameterization):
```
antechamber -fi pdb -i TPQ_final.pdb -bk TPQ -fo ac -o TPQ.ac -c bcc -nc 0 -rn TPQ -at amber
```
2. Prepare a main chain file for TPQ that describes the connectivity of the residue in the peptide chain:
```
cat <<EOF > TPQ.mc
HEAD_NAME N
TAIL_NAME C
MAIN_CHAIN CA
OMIT_NAME H2
OMIT_NAME OXT
OMIT_NAME HXT
PRE_HEAD_TYPE C
POST_TAIL_TYPE N
CHARGE 0.0
EOF
```
Use the new `TPQ.mc` file to generate the residue entry and parameterize it (see the description of the PREP input files [here](https://ambermd.org/doc/prep.html); see also [this tutorial](https://ambermd.org/tutorials/pengfei/)):
```
prepgen -i TPQ.ac -o TPQ.prepin -m TPQ.mc -rn TPQ
```
Now, the `TPQ.prepin` file contains an `NT` atom type for the main chain Nitrogen atom:
```
   4  N     NT    M    3   2   1     1.540   111.208  -180.000 -0.881554
```

 This should be changed into `N` atom type:

```
(...)
   4  N     N     M    3   2   1     1.540   111.208  -180.000 -0.881554
(...)
```

Finally, generate the `TPQ.frcmod` file that contains the parameters for the new residue:

```
parmchk2 -i TPQ.ac -f ac -o TPQ.frcmod -s gaff2
```

### Trehalose

We can get the sdf from drugbank using 
```
wget -nc https://go.drugbank.com/structures/small_molecule_drugs/DB12310.sdf
```
but, in this case, I used the [PDB_work.ipynb](https://github.com/JordiVillaFreixa/Pau_TFG_DAO/blob/main/pdb/PDB_work.ipynb) notebook to generate `trehalose.pdb`

```
grep -v CONECT trehalose.pdb >trehalose_final.pdb
antechamber -fi pdb -i trehalose_final.pdb -bk TRE -fo mol2 -o TRE.mol2 -c bcc -nc 0 -rn TRE -at amber
parmchk2 -i TRE.mol2 -f mol2 -o TRE.frcmod -s amber
```

## Generating the DAO+nTRE PDB files

In order to build the systems containing the protein DAO and a certain number *n* of copies of the trehalose (TRE) molecule, we make use of `packmol`:

```
packmol < packmol_dao_TRE.in
```

where `packmol_dao_TRE.in` is:
```
# All atoms from diferent molecules will be at least 2.0 Angstroms apart
tolerance 6.0

# The type of the files will be pdb
filetype pdb

# The name of the output file
output dao_noNAG_TRE.pdb

# put the COM of the solute at the center of the box
# obtained from Chimera on dao_noNAG.pdb using Select + Tools/StructureAnalysis/Planes-Axes-Centroids 
# I leave the rotation to 0 by now, as the DAO structure in the 1KSI pdb file is relatively well oriented with respect to the final MD box
structure dao_noNAG.pdb
  number 1
  fixed 22.86382851 51.27007338 2.5412616 0. 0. 0.
  center
end structure

# in order to know the size of the box where to put the trehalose molecules, we use the info from 
# tleap -f tleap_dao_noNAG.in > tleap_dao_noNAG.log
# which provides the bounding box of the trehalose free MD run, that we wish to maintain:
#   Total bounding box for atom centers:  104.841 102.718 137.764
# so, we take as the lower and upper coordinates of the box:
# Xmin=22.864-104.841/2=-29.557
# Xmax=22.864+104.841/2=75.285
# Ymin=51.270-102.718/2=-0.089
# Ymax=51.270+102.718/2=102.629
# Zmin=2.541-137.764/2=-66.341
# Zmax=2.541+137.764/2=71.423
# add now add trehalose molecules
structure trehalose_final.pdb
  number 300     # the number of TRE molecules required
  inside box -29.557 -0.089 -66.341 75.285 102.629 71.423
end structure
```

To facilitate the generation of a collection of systems with different number of trehalose molecules, check the script `packmol_dao_TRE.sh`.
