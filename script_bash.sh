#!/bin/bash

if [ $(whoami) != "root" ]; then
    echo "Tienes que ser root para ejecutar este script"
    echo "Ejecuta "sudo su" para ser root"
    exit 1
fi

while [ "$opcion" != "0" ]
do

echo
echo "MENU"
echo "----"
echo " 1.Crear un usuario"
echo " 2.Crear la contraseña a un usuario"
echo " 3.Crear grupo"
echo " 4.Añadir un usuario a un grupo"
echo " 5.Ver datos de un usuario"
echo " 6.Borrar un usuario"
echo " 7.Borrar un grupo"
echo " 0.Salir"

read opcion

case $opcion in

1)
echo "Crear usuario"
echo "Inserta el nombre del usuario nuevo:"
read user
adduser $user
;;

2)
echo "Cambiar la contraseña a un usuario"
echo "Inserta el nombre del usuario para cambiarle la contraseña"
read user2
passwd $user2
;;

3)
echo "Crear grupo"
echo "Inserta el nombre del grupo"
read grupo
groupadd $grupo
;;

4)
echo "Añadir un usuario a un grupo"
echo "Inserta el nombre del usuario"
read user3
echo "Inserta el nombre del grupo"
read grupo2
sudo addgroup $user3 $grupo2 
;;

5)
echo "Ver datos de un usuario"
echo "Inserta el nombre del usuario"
read user5
id $user5

6)
echo "Dame el nombre del usuario"
read nombre
deluser $nombre

7)
echo"Dame el nombre del grupo: "
read grupo
delgroup $grupo
;;

esac
done
exit 0