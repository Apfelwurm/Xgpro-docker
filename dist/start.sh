#!/bin/bash
if which udevadm >/dev/null; then
    echo "Restarting UDEV Service to enable hotpluging"
    set +e # Disable exit on error
    service udev restart
    set -e # Re-enable exit on error
    echo "UDEV Service restarted"
fi

if [ "$ROOT" = 'FALSE' ]; then
    su -s /bin/bash -c "wine /app/xgpro/Xgpro.exe" -g plugdev xgpro
fi
if [ "$ROOT" = 'TRUE' ]; then
    wine /app/xgpro/Xgpro.exe
fi