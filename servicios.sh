#!/bin/bash

while true
do
 read -r -p "Deseas listar los servicios en ejecucion? [Y/n] " input
 
 case $input in
     [yY][eE][sS]|[yY])
 service --status-all | grep +
 echo "Escribe el nombre del servicio:"
 read nombre_servicio
 while [ "$opcion" != "0" ]
 do

 echo
 echo "Que deseas hacer?"
 echo "----"
 echo " 1.Verificar el estado del servicio."
 echo " 2.Hacer down al servicio."
 echo " 3.Hacer up al servicio."

 read opcion

 case $opcion in
 	1)
	tmp=`ps awx | grep $nombre_servicio |grep -v grep|wc -l`
	if [ $tmp != 0 ]; then
		echo "El estado del servicio es el siguiente:"
		echo ""
		echo ""
 		service $nombre_servicio status
 	fi
 	echo "El servicio no se encuentra activo."
 	exit 1
	;;
	2)
	{
		sudo service $nombre_servicio stop
		echo "El servicio se ha detenido correctamente."
		exit 1
	} || {
		echo "Hubo un problema al detener el servicio."
		exit 1
	}
	#sudo service $nombre_servicio stop
	#echo ""
	#echo "Se ha detenido correct"
	#exit 1
	;;
	3)
	{
		sudo service $nombre_servicio start
		echo "El servicio se ha iniciado correctamente."
		exit 1
	} || {
		echo "Hubo un problema al iniciar el servicio."
		exit 1
	}
	#sudo service $nombre_servicio start
	#exit 1
	;;

	esac
	done
	exit 0

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
