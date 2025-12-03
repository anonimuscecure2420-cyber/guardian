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

HEADERS=$(curl -skI "$TARGET")

# --- CHEQUEOS ---
echo "$HEADERS" | grep -qi "strict-transport-security" && ok "HSTS habilitado" || warn "HSTS no habilitado"
echo "$HEADERS" | grep -qi "content-security-policy" && ok "CSP habilitado" || warn "CSP no habilitado"
echo "$HEADERS" | grep -qi "x-frame-options" && ok "X-Frame-Options habilitado" || warn "X-Frame-Options no habilitado"
echo "$HEADERS" | grep -qi "x-content-type-options" && ok "X-Content-Type-Options habilitado" || warn "X-Content-Type-Options no habilitado"
echo "$HEADERS" | grep -qi "referrer-policy" && ok "Referrer-Policy habilitada" || warn "Referrer-Policy NO habilitada"

ok "AnC!lisis terminado."
