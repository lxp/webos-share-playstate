#!/bin/sh

set -e -o pipefail

# Stop ss.gateway if it was already started.
# ss.gateway is running within the unified-service-server node.js process.
# Since multiple services are running within this process, the process name changes over time and matches the last service that was started.
# Therefore, we look for the parent shell script that starts the unified-service-server and kill all children.
# The unified-service-server should be started automatically again, once a required service will be used.

PPIDS="$(pgrep -fx -- "/bin/sh /usr/bin/run-unified-service-server" || true | paste -sd',')"
if [ -z "$PPIDS" ]; then
    echo "[~] unified-service-server not running" >&2
    exit 0
fi

PIDS="$(pgrep -P "$PPIDS" || true | xargs echo)"
if [ -z "$PIDS" ]; then
    echo "[~] unified-service-server has no children" >&2
    exit 0
fi

echo "[+] Stopping unified-service-server since it is already running" >&2
kill -- "$PIDS"
