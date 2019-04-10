#!/bin/bash

read -p -r "Deseas listar los servicios en ejecucion (y/n)?"
respuesta=${respuesta,,}
if [[ $respuesta =~ ^(yes|y|) ]] || -z $response ]]; then
	echo "entro aqui"
fi
