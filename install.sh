#!/usr/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
NC='\033[0m' # No Color

#Change to dark mode
echo -e -n "${YELLOW}Modifying settings${NC} ... "
#gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
echo -e "${GREEN}Done${NC}"
#To Do:

sudo su - <<EOF
#Update and install toosl

echo -e -n "${YELLOW}Installing minicom, screen, hexedit, xxd, binwalk, strings and flashrom${NC} ... "
sleep 2s
apt-get update 2>&1 > /dev/null && apt-get -y install minicom screen wget git udev cmake build-essential g++ libusb-1.0-0-dev qtbase5-dev qttools5-dev pkgconf file zsh hexedit xxd binutils binwalk flashrom git-core fonts-powerline 2>&1 > /dev/null
echo -e "${GREEN}Done${NC}"
EOF

#wget https://raw.githubusercontent.com/rapidresilience/ohmyzsh/master/tools/install.sh
#REPO=rapidresilience/ohmyzsh sh install.sh

#Installing Salea Logic
if ! [ -x "$(command -v logic)" ]; then
echo -e -n "${YELLOW}Installing Salea Logic${NC} ... "
sleep 2s
mkdir ~/tools && cd ~/tools
wget -q https://downloads.saleae.com/logic2/Logic-2.4.14-linux-x64.AppImage
chmod +x Logic-2.4.14-linux-x64.AppImage
./Logic-2.4.14-linux-x64.AppImage --appimage-extract 2>&1 > /dev/null
mv squashfs-root/ salealogic
rm ./Logic-2.4.14-linux-x64.AppImage
chown -R $(id -u):$(id -g) salealogic

touch ~/Desktop/Logic.desktop
cat > ~/Desktop/Logic.desktop <<EOL
[Desktop Entry]
Name=Logic
Exec=~/tools/salealogic/Logic --no-sandbox
Terminal=false
Type=Application
Icon=~/tools/salealogic/Logic.png
StartupWMClass=Logic
X-AppImage-Version=2.4.14
Comment=Debug hardware like a pro
Categories=Utility
X-UnityGenerated=true
EOL

cat ~/tools/salealogic/resources/linux-x64/99-SaleaeLogic.rules | sudo tee /etc/udev/rules.d/99-SaleaeLogic.rules > /dev/null

#sudo su <<EOF
#ln -s /home/$USER/tools/salealogic/Logic /usr/bin/logic
#sudo chmod ugo+x /usr/bin/logic
#EOF
echo -e "${GREEN}Done${NC}"
fi

#Installing IMS Programmer
if ! [ -x "$(command -v IMSProg)" ]; then
echo -e -n "${YELLOW}Installing IMS Programmer${NC} ... "
sleep 2s
git clone --quiet https://github.com/rapidresilience/IMSProg.git 2>&1 > /dev/null && cd IMSProg
sudo su <<EOF
./build_all.sh 2>&1 > /dev/null && cd .. && rm -rf IMSProg
EOF
echo -e "${GREEN}Done${NC}"
fi

#Installing cyberchef
echo -e -n "${YELLOW}Installing Cyberchef${NC} ... "
sleep 2s
sudo su <<EOF
cd ~ && snap install cyberchef
EOF
echo -e "${GREEN}Done${NC}"
