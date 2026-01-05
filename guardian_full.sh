#!/bin/sh

CAMERA_FILE="$HOME/guardian/config/camera_ips.txt"
SCAN_DIR="$HOME/guardian/scans"
DATE=$(date +%Y-%m-%d_%H-%M)

mkdir -p "$SCAN_DIR/$DATE"

while read IP; do
    echo "Escaneando $IP..."
    curl -v http://$IP > "$SCAN_DIR/$DATE/${IP}_http.txt" 2>&1
    curl -v rtsp://$IP:554 > "$SCAN_DIR/$DATE/${IP}_rtsp.txt" 2>&1
    if [ $? -eq 0 ]; then
        echo "$IP OK" >> "$SCAN_DIR/$DATE/summary.txt"
    else
        echo "$IP FALLC" >> "$SCAN_DIR/$DATE/summary.txt"
    fi
done < "$CAMERA_FILE"

echo "Escaneo terminado. Resultados en $SCAN_DIR/$DATE"
