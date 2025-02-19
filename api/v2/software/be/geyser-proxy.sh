#!/bin/bash
# Minecraft Server auto stop script - Do not configure this script!!
# Version 3.0.0.0-#0 made by CrazyCloudCraft https://crazycloudcraft.de
CONYAM=./configs/mcsys.yml
VARSOFT=$(cat < $CONYAM | grep "software:" | cut -d ':' -f2 | tr -d " ")
if [[ $VARSOFT == "VELOCITY" ]] || [[ $VARSOFT == "velo" ]] || [[ $VARSOFT == "velocity" ]]; then ASOFTWARE=proxy/velocity.sh
fi
MTPATH=$(cat < $CONYAM | grep "server-directory:" | cut -d ':' -f2 | tr -d " ")
MCNAME=$(cat < $CONYAM | grep "systemname:" | cut -d ':' -f2)
# Floodgate
mkdir -p "$MTPATH"/mcsys/saves/floodgate
cd "$MTPATH"/mcsys/saves/floodgate || exit 1
if [ ! "$ASOFTWARE" = "proxy/velocity.sh" ]; then
 if [ ! -f "$MTPATH"/plugins/floodgate-bungee.jar ]; then touch "$MTPATH"/plugins/floodgate-bungee.jar
 fi
 wget -q https://ci.opencollab.dev/job/GeyserMC/job/Floodgate/job/master/lastSuccessfulBuild/artifact/bungee/target/floodgate-bungee.jar -O floodgate-bungee.jar
 unzip -qq -t floodgate-bungee.jar
 if ! unzip -qq -t floodgate-bungee.jar; then #if [ "$?" -ne 0 ]; then
  echo "Downloaded floodgate for Bungeecord and Waterfall is corrupt. No update." | /usr/bin/logger -t "$MCNAME"
 else
  diff -q floodgate-bungee.jar "$MTPATH"/plugins/floodgate-bungee.jar >/dev/null 2>&1
  if [ "$?" -eq 1 ]; then
   cp floodgate-bungee.jar floodgate-bungee.jar."$(date +%Y.%m.%d.%H.%M.%S)"
   mv floodgate-bungee.jar "$MTPATH"/plugins/floodgate-bungee.jar
   /usr/bin/find "$LPATH"/mcsys/saves/floodgate/* -type f -mtime +5 -delete 2>&1 | /usr/bin/logger -t "$MCNAME"
   echo "floodgate for Bungeecord and Waterfall has been updated" | /usr/bin/logger -t "$MCNAME"
  else
   echo "No floodgate bungee update neccessary" | /usr/bin/logger -t "$MCNAME"
   rm floodgate-bungee.jar
  fi
 fi
fi
# Velocity part
if [[ $ASOFTWARE == "proxy/velocity.sh" ]]; then
 if [ ! -f "$MTPATH"/plugins/floodgate-velocity.jar ]; then touch "$MTPATH"/plugins/floodgate-velocity.jar
 fi
 wget -q https://ci.opencollab.dev/job/GeyserMC/job/Floodgate/job/master/lastSuccessfulBuild/artifact/velocity/target/floodgate-velocity.jar -O floodgate-velocity.jar
 unzip -qq -t floodgate-velocity.jar
 if ! unzip -qq -t floodgate-velocity.jar; then #if [ "$?" -ne 0 ]; then
  echo "Downloaded floodgate for velocity is corrupt. No update." | /usr/bin/logger -t "$MCNAME"
 else
  diff -q floodgate-velocity.jar "$MTPATH"/plugins/floodgate-velocity.jar >/dev/null 2>&1
  if [ "$?" -eq 1 ]; then
   cp floodgate-velocity.jar floodgate-velocity.jar."$(date +%Y.%m.%d.%H.%M.%S)"
   mv floodgate-velocity.jar "$MTPATH"/plugins/floodgate-velocity.jar
   /usr/bin/find "$MTPATH"/mcsys/saves/floodgate/* -type f -mtime +5 -delete 2>&1 | /usr/bin/logger -t "$MCNAME"
   echo "floodgate for velocity has been updated" | /usr/bin/logger -t "$MCNAME"
  else
   echo "No floodgate velocity update neccessary" | /usr/bin/logger -t "$MCNAME"
   rm floodgate-velocity.jar
  fi
 fi
fi

# Geyser for Proxy
mkdir -p "$MTPATH"/mcsys/geyser
cd "$MTPATH"/mcsys/geyser || exit 1
if [ ! "$ASOFTWARE" = "proxy/velocity.sh" ]; then
 if [ ! -f "$MTPATH"/plugins/Geyser-BungeeCord.jar ]; then touch "$MTPATH"/plugins/Geyser-BungeeCord.jar
 fi
 wget -q https://ci.opencollab.dev/job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/bungeecord/target/Geyser-BungeeCord.jar -O Geyser-BungeeCord.jar
 unzip -qq -t Geyser-BungeeCord.jar
 if ! unzip -qq -t Geyser-BungeeCord.jar; then #if [ "$?" -ne 0 ]; then
  echo "Downloaded Geyser Bungeecord and Waterfall is corrupt. No update." | /usr/bin/logger -t "$MCNAME"
 else
  diff -q Geyser-BungeeCord.jar "$MTPATH"/plugins/Geyser-BungeeCord.jar >/dev/null 2>&1
  if [ "$?" -eq 1 ]; then
  cp Geyser-BungeeCord.jar Geyser-BungeeCord.jar."$(date +%Y.%m.%d.%H.%M.%S)"
  mv Geyser-BungeeCord.jar "$MTPATH"/plugins/Geyser-BungeeCord.jar
  /usr/bin/find "$MTPATH"/mcsys/saves/geyser/* -type f -mtime +5 -delete 2>&1 | /usr/bin/logger -t "$MCNAME"
   echo "Geyser for Bungeecord and Waterfall has been updated" | /usr/bin/logger -t "$MCNAME"
  else
   echo "No Geyser-BungeeCord.jar update neccessary" | /usr/bin/logger -t "$MCNAME"
   rm Geyser-BungeeCord.jar
  fi
 fi
fi
# Velocity part
if [[ $ASOFTWARE == "proxy/velocity.sh" ]]; then
 if [ ! -f "$MTPATH"/plugins/Geyser-Velocity.jar ]; then touch "$MTPATH"/plugins/Geyser-Velocity.jar
 fi
 wget -q https://ci.opencollab.dev/job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/velocity/target/Geyser-Velocity.jar -O Geyser-Velocity.jar
 unzip -qq -t Geyser-Velocity.jar
 if ! unzip -qq -t Geyser-Velocity.jar; then #if [ "$?" -ne 0 ]; then
  echo "Downloaded Geyser-Velocity is corrupt. No update." | /usr/bin/logger -t "$MCNAME"
 else
  diff -q Geyser-Velocity.jar "$MTPATH"/plugins/Geyser-Velocity.jar >/dev/null 2>&1
  if [ "$?" -eq 1 ]; then
  cp Geyser-Velocity.jar Geyser-Velocity.jar."$(date +%Y.%m.%d.%H.%M.%S)"
  mv Geyser-Velocity.jar "$MTPATH"/plugins/Geyser-Velocity.jar
  /usr/bin/find "$MTPATH"/mcsys/saves/geyser/* -type f -mtime +5 -delete 2>&1 | /usr/bin/logger -t "$MCNAME"
   echo "Geyser for Velocity has been updated" | /usr/bin/logger -t "$MCNAME"
  else
   echo "No Geyser-Velocity.jar update neccessary" | /usr/bin/logger -t "$MCNAME"
   rm Geyser-Velocity.jar
  fi
 fi
fi
exit 0
