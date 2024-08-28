#!/bin/bash

if [ -z "${BACKUPFOLDER}"]
then
    echo "You should define the \$BACKUPFOLDER variable before runnning the script"
    exit
else
    echo "\$BACKUPFOLDER defined and pointing towards $BACKUPFOLDER"
    echo "############### rsyncing lavandula ####################"
    rsync -Pchav --stats lavandula:/home/jvilla/scratch/ $BACKUPFOLDER/lavandula 
    echo "############### rsyncing lapalma ####################"
    rsync -Pchav --stats lapalma:/storage/scratch/uvic24/uvic24774/ $BACKUPFOLDER/lapalma 
fi
