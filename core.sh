#!/bin/sh

# =====================
#   GUARDIÁN - CORE
# =====================

# --- COLORES ---
YELLOW="\033[1;33m"
RED="\033[1;31m"
GREEN="\033[1;32m"
BLUE="\033[1;34m"
RESET="\033[0m"

ok()    { echo "${GREEN}[OK]${RESET} $1"; }
err()   { echo "${RED}[ERROR]${RESET} $1"; }
info()  { echo "${BLUE}[INFO]${RESET} $1"; }
warn()  { echo "${YELLOW}[WARN]${RESET} $1"; }

info "GUARDIÁN CORE cargado correctamente."
