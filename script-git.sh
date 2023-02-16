#!/bin/bash

# Modo de uso: copia o mueve este script a /usr/bin o /usr/local/bin y desde el directorio donde se encuentre la copia de un repo git, ejecútalo de esta manera:
# uptogit <ficheros>

# Comprobamos si el directorio en el que estamos es de un repositorio git
if [ ! -d '.git' ]; then
	echo 'Esta carpeta no contiene un repositorio Git'
	exit -1
fi

# Ahora comprobamos si se le paso algun parametro
if [ $# == 0 ]; then
	echo "¡Error! No se le a pasado ningún parámetro"
	echo "uptogit fichero1 fichero2 ... ficheroN"
	exit -1
else
	# Recorremos los parametros para comprobar si son ficheros o directorios
	for file in $*; do
		if [ ! -e $file ]; then
			echo "El archivo o directorio $file no existe"
			exit -1
		fi
	done

	# Si llegamos hasta aquí, indicamos a Git los archivos a subir
	git add $*

	# Esto nos pedira el mensaje del commit
	echo "Introduce el mensaje del commit:"
	read TXT
	git commit -m "$TXT"

	echo "Introduce la rama donde quieres subirlo"
	read BRANCH
	if [ $(git switch $BRANCH) -eq 0 ]; then
		git push origin $BRANCH
	else
		echo "La rama no existe y se subirá directamente a la rama master"
		git push origin master
	fi

fi