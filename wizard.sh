#!/bin/bash

while [ 1 ]; do
  #dialog --inputbox "Nombre de la maquina: " 8 40 2>nombre
  varnombre=$(dialog --inputbox "Nombre de la maquina: " 8 40 3>&1 1>&2 2>&3 3>&-)
  #varnombre=$(cat nombre)
  VBoxManage list vms | grep -w ${varnombre}
  if [ $? -eq 1 ]; then
    break
  fi
done

PROC=$(cat /proc/cpuinfo | grep processor | wc -l)
NCORE="dialog --backtitle \"# CPU\" --radiolist \"Select CPU \" 10 40 4"

for i in $(seq 1 1 2); do
  NCORE="${NCORE} ${i} ${i} off"
done

NCORE="${NCORE} 2> salida"
eval $NCORE

#DISK

HDSIZE=$(dialog --backtitle "Disco duro " --radiolist "Capacidad " 0 0 0 1 512 on 2 2048 off 3 4096 off 4 8192)

case ${HDSIZE} in
  1)
    HDSIZE=512
    ;;
  2)
    HDSIZE=2048
    ;;
  3)
    HDSIZE=4096
    ;;
  4)
    HDSIZE=8192
    ;;
esac

echo $HDSIZE
