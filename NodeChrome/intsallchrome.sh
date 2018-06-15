#!/bin/bash

CHROME_VERSION=55.0.2883.75

#============================================                                                                                                     
# 下载 安装 Google Chrome                                                                                                                           
#============================================                                                                                                     
sudo wget -q http://www.slimjetbrowser.com/chrome/lnx/chrome64_${CHROME_VERSION}.deb

# 更新一次
sudo apt-get update -y
sudo dpkg -i chrome64_${CHROME_VERSION}.deb  >/dev/null  2>&1
# 修复
sudo apt-get -f install -qqy
sudo dpkg -i chrome64_${CHROME_VERSION}.deb
