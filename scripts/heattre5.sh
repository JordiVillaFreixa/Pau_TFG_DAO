NAME='tre5'
cp ${INPUTDIR}/{heat.in,$NAME.parm7,$NAME.rst7} ${SCRATCHDIR}
cd ${SCRATCHDIR}

sander -O -i heat.in -p $NAME.parm7 -c min$NAME.rst7 -o heat$NAME.mdout \
       -x heat$NAME.nc -r heat$NAME.rst7
cp ./heat$NAME.mdout ${RESULTSDIR}