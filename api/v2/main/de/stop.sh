#!/bin/bash
# Automatisches Minecraft Server Script - Bearbeiten auf eigene Gefahr!!
# Version 3.0.0.0-#0 erstellt von Argantiu GmBh 08.08.2022 https://crazycloudcraft.de
MCNAME=
SERVERBASE=
ASOFTWARE=
MCOUNT=
MPREFIX=
#
if ! screen -list | grep -q "$MCNAME"; then
  echo -e "$MPREFIX Der Server wurde schon gestoppt!"
  exit 1
fi

# Stop the server
echo -e "$MPREFIX Notification: Stppe $DISPLAYNAME Server ..."
echo "[Argantiu] Notification: Stppe $DISPLAYNAME Server ..." | /usr/bin/logger -t $MCNAME
# Start countdown notice on server
if [[ $ASOFTWARE == "PAPER" ]] || [[ $ASOFTWARE == "SPIGOT" ]] || [[ $ASOFTWARE == "BUKKIT" ]] || [[ $ASOFTWARE == "PURPUR" ]] || [[ $ASOFTWARE == "MOHIST" ]] && [[ $MCOUNT == "TRUE" ]] || [[ $MCOUNT == "true" ]] ; then
 screen -Rd $MCNAME -X stuff "say Server stoppt in 10 $DISPLAYTRANZTIME ! $(printf '\r')"
 sleep 6s
 screen -Rd $MCNAME -X stuff "say Server stoppt in 4 $DISPLAYTRANZTIME ! $(printf '\r')"
 sleep 1s
 screen -Rd $MCNAME -X stuff "say Server stoppt in 3 $DISPLAYTRANZTIME ! $(printf '\r')"
 sleep 1s
 screen -Rd $MCNAME -X stuff "say Server stoppt in 2 $DISPLAYTRANZTIME ! $(printf '\r')"
 sleep 1s
 screen -Rd $MCNAME -X stuff "say Server stoppt in 1 $DISPLAYTRANZTIME ! $(printf '\r')"
 sleep 1s
fi
screen -Rd $MCNAME -X stuff "say Server stoppt.$(printf '\r')"
echo "Schalte Minecraft Server aus..." | /usr/bin/logger -t $MCNAME

# Wait up to 20 seconds for server to close
StopChecks=0
while [ $StopChecks -lt 30 ]; do
  if ! screen -list | grep -q "$MCNAME"; then
    break
  fi
  sleep 1;
  StopChecks=$((StopChecks+1))
done

# Force quit if server is still open
if screen -list | grep -q "$MCNAME"; then
  echo -e "$MPREFIX $SERVERBASE Server hat nach 30 sekunden nicht reagiert, Minecraft Server wird abgewürgt."  | /usr/bin/logger -t $MCNAME
  screen -S $MCNAME -X quit
  pkill -15 -f "SCREEN -dmSL $MCNAME"
fi

echo -e "$MPREFIX Minecraft $SERVERBASE gestoppt."
echo -e "Minecraft Server $SERVERBASE stoppt." | /usr/bin/logger -t $MCNAME
