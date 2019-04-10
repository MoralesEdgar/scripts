#!/bin/bash

path_file="/home/edgarmorales/scripts"

cat $path_file/usuarios.txt |while read line; do mkdir $line; done
