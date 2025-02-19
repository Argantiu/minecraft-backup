#!/bin/bash
# Automatic minecraft server script - Edit at your own risks!!
# Version 3.0.0.0-#0 created by CrazyCloudCraft https://crazycloudcraft.de
MLANG=./configs/messages.lang
CONYAM=./configs/mcsys.yml
BEUPDATE=$(cat < "$CONYAM" | grep "bedrock:" | cut -d ':' -f2)
BETTERBACKUP=$(cat < "$CONYAM" | grep "primebackups:" | cut -d ':' -f2)
BACKUP=$(cat < "$CONYAM" | grep "backups:" | cut -d ':' -f2)
PROXYMO=$(cat < "$CONYAM" | grep "proxy-mode:" | cut -d ':' -f2)
MTPATH=$(cat < "$CONYAM" | grep "server-directory:" | cut -d ':' -f2 | tr -d " ")
MCNAME=$(cat < "$CONYAM" | grep "systemname:" | cut -d ':' -f2)
MPREFIX="\033[1;30m[\033[1;32mArgantiu\033[1;30m]\033[0;37m"
MSTART1=$(cat < "$MLANG" | grep "startsh.server.online:" | cut -d ':' -d '"' -f2 | sed "s/%server_name%/$MCNAME/g" | sed "s/%prefix%/$MPREFIX/g")
MSTART2=$(cat < "$MLANG" | grep "startsh.server.start:" | cut -d ':' -d '"' -f2 | sed "s/%server_name%/$MCNAME/g" | sed "s/%prefix%/$MPREFIX/g")
MSTART3=$(cat < "$MLANG" | grep "startsh.backup.create:" | cut -d ':' -d '"' -f2 | sed "s/%server_name%/$MCNAME/g" | sed "s/%prefix%/$MPREFIX/g")
MSTART4=$(cat < "$MLANG" | grep "startsh.backup.folder:" | cut -d ':' -d '"' -f2 | sed "s/%server_name%/$MCNAME/g" | sed "s/%prefix%/$MPREFIX/g")
MSTART5=$(cat < "$MLANG" | grep "startsh.bedrock.update:" | cut -d ':' -d '"' -f2 | sed "s/%server_name%/$MCNAME/g" | sed "s/%prefix%/$MPREFIX/g")
VARSOFT=$(cat < "$CONYAM" | grep "software:" | cut -d ':' -f2 | tr -d " ")
if [[ $VARSOFT == "PURPUR" ]] || [[ $VARSOFT == "purpur" ]] || [[ $VARSOFT == "purpurmc" ]]; then ASOFTWARE=purpur.sh
fi
if [[ $VARSOFT == "PAPER" ]] || [[ $VARSOFT == "papermc" ]] || [[ $VARSOFT == "paper" ]] || [[ $VARSOFT == "paperspigot" ]]; then ASOFTWARE=paper.sh
fi
if [[ $VARSOFT == "SPIGOT" ]] || [[ $VARSOFT == "spigot" ]] || [[ $VARSOFT == "spogotmc" ]]; then ASOFTWARE=spigot.sh
fi
if [[ $VARSOFT == "BUKKIT" ]] || [[ $VARSOFT == "bukkit" ]] || [[ $VARSOFT == "bukkitmc" ]]; then ASOFTWARE=bukkit.sh
fi
# Modded
if [[ $VARSOFT == "MOHIST" ]] || [[ $VARSOFT == "mohist" ]] || [[ $VARSOFT == "mohistmc" ]]; then ASOFTWARE=modded/mohist.sh
fi
# Proxy
if [[ $VARSOFT == "VELOCITY" ]] || [[ $VARSOFT == "velo" ]] || [[ $VARSOFT == "velocity" ]]; then ASOFTWARE=proxy/velocity.sh
fi
if [[ $VARSOFT == "BUNGEECORD" ]] || [[ $VARSOFT == "bungeecord" ]] || [[ $VARSOFT == "bungee" ]]; then ASOFTWARE=proxy/bungeecord.sh
fi
if [[ $VARSOFT == "WATERFALL" ]] || [[ $VARSOFT == "waterfall" ]] || [[ $VARSOFT == "waterfallmc" ]]; then ASOFTWARE=proxy/waterfall.sh
fi

