#!/bin/bash

CAMERA_FILE=~/guardian/config/camera_ips.txt
SCAN_DIR=~/guardian/scans
DATE=$(date +%Y-%m-%d_%H-%M)

mkdir -p $SCAN_DIR/$DATE

while read IP; do
    echo "Escaneando $IP..."
    curl -I http://$IP > $SCAN_DIR/$DATE/${IP}_http.txt 2>&1
    curl -v rtsp://$IP:554 > $SCAN_DIR/$DATE/${IP}_rtsp.txt 2>&1
done < $CAMERA_FILE

echo "Guardado en $SCAN_DIR/$DATE"
