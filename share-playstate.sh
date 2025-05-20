#!/bin/sh

set -e -o pipefail

MOUNT_SOURCE="/home/root/webos-share-playstate/interfaces"
MOUNT_TARGET="/usr/palm/services/com.webos.service.secondscreen.gateway/interfaces"
NEW_FILE="com.webos.media.interface"

if [[ ! -d "$MOUNT_SOURCE" ]]; then
    echo "[-] Source folder does not exist: $MOUNT_SOURCE" >&2
    exit 1
fi

if [[ ! -d "$MOUNT_TARGET" ]]; then
    echo "[-] Target folder does not exist: $MOUNT_TARGET" >&2
    exit 1
fi

if findmnt -- "$MOUNT_TARGET"; then
    echo "[~] Enabled already" >&2
    exit 0
fi

if [[ -f "$MOUNT_TARGET/$NEW_FILE" ]]; then
    echo "[-] Target file already exists: $MOUNT_TARGET/$NEW_FILE" >&2
    exit 1
fi

mount -t overlay -o "ro,lowerdir=$MOUNT_SOURCE:$MOUNT_TARGET" -- overlay "$MOUNT_TARGET"
echo "[+] Enabled succesfully" >&2

. "$(dirname "$(realpath "$0")")/stop-unified-service-server.sh"
