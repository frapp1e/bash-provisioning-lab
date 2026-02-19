#!/bin/bash

LOGFILE="provision.log"
#funcion llamada log donde se hara un append con tee para que no sustituya el texto y escribira la fecha y el argumento que le pasemos a la funcion
log(){
    echo "$(date) - $1" | tee -a $LOGFILE
}

#Explicacion de la condicion: EL usuario ROOT tiene ID 0, si es distinte de 0 (-ne) entonces deberas ejecutar como root.
if [ "$EUID" -ne 0 ]; then    #EUID= Effective User ID
        log "Ejecuta como root"
        exit 1 #indica error
fi

USUARIO=$1 #Guarda el primer argumento a la hora de ejecutar el script, ejemplo sudo ./provision.sh fran, entonces esta variable de usuario sera USUARIO=fran

#Explicacion de la condicion: Si el usuario esta vacio, se muestra por pantalla como debes ejecutar el script
if [ -z "$USUARIO" ]; then #-z significa si esta vacio
        log "Uso: $0 nombre_usuario"
        exit 1 #indica error
fi

if id "$USUARIO" &>/dev/null; then
        log "El usuario $USUARIO ya existe"
else
        log "Creando usuario $USUARIO"
        useradd -m $USUARIO
fi

log "Instalando nginx..."
apt update &>>$LOGFILE
apt install nginx -y &>>$LOGFILE

log "Habilitando servicio..."
systemctl enable nginx &>>$LOGFILE
systemctl start nginx &>>$LOGFILE

#Comprueba si nginx esta instalado o no
echo "comprobando estado de nginx..."
if systemctl is-active --quiet nginx; then
        log "Nginx esta funcionando correctamente"
else
        log "Error: nginx no esta activo"
        exit 1
fi

echo "Provisionamiento completado correctamente"

