# TFG_DAO

## Instalació amber

```
tar xvf Amber<version>.tar 
tar xvf AmberTools<version>.tar 
mkdir ~/Software
mv amber<version>_src/ ~/Software/
cd ~/Software/amber<version>_src/build
./run_cmake
make install

```
## Quan està instal·lat l'amber, cada cop que vull treballar amb ell he de còrrer la següent comanda:

```
cd $AMBERHOME
source amber.sh
cd

```

o bé, simplement, afegir aquesta línea al fitxer `~/.bashrc` (o a `~/.bash_profile` si treballem a Mac):
```
source $HOME/software/amber<version>/amber.sh
```


## Configuracio Github amb VisualStudioCode
```
git config --global user.email "you@example.com"
git config --global user.name "Your Name"

```

