#!/bin/bash

# This script was used to setup a machine running Ubuntu 20.04.3 LTS
cd $HOME
# install requirements
sudo apt update
sudo apt upgrade -y
sudo apt install build-essential apache2 firefox git snapd python3-pip unzip -y
sudo snap install go --channel=1.16/stable --classic

# download measurement tools
git clone https://github.com/Lucapaulo/dns-measurements.git
git clone https://github.com/mgranderath/misc-dns-measurements.git

# install tools
cd ${HOME}/dns-measurements
sudo go build main.go

cd ${HOME}/misc-dns-measurements
sudo go build main.go

# start apache webserver that explains our intentions
cd $HOME
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1-BMq3uhJV2vTbq-uRXgZSMGliN227l8F' -O index.html
sudo mv index.html /var/www/html/index.html
sudo systemctl restart apache2

# Have hostname in hosts file just in case
echo "127.0.1.1 $(hostname)" | sudo tee -a /etc/hosts
# Install modified dnsproxy
git clone https://github.com/Lucapaulo/dnsproxy.git
cd dnsproxy
go build -mod=vendor

# Download web performance scripts and install requirements
cd $HOME
git clone https://github.com/Lucapaulo/web-performance.git
cd web-performance
sudo pip install -r requirements.txt

# install geckodriver for selenium with firefox
cd $HOME
GECKO_VER="0.30.0"
wget "https://github.com/mozilla/geckodriver/releases/download/v${GECKO_VER}/geckodriver-v${GECKO_VER}-linux64.tar.gz"
sudo tar -xvf "geckodriver-v${GECKO_VER}-linux64.tar.gz"
sudo rm "geckodriver-v${GECKO_VER}-linux64.tar.gz"
sudo mv geckodriver /usr/local/bin/
sudo chmod +x /usr/local/bin/geckodriver

# install chromedriver for selenium with chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y
sudo rm ./google-chrome-stable_current_amd64.deb
cv=$(google-chrome --version)
cv=${cv#Google Chrome *}
cv=$(echo $cv | xargs)
wget https://chromedriver.storage.googleapis.com/${cv}/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
rm chromedriver_linux64.zip
sudo mv chromedriver /usr/bin/chromedriver
sudo chown root:root /usr/bin/chromedriver
sudo chmod +x /usr/bin/chromedriver

# verify that Python is installed
python3 --version

cd $HOME
