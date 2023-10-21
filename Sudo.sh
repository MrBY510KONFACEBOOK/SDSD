#!/bin/bash

# Add a new user
sudo adduser abdellah

# Set password for the new user
echo "abdellah:strong_password" | sudo chpasswd

# Install OpenSSH server
sudo apt-get update
sudo apt-get install -y openssh-server

# Enable SSH server
sudo systemctl enable ssh
sudo systemctl start ssh

# Install ngrok
sudo wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
sudo unzip ngrok-stable-linux-amd64.zip -d /usr/local/bin

# Set up ngrok tunnel for SSH
ngrok authtoken 2WalQDUadTNZL96t2jyT1TnTc4R_3VvFJNu3CB8an7DxoCpoP
ngrok tcp 22

# Display ngrok SSH tunnel information
echo "Connect to your SSH tunnel using the following ngrok address:"
curl http://localhost:4040/api/tunnels | jq '.tunnels[0].public_url'

# Keep the script running to maintain the ngrok tunnel
while true; do sleep 1d; done
