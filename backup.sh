#!/bin/bash

 user="root"
 db="servidores"
 host="localhost"

 backup_path="/home/edgarmorales/backup_db"

 maximum_backup_folders=3

 date=$(date +"%Y-%m-%d_-_%H-%M-%S")
 mkdir $backup_path/$date


 mysqldump --user=$user --host=$host $db | gzip -9 > "$backup_path/$date/$db.sql.gz"
 
 echo "Escribe tu correo:"
 read email

 zcat $backup_path/$date/$db.sql.gz | less | mutt -s "Copia de seguridad DB Servidores" $email
