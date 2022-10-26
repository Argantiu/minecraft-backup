#!/bin/bash
# Here are the System variables don't edit them here. You can use the mcsys.yml ;)
# Automatic minecraft server script - Edit at your own risks!!
# Version 3.0.0.0-#0 created by CrazyCloudCraft https://crazycloudcraft.de

# Here is a setting for developers if, they create a own fork user/repo
IFCREATEDFORK=Argantiu/minecraft-manager
# Software
VARSOFT=$(cat < mcsys.yml | grep "software:" | cut -d ':' -f2 | tr -d " ")
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
# Server Directory
#=$(cat mcsys.yml | grep "software:" | rev | cut -d '/' -f1 | rev )
MTPATH=$(cat < mcsys.yml | grep "server.directory:" | cut -d ':' -f2 | tr -d " ")
SERVERBASE=$(cat < mcsys.yml | grep "server.directory:" | rev | cut -d '/' -f1 | rev )
OPTBASE=$(cat < mcsys.yml | grep "server.directory:" | tr -d " " | cut -d ':' -f2 | sed s/$SERVERBASE//m)
# Version
MAINVERSION=$(cat < mcsys.yml | grep systemname: | cut -d ':' -f2)
# Systemname
MCNAME=$(cat < mcsys.yml | grep systemname: | cut -d ':' -f2)
# Ram 
RAM=$(cat < mcsys.yml | grep ram: | cut -d ':' -d 'B' -f2)
# Java
JAVABIN=$(cat < mcsys.yml | grep java: | cut -d ':' -f2)
# Proxy Mode
PROXYMO=$(cat < mcsys.yml | grep proxy.mode: | cut -d ':' -f2)
# Couter
MCOUNT=$(cat < mcsys.yml | grep dynamic.counter: | cut -d ':' -f2)
# Backups
BACKUP=
# Prime Backups

## Variablen möglich machen, dass man farben verwenden kann ( "§a §9" etc.) 
MLANG=./messages.lang
TR1=$(cat < $MLANG | grep startsh.already.online: | cut -d ':' -d ' ' -f2)


dynamic.counter: true
backups: false
primebackups: false
bedrock: false
sys.prefix: §8[§aArgantiu§8]




BEUPDATE=$(cat < mcsys.yml | grep BEMCUPDATE= | cut -d ':' -d ' ' -f2)
BACKUP=$(cat < mcsys.yml | grep BACKUP= | cut -d ':' -d ' ' -f2)
BETTERBACKUP=$(cat < mcsys.yml | grep BETTERBACKUP= | cut -d ':' -d ' ' -f2)
MPREFIX=$(cat < mcsys.yml | grep MPREFIX= | cut -d ':' -d ' ' -f2)
MCNAME=$(cat < mcsys.yml | grep MCNAME= | cut -d ':' -d ' ' -f2)


# manage.tool
SERVERNAME=$(cat < mcsys.yml | grep systemname: | cut -d ':' -f2)
