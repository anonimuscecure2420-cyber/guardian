#!/bin/sh
#
# GUARDIAN - CORE
# Analizador sencillo de cabeceras HTTP
#

# --- COLORES ---
GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RESET="\033[0m"

ok()   { echo "${GREEN}[OK]${RESET} $1"; }
err()  { echo "${RED}[ERROR]${RESET} $1"; }
info() { echo "${BLUE}[INFO]${RESET} $1"; }
warn() { echo "${YELLOW}[WARN]${RESET} $1"; }

# --- VALIDACICN ---
if [ -z "$1" ]; then
    err "Uso: $0 http://IP_O_DOMINIO"
    exit 1
fi

TARGET="$1"

info "Analizando cabeceras de seguridad para $TARGET ..."

#!/bin/bash
# GUARDIAN - AUTO MODO
# Detecta red y activa modo casa o modo trabajo

CASA_GATEWAY="192.168.0.1"
TRABAJO_PREFIX="192.168.153"

LOG_DIR="$HOME/guardian/historial"
mkdir -p "$LOG_DIR"

# ----------------------------
# FUNCIONES
# ----------------------------

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

# ----------------------------
# DETECTOR DE RED
# ----------------------------

IP=$(ip route get 8.8.8.8 2>/dev/null | grep src | awk '{print $7}')

echo "[GUARDIAN] Detectando red actual..."
echo "Tu IP actual es: $IP"

# Si estC! en casa
if [[ "$IP" == 192.168.0.* ]]; then
    modo_casa
# Si estC! en trabajo
elif [[ "$IP" == $TRABAJO_PREFIX* ]]; then
    modo_trabajo
else
    echo "[GUARDIAN] Red desconocida: modo SOLO ESCANEO"
fi
