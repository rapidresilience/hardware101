#!/bin/sudo bash

#Change to dark mode
echo "Modifying settings"
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

#Update and install toosl
echo "Installing tools"
sudo -u root apt-get update && apt-get -y install minicom screen wget git udev cmake build-essential g++ libusb-1.0-0-dev qtbase5-dev qttools5-dev pkgconf

#Installing Salea Logic
echo "Installing Salea Logic"
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
