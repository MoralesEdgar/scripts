#!/bin/bash

while true
do
 read -r -p "Deseas listar los servicios en ejecucion? [Y/n] " input
 
 case $input in
     [yY][eE][sS]|[yY])
 service --status-all | grep +
 echo "Escribe el nombre del servicio del que quieres ver su estatus:"
 read nombre_servicio
 tmp=`ps awx | grep $nombre_servicio |grep -v grep|wc -l`
 echo ""
 if [ $tmp != 0 ]; then
	echo "El estado del servicio es el siguiente:"
	echo ""
	echo ""
 	service $nombre_servicio status
 fi
 exit 1
 ;;
     [nN][oO]|[nN])
 echo "No"
        ;;
     *)
 echo "Opcion Invalida..."
 exit 1
 ;;
 esac
done
