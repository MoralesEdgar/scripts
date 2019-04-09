#!/bin/bash

echo "Escribe tu nombre:"
read nombre_usuario
mkdir $nombre_usuario
echo "Cuantas subcarpetas quieres crear?"
read num_folder
for ((i=1; i<=$num_folder; i++))do
  mkdir -p $nombre_usuario/folder_$i
done
echo "Deseas crear un achivo?"
read respuesta_archivo
if [ $respuesta_archivo != '' ];
then
	echo "Escribe el nombre del archivo:"
	read name_file
	cd $nombre_usuario
	touch $name_file
	tree -L X
	exit 0
fi
exit0	
