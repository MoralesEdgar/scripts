#!/bin/bash

while true
do
 read -r -p "Deseas listar los servicios en ejecucion? [Y/n] " input
 
 case $input in
     [yY][eE][sS]|[yY])
 echo "Yes"
 ;;
     [nN][oO]|[nN])
 echo "No"
        ;;
     *)
 echo "Opcion Invalida..."
 exit 1
 ;;
 esac