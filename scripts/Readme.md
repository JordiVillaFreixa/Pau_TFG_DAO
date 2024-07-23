# Scripts to run MD simulations on DAO

## Overview

This folder includes all the scripts for the simulation of trehalose free and trehalose containing water+DAO boxes. 


* `set_scratchdir.sh.example`: when you work in different computers, you need to control the name of the scratch directory where results of MD calculations are stored

## Running AMBER

### Running AMBER in the queue

Once you have build the topology of a given system, let us say `../inputs/tre5.rst7` and `..inputs/tre5.parm7`, submitting a minimization + heating + md using the corresponding inputs in `../inputs/{min.in,heat.in,md.in}` reduces to run

```
bash submit.sh tre5
```

### Running AMBER in local

Simply extract the fragment of the script you are interested in from the file `submit.sh` and run individual calculations in local.