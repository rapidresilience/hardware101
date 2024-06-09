#!/bin/sudo bash

#Change to dark mode
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

apt-get -y install minicom screen wget

#Installing Salea Logic
mkdir ~/tools && cd ~/tools
wget https://downloads.saleae.com/logic2/Logic-2.4.14-linux-x64.AppImage
chmod +x Logic-2.4.14-linux-x64.AppImage
mv squashfs-root/ salealogic
rm ./Logic-2.4.14-linux-x64.AppImage

cat > ~/Desktop/Logic.desktop <<EOL
[Desktop Entry]
Name=Logic
Exec=$HOME/tools/salealogic/Logic --no-sandbox
Terminal=false
Type=Application
Icon=$HOME/tools/salealogic/Logic.png
StartupWMClass=Logic
X-AppImage-Version=2.4.14
Comment=Debug hardware like a pro
Categories=Utility
X-UnityGenerated=true
EOL
