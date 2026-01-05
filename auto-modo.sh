#!/bin/bash
# GUARDIAN - AUTO MODO
# Detecta red y activa modo casa o modo trabajo

CASA_GATEWAY="192.168.0.1"
TRABAJO_PREFIX="192.168.153"

LOG_DIR="$HOME/guardian/historial"
mkdir -p "$LOG_DIR"

modo_casa() {
    echo "[GUARDIAN] Modo CASA detectado"
    echo "[INFO] Vigilancia activada (red + dispositivos)"
    while true; do
        date >> $LOG_DIR/casa.log
        echo "Escaneo rC!pido..." >> $LOG_DIR/casa.log
        ping -c1 -W1 192.168.0.14 >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "[ALERTA] TV desconectada" >> $LOG_DIR/casa.log
        else
            echo "[OK] TV activa" >> $LOG_DIR/casa.log
        fi
        sleep 5
    done
}

modo_trabajo() {
    echo "[GUARDIAN] Modo TRABAJO detectado"
    echo "[INFO] Funciones disponibles: escaneo y anC!lisis"
    echo "Comando C:til: guardian-scan"
}

IP=$(ip route get 8.8.8.8 2>/dev/null | grep src | awk '{print $7}')

echo "[GUARDIAN] Detectando red actual..."
echo "Tu IP actual es: $IP"

if [[ "$IP" == 192.168.0.* ]]; then
    modo_casa
elif [[ "$IP" == $TRABAJO_PREFIX* ]]; then
    modo_trabajo
else
    echo "[GUARDIAN] Red desconocida: modo SOLO ESCANEO"
fi
