# TFG_DAO

## Instalació amber

```
tar xvf Amber22.tar 
tar xvf AmberTools23.tar 
mkdir ~/software
mv amber22_src/ ~/software/
cd ~/software/amber22_src/build
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
source $HOME/software/amber24/amber.sh
```


## Configuracio Github amb VisualStudioCode
```
git config --global user.email "you@example.com"
git config --global user.name "Your Name"

```

