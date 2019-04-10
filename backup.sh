#!/bin/bash

echo "Ingresa el correo electronico al cual sera enviado:"
read email

backup_path="/home/edgarmorales/backup_db"
fecha=$(date + "%d-%b-%Y")

umask 177

mysqldump -u root servidores > backup_path/backup_servidores-$date.sql

xz -9 $backup_path/backup_servidores-$date.sql

mail -s "Backup BD servidores." $email

