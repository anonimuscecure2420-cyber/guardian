#!/bin/sh

LOG=guardian.log
IP="192.168.153.1"
FILE="/tmp/archivo_vigilado.txt"
touch $FILE
CHECKSUM=$(md5sum $FILE | awk '{print $1}')

# FunciC3n monitoreo de archivo
monitorear_archivo() {
    NEW=$(md5sum $FILE | awk '{print $1}')
    if [ "$NEW" != "$CHECKSUM" ]; then
        echo "[ALERTA] Archivo modificado!" | tee -a $LOG
        CHECKSUM=$NEW
    fi
}

# FunciC3n simulador de cC!mara
camara() {
    ZONAS="entrada pasillo sala"
    for ZONA in $ZONAS; do
        echo "[CAMARA] DetectC) movimiento en: $ZONA"
        break  # solo una zona aleatoria cada vez
    done
}

# FunciC3n vigilancia de red
red() {
    ping -c1 -W1 $IP >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "[RED] No hay conexiC3n con $IP" | tee -a $LOG
    else
        echo "[RED] Conectado correctamente a $IP"
    fi
}

# Bucle principal
while true; do
    monitorear_archivo
    camara
    red
    sleep 3
done
