#!/bin/bash

# Create a new user 'abdellah' with password '123456'
sudo useradd -m -p $(openssl passwd -1 123456) abdellah
sudo usermod -aG sudo abdellah

# Install OpenSSH server
sudo apt-get install -y openssh-server

# Allow password authentication in SSH
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo service ssh restart

# Install Chrome Remote Desktop
sudo apt update
sudo wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes --fix-broken

# Install Desktop Environment (XFCE)
sudo apt install --assume-yes xfce4 desktop-base xfce4-terminal
sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'
sudo apt remove --assume-yes gnome-terminal
sudo apt install --assume-yes xscreensaver
sudo systemctl disable lightdm.service

# Install Google Chrome
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg --install google-chrome-stable_current_amd64.deb
sudo apt install --assume-yes --fix-broken

# Set up Chrome Remote Desktop for the user 'abdellah'
CRP="DISPLAY= /opt/google/chrome-remote-desktop/start-host --code=\"4/0AfJohXmt_RAPDFfiqOul-lOkuPAry1-pjni9Yyrm3yGei2RXN2Z8CfSMwWQBPQg_0ncU7A\" --redirect-url=\"https://remotedesktop.google.com/_/oauthredirect\" --name=$(hostname)"
Pin=123456

sudo adduser abdellah chrome-remote-desktop
sudo su - abdellah -c "${CRP} --pin=${Pin}"
sudo service chrome-remote-desktop start

echo "User 'abdellah' created with password '123456', sudo privileges, and Chrome Remote Desktop set up."
