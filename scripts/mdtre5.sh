NAME='tre5'
cp ${INPUTDIR}/{md.in,$NAME.parm7,$NAME.rst7} ${SCRATCHDIR}
cd ${SCRATCHDIR}

sander -O -i md.in -p $NAME.parm7 -c heat$NAME.rst7 -o md$NAME.mdout \
       -x md$NAME.nc -r md$NAME.rst7
cp ./md$NAME.mdout ${RESULTSDIR}