#!/bin/bash
# script di lancio dell'alimentazione di iris tramite pyhton
#
# il primo argomento ed unico è il minuto in cui eseguire il comando ogni 10 minuti
exe=/rt10

while [ 1 ]
do
   data_corrente=$[ 10#$(date +"%M") % 10 ]
   if [ $data_corrente == $1 ]
   then
     logger -is -p user.notice "$exe: start @ $1 minute"
     echo "$exe start"
       $exe
   else
     sleep 30
   fi
done
