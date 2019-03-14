#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
Desarrollado por: Edgar Morales
Script para crear usuarios Unix.
"""

import os, sys, crypt, random, grp, pwd

def creacion():
	command=""
	#Toma de valores iniciales.
	print ("Si no deseas completar alguna opcion dejala en blanco, El nombre es obligatorio.")
	print ("")
	nombre = input("Indique el ID-Nombre del usuario: ")
	desc = input("Indique una descripcion para el usuario: ")
	uid = input("Indique el UID del usuario: ")
	guid = input("Indique el nombre Grupo primario del usuario: ")
	home = input("Indique el home del usuario: ")
	grupos = input("Introduce los grupos del usurio separados por comas: ")
	password = input("Indica el password del usuario: ")
	shell = input("Indica la shell del usuario: ")
	
	#El nombre es obligatorio
	if nombre != "":
		#Si se ha dado una descripcion...
		if desc != "":
			command=command+" -c \""+desc+"\""

		if uid != "":
			#Si se ha dado el uid....
			#Comprobamos que no exista, combirtiendolo a integer, si existe salimos de la ejecucion....
			if ComprobarUid(int(uid)) == 1:
				sys.stderr.write("El UID ya existe.\n")
				sys.stderr.close()
				sys.exit(1)
			else:
				command=command+" -u "+uid

		if guid != "":
			#Realizamos dos comprobaciones, una con valor integer-GUID otra con texto.
			try:
				a=ComprobarGuid(int(guid))
			except:
				a=0
				
			try:
				b=ComprobarGuidName(guid)
			except:
				b=0
			
			#Si no encontramos el grupo por nombre ni por guid, ofrecemos la posibilidad de crearlo.
			if int(a) == 0 and int(b) == 0:
				cond = raw_input("El grupo primario no existe. Desea crearlo ahora [Yes/No]: ")
				#Para crearlo solicitamos guid y nombre, verificamos que ninguno existe y creamos el grupo
				if cond == "Yes":
					numg = raw_input("Introduce el UID: ")
					nomg = raw_input("Introduce el nombre: ")
					if ComprobarGuid(int(numg)) == 1:
						sys.stderr.write("El ID grupo ya existe.\n")
						sys.stderr.close()
						sys.exit(1)
					elif ComprobarGuidName(nomg) == 1:
						sys.stderr.write("El Nomrbre del grupo ya existe.\n")
						sys.stderr.close()
						sys.exit(1)
					#Si ambas comprobaciones son falsas, no existe ni el uid ni el grupo, entonces se crea y se add el guid, al comando final.
					else:
						command1="groupadd -g "+numg+" "+nomg
						os.system(command1)
						command=command+" -g "+numg
				elif cond == "No":
					sys.stderr.write("El grupo no existe.\n")
					sys.stderr.close()
					sys.exit(1)
				#una opcion distinta de Yes o No sale de la ejecucion
				else:
					sys.stderr.write("Opcion incorrecta.\n")
					sys.stderr.close()
					sys.exit(1)
				
			#Si encontramos el grupo se prepara el comando directamente
			else:
				command=command+" -g "+guid

		#Si se ha dado el home.....
		if home != "":
			command=command+" -d "+home

		#Si se ha dado el password, se codifica
		if password != "":
			#Obtenemos un salt aleatorio, para codificar el password
			salt=getsalt()
			#Codificamos el password
			encPass = crypt.crypt(password,salt)
			#Preparamos el comando final
			command=command+" -p "+encPass

		#Si se ha dado shell.....
		if shell != "":
			command=command+" -s "+shell

		#Si se ha dado una lista de grupos.....
		#Comprobamos que existen, si no indicamos los que no existen y salimos.
		if grupos != "":
			#Comprobamos si existen los grupos de la lista
			p=ComprobarGrupos(grupos)
			#Si obtenemos "0" algun grupo no existe, indicamos que grupo y salimos.
			if int(p[0]) == 0:
				sys.stderr.write("De la lista de grupos alguno/s no existe:\n")
				print(p[1])
				sys.stderr.close()
				sys.exit(1)
			else:
				command=command+" -G "+grupos

		command=command+" "+nombre
		#Tenemos el comando completo y creamos el user
		try:
			#Creamos el usuario
			print("creamos usuario.\n")
			os.system("useradd "+command)
		except:
			#Controlamos las excepciones
			print("Excepcion.")
	else:
		print("El nombre es obligatorio\n")

		
#Comprobamos si existe el grupo dando el nombre como string
def ComprobarGuidName(guid):
	try:
		#Si el grupo SI existe, return 1
		if grp.getgrnam(guid) != "":
			return 1
	#Si el grupo NO existe, return 0
	except KeyError,ValueError:
		return 0

	
def ComprobarGrupos(grupos):
	grupos2=""
	NoExist=1
	lista=""
	#Quitamos las "," y las cambiamos por blancos.
	for i in grupos:
		if i==",":
			grupos2=grupos2+" "
		else:
			grupos2=grupos2+i
	
	#Combertimos el string con blancos en una lista
	g=grupos2.split()
	
	#Para cada miembro de la lista vemos si existe, si no existe cambiamos el valor de NoExist a "0" y add el grupo a las lista 
	#Para saber que grupos no existen.
	for i in g[0:]:
		try:
			if grp.getgrnam(i) != "":
				NoExist=1
		except KeyError:
			NoExist=0
			lista=lista+i+" "
	return [NoExist,lista]

#Comprobamos si existe el UID, si existe return 1, si no return 0
def ComprobarUid(uid):
	try:
		if pwd.getpwuid(uid).pw_name != "":
			return 1
	except KeyError:
		return 0


#Comprobamos si existe el grupo dando el GUID como integer
def ComprobarGuid(guid):
	try:
		#Si el grupo SI existe, return 1
		if grp.getgrgid(guid) != "":
			return 1
	#Si el grupo NO existe, return 0
	except KeyError,ValueError:
		return 0


def getsalt(chars = os.times() + os.uname()):
	#Genera 2 caracteres para el SALT, tomando aleatorios de la concatenacion de times+uname
	return str(random.choice(chars)) + str(random.choice(chars))


if __name__ == '__main__':
	#Si NO es un Linux/Unix, salimos de la ejecucion....
	if os.name != "posix":
		sys.stderr.write("Este script solo es valido para entornos Unix.\n")
		sys.stderr.close()
		sys.exit(1)
	else:
		#Si SI es un Linux/Unix y el proceso NO lo lanza root uid=0, salimos de la ejecucion
		if os.geteuid() != 0:
			sys.stderr.write("Necesitas permisos de Root.\n");
			sys.stderr.close()
			sys.exit(1)
		else:
			#Creamos el usuario.
			creacion()