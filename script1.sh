#!/bin/bash

echo "Escribe tu nombre:"
read nombre_usuario
mkdir $nombre_usuario
echo "Cuantas subcarpetas quieres crear?"
read num_folder
for item in $num_folder; do
  mkdir -p $nombre_usuario/folder_$item
done
echo "Deseas crear un achivo?
read respuesta_archivo
if[$respuesta_archivo];then
	echo "Escribe el nombre del archivo:"
	read name_file
	$nombre_usuario/touch $name_file
tree -L X