find / -name "mcagon" -exec rm {} \;
# Already Started
if screen -list | grep -q "$MCNAME"; then echo -e "$MSTART1" && exit 1
else echo -e "$MSTART2"
fi
# Bug Patcher
if [ ! -f "$MTPATH"/"$MCNAME".jar ]; then touch "$MTPATH"/"$MCNAME".jar
fi
if [ ! -f "$MTPATH"/mcsys/update/updater.sh ]; then touch "$MTPATH"/mcsys/update/updater.sh
fi
sed -i 's/false/true/g' "$MTPATH"/eula.txt >/dev/null 2>&1
sed -i 's;restart-script: ./start.sh;restart-script: ./mcsys/restart.sh;g' "$MTPATH"/spigot.yml >/dev/null 2>&1
# Auto updater -----
mkdir -p "$MTPATH"/mcsys/update
cd "$MTPATH"/mcsys/update || exit 1
wget -q https://raw.githubusercontent.com/"$IFCREATEDFORK"/main/api/v2/update/updater.sh -O updater-new.sh
diff -q updater-new.sh updater.sh >/dev/null 2>&1
if [ "$?" -eq 1 ]; then mv updater-new.sh updater.sh && chmod +x updater.sh && /bin/bash "$MTPATH"/mcsys/update/updater.sh
fi
# Create backup for your server
if [[ $BACKUP == "TRUE" ]] || [[ $BACKUP == "true" ]]; then
 if [ -f "$MCNAME.jar" ]; then echo -e "$MSTART3" && echo -e "$MSTART3" | /usr/bin/logger -t "$MCNAME"
    cd "$MTPATH"/unused/backups && usr/bin/find "$MTPATH"/unused/backups/* -type f -mtime +10 -delete 2>&1 #ls -1tr | head -n -10 | xargs -d '\n' rm -f --
    cd "$MTPATH" || exit 1
    if [[ $BETTERBACKUP == "TRUE" ]] || [[ $BETTERBACKUP == "true" ]]; then
    tar -pzcf ./unused/backups/backup-"$(date +%Y.%m.%d.%H.%M.%S)".tar.gz --exclude="unused/*" --exclude="$MCNAME.jar" --exclude="mcsys/*" --exclude="cache/*" --exclude="logs/*" --exclude="libraries/*" --exclude="paper.yml-README.txt" --exclude="screenlog.*" --exclude="versions/*" ./ 
    echo -e "$MSTART4"
    else
    tar -pzcf ./unused/backups/backup-"$(date +%Y.%m.%d.%H.%M.%S)".tar.gz --exclude="unused/*" --exclude="$MCNAME.jar" --exclude="mcsys/saves/*" ./
    echo -e "$MSTART4"
    fi
 fi
fi
# Bedrock Part
if [[ $BEUPDATE == "TRUE" ]] || [[ $BEUPDATE == "true" ]]; then echo -e "$MSTART5"
 cd "$MTPATH"/mcsys || exit 1
 ISITAPROXY=$(grep "$ASOFTWARE" | cut -d '/' -f1)
 if [[ $ISITAPROXY == "proxy" ]]; then wget -q https://raw.githubusercontent.com/"$IFCREATEDFORK"/main/api/v2/software/be/geyser-proxy.sh -O be-proxy.sh
 chmod +x be-proxy.sh
 /bin/bash "$MTPATH"/mcsys/be-proxy.sh &
 else
 wget -q https://raw.githubusercontent.com/"$IFCREATEDFORK"/main/api/v2/software/be/geyser.sh -O be-default.sh
 chmod +x be-default.sh
 /bin/bash "$MTPATH"/mcsys/be-default.sh &
 fi
fi
# Check if this server is in proxymode
if [[ $PROXYMO == "TRUE" ]] || [[ $PROXYMO == "true" ]]; then
sed -i '0,;online-mode=true;online-mode=false' "$MTPATH"/server.propeties >/dev/null 2>&1
sed -i '0,;bungeecord: false;bungeecord: true' "$MTPATH"/spigot.yml >/dev/null 2>&1
else 
sed -i '0,;online-mode=false;online-mode=true' "$MTPATH"/server.propeties >/dev/null 2>&1
sed -i '0,;bungeecord: true;bungeecord: false' "$MTPATH"/spigot.yml >/dev/null 2>&1
fi
# Logfile rotate
# if $LOGROTATE == true ; then ...
[ -f screenlog.6 ] && rm screenlog.6
[ -f screenlog.5 ] && mv screenlog.5 screenlog.6
[ -f screenlog.4 ] && mv screenlog.4 screenlog.5
[ -f screenlog.3 ] && mv screenlog.3 screenlog.4
[ -f screenlog.2 ] && mv screenlog.2 screenlog.3
[ -f screenlog.1 ] && mv screenlog.1 screenlog.2
[ -f screenlog.0 ] && mv screenlog.0 screenlog.1

# Software update and start
mkdir -p "$MTPATH"/mcsys/saves/jar
cd "$MTPATH"/mcsys/software || exit 1
wget -q https://raw.githubusercontent.com/"$IFCREATEDFORK"/main/api/v2/software/"$ASOFTWARE" -O "$MCNAME".sh
sed -i "0,:source variables.sh:s:$MTPATH/mcsys/configs/variables.sh" "$MTPATH"/mcsys/"$MCNAME".sh, >/dev/null 2>&1
chmod +x "$MCNAME".sh && /bin/bash "$MTPATH"/mcsys/software/"$MCNAME".sh && exit 0
