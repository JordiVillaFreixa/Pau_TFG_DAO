#!/bin/bash

if [ -z "${BACKUPFOLDER}" ]
then
    echo "You should define the \$BACKUPFOLDER variable before runnning the script"
    exit
fi

if [ "$#" -ne 1 ]
then
#    echo "\$BACKUPFOLDER defined and pointing at $BACKUPFOLDER"
#    echo "############### rsyncing lavandula ####################"
#    rsync -Pchav --stats lavandula:/home/jvilla/scratch/ $BACKUPFOLDER/lavandula 
#    echo "############### rsyncing lapalma ####################"
#    rsync -Pchav --stats lapalma:/storage/scratch/uvic24/uvic24774/ $BACKUPFOLDER/lapalma 
    #echo "############### rsyncing pirineusIII ####################"
    #rsync -Pchav --stats hpctest:/home/biotectfg02/scratch/ $BACKUPFOLDER/csuc 
    echo "############### rsyncing csuc ####################"
    rsync -Pchav --stats csuc:/home/biotectfg02/scratch/ $BACKUPFOLDER/csuc 
else
    echo "############### rsyncing csuc ####################"
    rsync -Pchav --stats csuc:/home/biotectfg02/scratch/ $BACKUPFOLDER/csuc
fi
