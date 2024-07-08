NAME='tre5'
cp ${INPUTDIR}/{min.in,$NAME.parm7,$NAME.rst7} ${SCRATCHDIR}
cd ${SCRATCHDIR} 

sander -O -i min.in -p $NAME.parm7 -c $NAME.rst7 -o min$NAME.mdout \
       -x min$NAME.nc -r min$NAME.rst7
cp ./min$NAME.mdout ${RESULTSDIR}