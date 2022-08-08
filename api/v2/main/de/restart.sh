#!/bin/bash
# Automatisches Minecraft Server Script - Bearbeiten auf eigene Gefahr!!
# Version 3.0.0.0-#0 erstellt von Argantiu GmBh 08.08.2022 https://crazycloudcraft.de
MCNAME=
MTPATH=
MPREFIX=
MTRANZLATION=
# Checkt, ob der Server offline ist, damit er nur gestartet wird.
if ! screen -list | grep -q "$MCNAME"; then
    echo -e "$MPREFIX $MTRANZLATION"
    # Starte Server
    /bin/bash $LPATH/mcsys/start.sh
    exit 0
fi
# Stoppe Server
/bin/bash $MTPATH/mcsys/stop.sh
# Starte Server
/bin/bash $MTPATH/mcsys/start.sh
