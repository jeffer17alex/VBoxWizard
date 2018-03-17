#!/bin/bash

while [ 1 ]; do
dialog --inputbox "Nombre de la maquina: " 8 40 2>nombre
varnombre=$(cat nombre)
VBoxManage list vms | grep ${varnombre}
if [ $? -eq 1 ]; then
break
fi
done



NCORE="dialog --backtitle \"# CPU\" --radiolist \"Select CPU \" 10 40 4"
for i in $(seq 1 1 2); do
NCORE="${NCORE} ${i} ${i} off"
done
NCORE="${NCORE} 2> salida"
Eval $NCORE
