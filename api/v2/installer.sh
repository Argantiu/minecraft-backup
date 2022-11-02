#!/bin/bash
# Minecraft Server installer for an Easy Setup
# Made By CrazyCloudCraft
IFCREATEDFORK=Argantiu/minecraft-manager
PREFIX="\033[1;30m[\033[1;32mArgantiu\033[1;30m]\033[0;37m"
# Which language do you speak. 1 English . 2 German 3 French ...
echo -e "\033[1;32m_______"
echo -e "$PREFIX Welcome to Argantiu's server management tool"
echo -e "$PREFIX You can leave with STRG+C"
echo -e "$PREFIX _______"
echo -e "$PREFIX First, please select your language:"
echo -e "$PREFIX 1 = English (English)"
echo -e "$PREFIX 2 = Deutsch (German)"
{
echo -n -e "$PREFIX Please type a number and hit enter:";
echo -n -e " "
read -r LANG;
}
case $LANG in
1)
 echo -e "$PREFIX Where is your server directory located?"
 echo -e "$PREFIX e.g. /opt/paper or /home/myserver/server"
 echo -e "$PREFIX Your server directory:"
;;
2)
 echo -e "$PREFIX Wo ist oder soll dein Serverordner sich befinnden?"
 echo -e "$PREFIX z.b. /opt/paper oder /home/meinserver/server"
 echo -e "$PREFIX Und wo ist oder soll der Ordner sein:"
;;
*)
 echo "Please select a language" && exit 1
;;
esac
{
echo -n -e " "
read -r DCI;
}
DICTY=$(echo "$DCI" | sed 's/\/$//')
mkdir -p "$DICTY"/mcsys/configs
mkdir -p "$DICTY"/unused
cd "$DICTY"/mcsys/configs || exit 1
if ! command -v wget &> /dev/null; then apt-get install wget -y >/dev/null 2>&1
fi
case $LANG in
1)
  echo -e "$PREFIX Great! I will prepare the configuration now. Please wait..."
  wget -q https://github.com/$IFCREATEDFORK/raw/main/api/v2/assets/mcsys_en.yml -O mcsys.yml
  wget -q https://raw.githubusercontent.com/$IFCREATEDFORK/main/api/v2/messages/messages_en.lang -O messages.lang
;;
2)
  echo -e "$PREFIX Okay! die Konfiguration wird vorbereitet. Bitte warten..."
  wget -q https://github.com/$IFCREATEDFORK/raw/main/api/v2/assets/mcsys_de.yml -O mcsys.yml
  wget -q https://raw.githubusercontent.com/$IFCREATEDFORK/main/api/v2/messages/messages_en.lang -O messages.lang
;;
esac
wget -q https://raw.githubusercontent.com/$IFCREATEDFORK/main/api/v2/assets/variables.sh
chmod +x variables.sh
cd "$DICTY"/mcsys || exit 1
wget -q https://raw.githubusercontent.com/$IFCREATEDFORK/main/api/v2/main/restart.sh
wget -q https://raw.githubusercontent.com/$IFCREATEDFORK/main/api/v2/main/start.sh
wget -q https://raw.githubusercontent.com/$IFCREATEDFORK/main/api/v2/main/stop.sh
chmod +x ./*.sh
cd "$DICTY" || exit 1
wget -q https://raw.githubusercontent.com/$IFCREATEDFORK/main/api/v2/assets/manage.tool
chmod +x manage.tool
case $LANG in
1)
  echo -e "$PREFIX Setup finished!"
  echo -e "$PREFIX Open Configuration..."
;;
2)
  echo -e "$PREFIX Fertig mit dem Aufsetzten!"
  echo -e "$PREFIX Hier kommt die Konfiguration..."
;;
esac
# Install dependencys
if ! command -v joe &> /dev/null; then apt-get install joe -y &> /dev/null
fi
if ! command -v screen &> /dev/null; then apt-get install screen -y &> /dev/null
fi
if ! command -v sudo &> /dev/null; then apt-get install sudo -y &> /dev/null
fi
if ! command -v zip &> /dev/null; then apt-get install zip -y &> /dev/null
fi
if ! command -v xargs &> /dev/null; then apt-get install findutils -y &> /dev/null
fi
if ! command -v diff &> /dev/null; then apt-get install diffutils -y &> /dev/null
fi
if ! command -v rpl &> /dev/null; then apt-get install rpl -y &> /dev/null
fi
sed -i "s:opt/.*:$DICTY:g" $DICTY/mcsys/configs/mcsys.yml >/dev/null 2>&1
joe "$DICTY"/mcsys/configs/mcsys.yml
cd "$DICTY" || exit 1
# download counter
wget -q https://github.com/Argantiu/.github/releases/download/v3.0/mcstats.yml && rm mcstats.yml
