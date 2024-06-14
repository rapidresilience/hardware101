#!/bin/sudo bash

#Change to dark mode
echo "Modifying settings"
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

#To Do:

sudo su - <<EOF
#Update and install toosl
echo "Installing minicom, screen, hexedit, xxd, binwalk, strings and flashrom"
sleep 2s
apt-get update && apt-get -y install minicom screen wget git udev cmake build-essential g++ libusb-1.0-0-dev qtbase5-dev qttools5-dev pkgconf file zsh hexedit xxd binutils binwalk flashrom git-core fonts-powerline
EOF

#wget https://raw.githubusercontent.com/rapidresilience/ohmyzsh/master/tools/install.sh
#REPO=rapidresilience/ohmyzsh sh install.sh

#Installing Salea Logic
if ! [ -x "$(command -v logic)" ]; then
echo "Installing Salea Logic"
sleep 2s
mkdir ~/tools && cd ~/tools
wget https://downloads.saleae.com/logic2/Logic-2.4.14-linux-x64.AppImage
chmod +x Logic-2.4.14-linux-x64.AppImage
./Logic-2.4.14-linux-x64.AppImage --appimage-extract
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

cat ~/tools/salealogic/resources/linux-x64/99-SaleaeLogic.rules | sudo tee /etc/udev/rules.d/99-SaleaeLogic.rules > /dev/null && echo "finished installing /etc/udev/rules.d/99-SaleaeLogic.rules"

#sudo su <<EOF
#ln -s /home/$USER/tools/salealogic/Logic /usr/bin/logic
#sudo chmod ugo+x /usr/bin/logic
#EOF

fi

#Installing IMS Programmer
if ! [ -x "$(command -v IMSProg)" ]; then
echo "Installing IMS Programmer"
sleep 2s
git clone https://github.com/rapidresilience/IMSProg.git && cd IMSProg
sudo su <<EOF
./build_all.sh && cd .. && rm -rf IMSProg
EOF
fi

#Installing cyberchef
echo "Installing Cyberchef"
sleep 2s
sudo su <<EOF
snap install cyberchef
EOF
