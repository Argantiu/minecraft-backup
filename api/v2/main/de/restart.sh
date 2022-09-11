#!/bin/bash
# Automatisches Minecraft Server Script - Bearbeiten auf eigene Gefahr!!
# Version 3.0.0.0-#0 erstellt von Argantiu GmBh 08.08.2022 https://crazycloudcraft.de
MCNAME=$(cat ./configs/mcsys.config | grep MCNAME= | cut -d '=' -f2)
MTPATH=$(cat ./configs/mcsys.config | grep MTPATH= | cut -d '=' -f2)
MPREFIX=$(cat ./configs/mcsys.config | grep MPREFIX= | cut -d '=' -f2)
# Checkt, ob der Server offline ist, damit er nur gestartet wird.
if ! screen -list | grep -q "$MCNAME"; then
    echo -e "$MPREFIX Der Server läuft nicht. Starte Server."
    # Starte Server
    /bin/bash $LPATH/mcsys/start.sh
    exit 0
fi
# Stoppe Server
/bin/bash $MTPATH/mcsys/stop.sh
# Starte Server
/bin/bash $MTPATH/mcsys/start.sh
