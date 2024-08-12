# Preparing structure files
- [Preparing structure files](#preparing-structure-files)
  - [Preliminary installations](#preliminary-installations)
  - [Obtain PDB files to work in AMBER](#obtain-pdb-files-to-work-in-amber)
  - [Create library entries for cofactors](#create-library-entries-for-cofactors)
    - [Library entry for TPQ](#library-entry-for-tpq)
    - [Library entry for NAG](#library-entry-for-nag)

## Preliminary installations

* cmake (for openbabel):
```
brew install cmake
```
* openbabel from github:
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

This folder contains all PDB files used in the calculation

1. Download the original PDB file for the protein and accessory files for the coordinates of cofactors and sugars (the enzyme DAO, its ligand NAG, the modified residue TPQ and trehalose):
   * the enzyme DAO
```
wget -nc https://files.rcsb.org/view/1KSI.pdb
```
   * the ligand NAG
``` 
wget -nc https://files.rcsb.org/ligands/download/NAG.cif
```
   * the modified TPQ residue
```
wget -nc https://files.rcsb.org/ligands/view/TPQ_ideal.sdf
obabel -i sdf TPQ_ideal.sdf -o pdb -O TPQ_ideal.pdb
sed -i -e 's/UNL/TPQ/' TPQ_ideal.pdb
```
After this last step, the `TPQ_ideal.pdb` contains a list of atom names that does not correspond to the proper naming in the PDB. We simply extract the proper names from the `TPQ.cif` file and add them to `TPQ_ideal.pdb`, creating `TPQ_final.pdb`, that we will use later.
   * trehalose from drugbank:
```
wget -nc https://go.drugbank.com/structures/small_molecule_drugs/DB12310.sdf
```

Alternatively, use the `PDB_work.ipynb` notebook to obtain the pdb and cif files. 

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


## Create library entries for cofactors

### Library entry for TPQ

1. Use `antechamber` to [prepare the library](https://docs.bioexcel.eu/2020_06_09_online_ambertools4cp2k/04-parameters/index.html) for TPQ generating a [mol2 file](https://chemyang.ccnu.edu.cn/ccb/server/AIMMS/mol2.pdf). For an example on how to proceded to parameterize a residue with general Gaussian RESP charges, check [this web page](https://carlosramosg.com/amber-custom-residue-parameterization):
```
antechamber -fi pdb -i TPQ_final.pdb -bk TPQ -fo ac -o TPQ.ac -c bcc -nc 0 -rn TPQ -at gaff2
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
3. Use the new `TPQ.mc` file to generate the residue entry and parameterize it (see the description of the PREP input files [here](https://ambermd.org/doc/prep.html); see also [this tutorial](https://ambermd.org/tutorials/pengfei/)):
```
prepgen -i TPQ.ac -o TPQ.prepin -m TPQ.mc -rn TPQ
parmchk2 -i TPQ.ac -f ac -o TPQ.frcmod -s gaff2
```

### Library entry for NAG

4. Repeat the process for NAG:
```
antechamber -fi ccif -i NAG.cif -fo ac -o nag3.ac -c bcc -at amber -nc 0 -rn NAG -bk NAG
```
